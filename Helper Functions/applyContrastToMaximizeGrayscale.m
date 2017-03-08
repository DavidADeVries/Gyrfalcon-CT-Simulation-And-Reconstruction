function adjImage = applyContrastToMaximizeGrayscale(image, window, grayscaleMax)
% adjImage = applyContrastToMaximizeGrayscale(image, window, grayscaleMax)
% window gives the low and high end of the scale, in whichever units the
% image is in.
% the low end of the window will be mapped to 0, and the high end of the
% window goes to the grayscaleMax (usually 1 or 255)

if isempty(window)
    window(1) = min(min(image));
    window(2) = max(max(image));
end

low = window(1);
high = window(2);

belowLow = image < low;
aboveHigh = image > high;

adjImage = (image .* ~belowLow) + (belowLow .* low);
adjImage = (adjImage .* ~aboveHigh) + (aboveHigh .* high);

adjImage = adjImage - low; %minimum value guaranteed to be 0
adjImage = adjImage .* (grayscaleMax / (high-low)); % max value guaranteed to be grayscaleMax


end

