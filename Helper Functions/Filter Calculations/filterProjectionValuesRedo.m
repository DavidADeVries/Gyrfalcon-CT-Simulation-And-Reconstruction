function filteredProjectionValues = filterProjectionValuesRedo(projectionValues, filter, applyRampFilter, applyBandlimiting, detectorSpacingInM)
% filteredProjectionValues = filterProjectionValues(projectionValues, filter, applyRampFilter, applyBandlimiting, detectorSpacingInM)
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
order = 2^nextpow2(2*len-1);

% STEP 2: ZERO PAD AND FFT OF PROJECTION VALUES
% projectionValuesZP = zeroPad(projectionValues, order);
% 
% projectionFFT = ifftshift(fft(fftshift(projectionValuesZP)));

% STEP 3: CREATE AND ZERO PAD RAMP FILTER, THEN CREATE FFT OF FILTER
if ~applyRampFilter
    filtImpRespZP = ones(1, order) .* (1/(2*detectorSpacingInM));
else
    n = 0:ceil(len/2); % 'order' is always even.
    filtImpResp = zeros(1,ceil(len/2)+1); % 'filtImpResp' is the bandlimited ramp's impulse response (values for even n are 0)
    filtImpResp(1) = 1/(4.*(detectorSpacingInM.^2)); % Set the DC term
    filtImpResp(2:2:end) = -1./((pi.*n(2:2:end).*detectorSpacingInM).^2); % Set the values for odd n
    filtImpResp(order/2) = 0;
    filtImpResp = [filtImpResp filtImpResp(end-1:-1:2)];
    filt = fft(filtImpResp);
    filt = filt(1:(order/2)+1);
end

filt = [filt' ; filt(end-1:-1:2)'];

temp = fftshift(filt);



% STEP 4: CREATE WINDOW

w = 2*pi*(0:size(filt,1)-1)/order;   % frequency axis up to Nyquist
w = w';

if applyBandlimiting
    temp(w-pi < -1/(2*detectorSpacingInM)) = 0;
    temp(w-pi > 1/(2*detectorSpacingInM)) = 0;
end

filt = ifftshift(temp);

switch filter
    case FirstGenFilterTypes.none
        % do nothing
    case FirstGenFilterTypes.sheppLoganFilter
        % be careful not to divide by 0:
        filt(2:end) = filt(2:end) .* (sin(w(2:end))./(w(2:end)));
    case FirstGenFilterTypes.cosineFilter
        filt(2:end) = filt(2:end) .* cos(w(2:end));
    case FirstGenFilterTypes.hammingWindowFilter
        filt(2:end) = filt(2:end) .* (.54 + .46 * cos(w(2:end)));
    case FirstGenFilterTypes.hannWindowFilter
        filt(2:end) = filt(2:end) .*(1+cos(w(2:end))) / 2;
    otherwise
        error(message('images:iradon:invalidFilter'))
end


% STEP 5: CONVOLVE AND IFFT
len = length(projectionValues);
projectionValues(length(filt),1) = 0;

convolvedFFT = fft(projectionValues) .* filt;

filteredProjectionValuesZP = detectorSpacingInM^2 * ifft(convolvedFFT, 'symmetric');
filteredProjectionValuesZP(len+1:end) = [];
filteredProjectionValues = filteredProjectionValuesZP;


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