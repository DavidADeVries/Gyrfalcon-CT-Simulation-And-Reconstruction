function [ f ] = OSC_TV(app, projRef, projData, geo, angles, maxiter, varargin)
%

%% parse inputs
[nIterTV,c,initialBlockSize,finalBlockSize,blockSizeReductionPower,OrderStrategy] = parse_inputs(...
    projData,geo,angles,varargin);


if ~isfield(geo,'rotDetector')
    geo.rotDetector=[0;0;0];
end


%% Create weigthing matrices for the SART step
% the reason we do this, instead of calling the SART fucntion is not to
% recompute the weigths every ASD-POCS iteration, thus effectively doubling
% the computational time


% initialize image as FDK reconstruction
% f = FDK(log(projRef ./ projData), geo, angles);
% f = imgaussfilt3(f,5);
f = 0.01 .* ones(geo.nVoxel','single');

stop_criteria = 0;
iter = 0;
offOrigin = geo.offOrigin;
offDetector = geo.offDetector;
rotDetector = geo.rotDetector;

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
    [alphablocks,orig_index] = order_subsets(angles,blocksize,OrderStrategy);
    
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
        
                    
        eProj = Ax(f,geo,alphablocks{jj},'ray-voxel');
        
        errors = projRef(:,:,orig_index{jj}).*exp(-eProj) - projData(:,:,orig_index{jj});
        
        sumOfErrors = sumOfErrors + sum(sum(sum(abs(errors))));
        
        f = f + (f .*  ...
            (length(alphablocks{jj}) ./ length(alphablocks{1})) .* ...
            Atb(errors, geo, alphablocks{jj}) ./...
            (Atb(eProj.*projRef(:,:,orig_index{jj}).*exp(-eProj), geo, alphablocks{jj})));
        
        
        % Non-negativity constrain
        f = max(f,0);
    end
    
    
    %figure(100+iter);imshow(f(:,:,128),[0,0.1]);
    
    geo.offDetector = offDetector;
    geo.offOrigin = offOrigin;
    geo.rotDetector = rotDetector;
    
    dp_vec = (f - f0);
    dp = im3Dnorm(dp_vec,'L2');

    if iter ~= 1       
        tvConstant = c * dp;
                
        %  TV MINIMIZATION
        % =========================================================================
        %  Call GPU to minimize TV
        f = minimizeTV(f, tvConstant, nIterTV);    %   This is the MATLAB CODE, the functions are sill in the library, but CUDA is used nowadays
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

