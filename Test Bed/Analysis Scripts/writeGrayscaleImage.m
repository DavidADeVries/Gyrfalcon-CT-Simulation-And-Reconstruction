function [] = writeGrayscaleImage(image, window, path)
%function [] = writeGrayscaleImage(image, window, path)

imwrite(...
    applyContrastToMaximizeGrayscale(image, window, 1),...
    path);

end

