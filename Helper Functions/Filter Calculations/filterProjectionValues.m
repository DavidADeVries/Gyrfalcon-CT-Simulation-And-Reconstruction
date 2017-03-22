function filteredProjectionValues = filterProjectionValues(projectionValues, filter, applyRampFilter, detectorSpacingInM)
% filteredProjectionValues = filterProjectionValues(projectionValues, filter, applyRampFilter, detectorSpacingInM)
% Mainly based on MATLAB code
%
% ***MATLAB CODE COMMENTS:***
%
% Returns the Fourier Transform of the filter which will be
% used to filter the projections
%
% INPUT ARGS:   filter - either the string specifying the filter
%               len    - the length of the projections
%               d      - the fraction of frequencies below the nyquist
%                        which we want to pass
%
% OUTPUT ARGS:  filt   - the filter to use on the projections


% STEP 1: DETERMINE ZERO PADDING AMOUNT
len = length(projectionValues);
order = 2^nextpow2(2*len - 1);

% STEP 2: ZERO PAD AND FFT OF PROJECTION VALUES
projectionValuesZP = zeroPad(projectionValues, order);

projectionFFT = ifftshift(fft(fftshift(projectionValuesZP)));

% STEP 3: CREATE AND ZERO PAD RAMP FILTER, THEN CREATE FFT OF FILTER
if ~applyRampFilter
    filtImpRespZP = ones(1, order) .* (1/(2*detectorSpacingInM));
else
    % First create a bandlimited ramp filter (Eqn. 61 Chapter 3, Kak and
    % Slaney) - go up to the next highest power of 2.
    
    filtHalfLength = ceil(len/2); % we'll zero-pad this later, so make as long as possible
    
    n = 0:1:filtHalfLength-1;
    
    filtImpResp = zeros(1, filtHalfLength);
    filtImpResp(1) = 1/(4*detectorSpacingInM^2); % Set the DC term
    filtImpResp(2:2:end) = -1./((pi^2)*(n(2:2:end).^2)*(detectorSpacingInM^2)); % Set the values for odd n
    % even values are 0! No need to set
    
    filtImpResp = [ filtImpResp(end-1:-1:2) filtImpResp]; % set the other half
    
    filtImpRespZP = zeroPad(filtImpResp, order);
end

rampFilterFFT = ifftshift(fft(fftshift(filtImpRespZP)));

% STEP 4: CREATE WINDOW

windowHalfLength = ceil(len/2); % we'll zero-pad this later, so make as long as possible

w = pi*(0:1:windowHalfLength-1)/(windowHalfLength-1); % frequency values for window

window = ones(1,windowHalfLength);

switch filter
    case 'ram-lak'
        % Do nothing
    case 'shepp-logan'
        % be careful not to divide by 0:
        window(2:end) = (sin(w(2:end))./(w(2:end)));
    case 'cosine'
        window = cos(w);
    case 'hamming'
        alpha = 0.54; %optimal value
        beta = 0.46; % optimal value
        
        window = hammingWindow(alpha, beta, w);
    case 'hann'
        alpha = 0.5;
        beta = 0.5;
        
        window = hammingWindow(alpha, beta, w);
    otherwise
        error('Invalid filter type');
end

window = [window(end-1:-1:2) window];

windowZP = zeroPad(window, order);

% STEP 5: CONVOLVE AND IFFT

convolvedFFT = projectionFFT .* rampFilterFFT .* windowZP;

filteredProjectionValuesZP = detectorSpacingInM^2 * ifftshift(ifft(fftshift(convolvedFFT), 'symmetric'));

filteredProjectionValues = removeZeroPad(filteredProjectionValuesZP, len);


end


function filtValues = hammingWindow(alpha,beta,w)
    filtValues = alpha + beta * cos(w);
end

function paddedValues = zeroPad(values, sizeToPadTo)
    dims = size(values);
    
    length = dims(2);
    
    paddedValues = zeros(1, sizeToPadTo);
    
    index = floor((sizeToPadTo - length) ./ 2)+1;
    
    paddedValues(index:index+length-1) = values;
end

function values = removeZeroPad(paddedValues, unpaddedSize)
    
    dims = size(paddedValues);
    
    length = dims(2);
    
    index = floor((length - unpaddedSize) ./ 2)+1;
    
    values = paddedValues(index:index+unpaddedSize-1);
end