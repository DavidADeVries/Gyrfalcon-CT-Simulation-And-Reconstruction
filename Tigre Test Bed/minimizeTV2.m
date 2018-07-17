function  f = minimizeTV2(f, tvConstant, nIterTV)
    reset(gpuDevice);
    f_gpu = gpuArray(f);
    
    for i=1:nIterTV
%         if mod(i,2) == 0
            f_grad = tvGradient(f_gpu);
%         else
%             f_grad = tvGradient2(f_gpu);
%         end

        gradNorm = norm(f_grad(:),2);
        
        diff = (tvConstant .* f_grad / gradNorm);

%         figure(100+i);imshow(f_gpu(:,:,128),[]);

        f_gpu = f_gpu - diff;
    end

    f = gather(f_gpu);
    reset(gpuDevice);
end

function f_grad = tvGradient(f)
    dims = size(f);
    
    e = 10^-8;

    d = Inf;

    f_grad = zeros(dims,'gpuArray');
    
    s = 2:dims(1)-1;
    t = 2:dims(2)-1;
    u = 2:dims(3)-1;

    f_grad(2:end-1, 2:end-1, 2:end-1) = ...
        ((2.*exp(-((f(s,t,u) - f(s-1,t,u)) / d).^2).*(f(s,t,u) - f(s-1,t,u)) + 2.*exp(-((f(s,t,u) - f(s,t-1,u)) / d).^2).*(f(s,t,u) - f(s,t-1,u)) + 2.*exp(-((f(s,t,u) - f(s,t,u-1)) / d).^2).*(f(s,t,u) - f(s,t,u-1))) ./...
        sqrt( e +  exp(-((f(s,t,u) - f(s-1,t,u)) / d).^2).*(f(s,t,u) - f(s-1,t,u)).^2 + exp(-((f(s,t,u) - f(s,t-1,u)) / d).^2).*(f(s,t,u) - f(s,t-1,u)).^2 + exp(-((f(s,t,u) - f(s,t,u-1)) / d).^2).*(f(s,t,u) - f(s,t,u-1)).^2 )) - ...
        ( 2*exp(-((f(s+1,t,u) - f(s,t,u)) / d).^2).*(f(s+1,t,u)-f(s,t,u)) ./ sqrt(e + exp(-((f(s+1,t,u) - f(s,t,u)) / d).^2).*(f(s+1,t,u)-f(s,t,u)).^2 + exp(-((f(s+1,t,u) - f(s+1,t-1,u)) / d).^2).*(f(s+1,t,u)-f(s+1,t-1,u)).^2 + exp(-((f(s+1,t,u) - f(s+1,t,u-1)) / d).^2).*(f(s+1,t,u)-f(s+1,t,u-1)).^2 ) ) - ...
        ( 2*exp(-((f(s,t+1,u) - f(s,t,u)) / d).^2).*(f(s,t+1,u)-f(s,t,u)) ./ sqrt(e + exp(-((f(s,t+1,u) - f(s,t,u)) / d).^2).*(f(s,t+1,u)-f(s,t,u)).^2 + exp(-((f(s,t+1,u) - f(s-1,t+1,u)) / d).^2).*(f(s,t+1,u)-f(s-1,t+1,u)).^2 + exp(-((f(s,t+1,u) - f(s,t+1,u-1)) / d).^2).*(f(s,t+1,u)-f(s,t+1,u-1)).^2 ) ) - ...
        ( 2*exp(-((f(s,t,u+1) - f(s,t,u)) / d).^2).*(f(s,t,u+1)-f(s,t,u)) ./ sqrt(e + exp(-((f(s,t,u+1) - f(s,t,u)) / d).^2).*(f(s,t,u+1)-f(s,t,u)).^2 + exp(-((f(s,t,u+1) - f(s-1,t,u+1)) / d).^2).*(f(s,t,u+1)-f(s-1,t,u+1)).^2 + exp(-((f(s,t,u+1) - f(s,t-1,u+1)) / d).^2).*(f(s,t,u+1)-f(s,t-1,u+1)).^2 ) );
          
end

function f_grad = tvGradient2(f)
    dims = size(f);
    
    e = 10^-8;

    f_grad = zeros(dims,'gpuArray');
    
    s = 2:dims(1)-1;
    t = 2:dims(2)-1;
    u = 2:dims(3)-1;

    f_grad(2:end-1, 2:end-1, 2:end-1) = ...
        (((f(s,t,u) - f(s+1,t,u)) + (f(s,t,u) - f(s,t+1,u)) + (f(s,t,u) - f(s,t,u+1))) ./...
        sqrt( e +  (f(s,t,u) - f(s+1,t,u)).^2 + (f(s,t,u) - f(s,t+1,u)).^2 + (f(s,t,u) - f(s,t,u+1)).^2 )) - ...
        ( (f(s-1,t,u)-f(s,t,u)) ./ sqrt(e + (f(s-1,t,u)-f(s,t,u)).^2 + (f(s-1,t,u)-f(s-1,t+1,u)).^2 + (f(s-1,t,u)-f(s-1,t,u+1)).^2 ) ) - ...
        ( (f(s,t-1,u)-f(s,t,u)) ./ sqrt(e + (f(s,t-1,u)-f(s,t,u)).^2 + (f(s,t-1,u)-f(s+1,t-1,u)).^2 + (f(s,t-1,u)-f(s,t-1,u+1)).^2 ) ) - ...
        ( (f(s,t,u-1)-f(s,t,u)) ./ sqrt(e + (f(s,t,u-1)-f(s,t,u)).^2 + (f(s,t,u-1)-f(s+1,t,u-1)).^2 + (f(s,t,u-1)-f(s,t+1,u-1)).^2 ) );
          
end
