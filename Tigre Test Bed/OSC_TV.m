function [ f ] = OSC_TV(app, projRef, projData, geo, angles, maxiter, useRayRejection, catheterMapLoadPath, varargin)
%

%% Parse Inputs
[nIterTV,c,initialBlockSize,finalBlockSize,blockSizeReductionPower,OrderStrategy] = parse_inputs(...
    projData,geo,angles,varargin);


if ~isfield(geo,'rotDetector')
    geo.rotDetector=[0;0;0];
end


%% Create weighting matrices for the SART step
% the reason we do this, instead of calling the SART fucntion is not to
% recompute the weights every ASD-POCS iteration, thus effectively doubling
% the computational time


% Initialize image at 0.1cm
f = 0.001 .* ones(geo.nVoxel','single');

stop_criteria = 0;
iter = 0;
offOrigin = geo.offOrigin;
offDetector = geo.offDetector;
rotDetector = geo.rotDetector;

changeRange = [1 0];

if useRayRejection
    if exist(catheterMapLoadPath, 'file') == 2 % if file exists, load it up!
        loadData = load(catheterMapLoadPath);
        
        catheterMaps = loadData.catheterMaps;
        cathLoc = loadData.cathLoc;
    else
        catheterMaps = findCatheterMaps(projRef, projData);
        
        cathMapDilateSmall = zeros(size(catheterMaps));
        
        for i=1:size(catheterMaps,3)
            catheterMaps(:,:,i) = bwareaopen(catheterMaps(:,:,i), 5000);
            cathMapDilateSmall(:,:,i) = imdilate(catheterMaps(:,:,i),ones(7));
        end
        
        cathLoc = Atb(single(~cathMapDilateSmall), geo, angles) < 5;
        
        
        for i=1:size(cathLoc,3)
            cathLoc(:,:,i) = bwareaopen(cathLoc(:,:,i), 3, 8);
        end
        
        cathMapsForwardProj = Ax(single(cathLoc),geo,angles);
        cathMapsForwardProj = cathMapsForwardProj ~= 0;
        
        catheterMaps = (cathMapsForwardProj) | (cathMapDilateSmall);
        
        % save it to the path for future use
        save(catheterMapLoadPath, 'catheterMaps', 'cathLoc');
    end    
end

while ~stop_criteria %OSC-TV
    iter=iter+1;
    
    % update status output
    string = ['   Iteration: ', num2str(iter), '/', num2str(maxiter)];
    newLine = true;
        
    updateStatusOutput(app, string, newLine);
    
    % calculate!
    f0 = f; % save last f
    
    % first order the projection angles
    blocksize = computeBlockSize(initialBlockSize, finalBlockSize, blockSizeReductionPower, iter, maxiter);
    
    remain = mod(length(angles), blocksize);
    
    if remain == 0
        changeRange = [1 0];
    else
        changeRange(2) = changeRange(2) + remain;
        
        if changeRange(2) > length(angles)
            changeRange = [1 0];
            changeRange(2) = changeRange(2) + remain;
        end
    end
    
    [alphablocks,orig_index] = order_subsets(angles,blocksize,OrderStrategy, changeRange);
    
    sumOfErrors = 0;
    
    for jj=1:length(alphablocks)
        % Get offsets
        if size(offOrigin,2)==length(angles)
            geo.offOrigin=offOrigin(:,orig_index{jj});
        end
        if size(offDetector,2)==length(angles)
            geo.offDetector=offDetector(:,orig_index{jj});
        end
        if size(rotDetector,2)==length(angles)
            geo.rotDetector=rotDetector(:,orig_index{jj});
        end
        
        eProj = Ax(f,geo,alphablocks{jj});%,'ray-voxel');        
        
        errors = projRef(:,:,orig_index{jj}).*exp(-eProj) - projData(:,:,orig_index{jj});
          
        if useRayRejection
            errors(catheterMaps(:,:,orig_index{jj})) = 0;
        end
        
        sumOfErrors = sumOfErrors + sum(sum(sum(abs(errors))));

        % Calculate OSC step using TIGRE Atb function
        f = f + (f .*  ...
            (length(alphablocks{jj}) ./ length(alphablocks{1})) .* ...
            Atb(errors, geo, alphablocks{jj}) ./...
            (Atb(eProj.*projRef(:,:,orig_index{jj}).*exp(-eProj), geo, alphablocks{jj})));
        
        
        % Non-negativity constrain
        f = max(f,1e-8);
      
    end
    
    geo.offDetector = offDetector;
    geo.offOrigin = offOrigin;
    geo.rotDetector = rotDetector;
    
    dp_vec = (f - f0);
    dp = im3Dnorm(dp_vec,'L2');

    if iter ~= 1          
            tvConstant =  c * dp;
                
        %  TV MINIMIZATION
        % =========================================================================
        %  Call GPU to minimize TV
        f = minimizeTV2(f, tvConstant, nIterTV);    %   This is the MATLAB CODE, the functions are sill in the library, but CUDA is used nowadays
    end
    
    % update status output
    string = [' (e=', num2str(sumOfErrors/numel(projRef)), ', dp=', num2str(dp), ')'];
    newLine = false;
        
    updateStatusOutput(app, string, newLine);

    if iter >= maxiter        
        stop_criteria = true;
        
        for i=1:maxiter
            removeLastLineOfStatusOutput(app);
        end
    end    
end

if useRayRejection
    f(cathLoc) = 0;
end

end

function [nIterTV,c,initialBlockSize,finalBlockSize,blockSizeReductionPower,OrderStrategy] = parse_inputs(proj,geo,angles,argin)

opts=     {'tviter','c','initialblocksize','finalblocksize','blocksizereductionpower','orderstrategy'};

defaults=ones(length(opts),1);
% Check inputs
nVarargs = length(argin);
if mod(nVarargs,2)
    error('OSC_TV:InvalidInput','Invalid number of inputs')
end

% check if option has been passed as input
for ii=1:2:nVarargs
    ind=find(ismember(opts,lower(argin{ii})));
    if ~isempty(ind)
        defaults(ind)=0;
    else
        error('OSC_TV:InvalidInput',['Optional parameter "' argin{ii} '" does not exist' ]);
    end
end

for ii=1:length(opts)
    opt=opts{ii};
    default=defaults(ii);
    % if one option isnot default, then extract value from input
    if default==0
        ind=double.empty(0,1);jj=1;
        while isempty(ind)
            ind=find(isequal(opt,lower(argin{jj})));
            jj=jj+1;
        end
        if isempty(ind)
            error('OSC_TV:InvalidInput',['Optional parameter "' argin{jj} '" does not exist' ]);
        end
        val=argin{jj};
    end
    % parse inputs
    switch opt
        
            % Number of iterations of TV
            %  =========================================================================
        case 'tviter'
            if default
                nIterTV=20;
            else
                nIterTV=val;
            end
            %  TV hyperparameter c
            %  =========================================================================
        case 'c'
            if default
                c=0.2; % 0.2
            else
                c=val;
            end
            %  Initial block size for OS-SART
            %  =========================================================================
        case 'initialblocksize'
            if default
                initialBlockSize=20;
            else
                if length(val)>1 || ~isnumeric( val)
                    error('OSC_TV:InvalidInput','Invalid BlockSize')
                end
                initialBlockSize=val;
            end
            %  Final block size for OS-SART
            %  =========================================================================
        case 'finalblocksize'
            if default
                finalBlockSize=2;
            else
                if length(val)>1 || ~isnumeric( val)
                    error('OSC_TV:InvalidInput','Invalid BlockSize')
                end
                finalBlockSize=val;
            end
            %  Block size reduction power for OS-SART
            %  =========================================================================
        case 'blocksizereductionpower'
            if default
                blockSizeReductionPower=0.5;
            else
                if length(val)>1 || ~isnumeric( val)
                    error('OSC_TV:InvalidInput','Invalid Block Size Reduction Power')
                end
                blockSizeReductionPower=val;
            end
            %  Order strategy
            %  =========================================================================
        case 'orderstrategy'
            if default
                OrderStrategy='angularDistance';
            else
                OrderStrategy=val;
            end       
        otherwise
            error('OSC_TV:InvalidInput',['Invalid input name:', num2str(opt),'\n No such option']);
            
    end
end

end

function blockSize = computeBlockSize(S_i, S_f, p, n, n_max)
    n = n-1; % re-index with iteration 1 as n = 0
    
    blockSize = round( ((S_i - S_f) / ((n_max - 1)^p)) * ((n_max-1-n)^p) + S_f);
end

function catheterMaps = findCatheterMaps(projRef, projData)
    catheterMaps = false(size(projData));
    
   % catheterMaps(:,70:630,:) = (projData(:,70:630,:) < 10000) | (projRef(:,70:630,:) < 10000);
    catheterMaps(:,70:630,:) =  projRef(:,70:630,:) < 15000;
    
end

function f = setCatheterPixels(f, catheterLoc)   

    f(catheterLoc) = 0;

    sample = zeros(size(f)+2, 'single');
    
    cond = true;
    
    
    
    while cond    
        sample(2:end-1,2:end-1,2:end-1) = f;
        
        upX = sample(1:end-2, 2:end-1, 2:end-1);
        dnX = sample(3:end, 2:end-1, 2:end-1);
        
        upY = sample(2:end-1, 1:end-2, 2:end-1);
        dnY = sample(2:end-1, 3:end, 2:end-1);
        
        upZ = sample(2:end-1, 2:end-1, 1:end-2);
        dnZ = sample(2:end-1, 2:end-1, 3:end);
        
        sums = upX + dnX + upY + dnY + upZ + dnZ;
        div = (upX ~= 0) + (dnX ~= 0) + (upY ~= 0) + (dnY ~= 0) + (upZ ~= 0) + (dnZ ~= 0);
        ave = sums ./ div;
        
        f(catheterLoc & div >= 2) = ave(catheterLoc & div >= 2);
        
        % stop condition
        cond = sum(sum(sum(f(catheterLoc)==0))) ~= 0;
    end
end