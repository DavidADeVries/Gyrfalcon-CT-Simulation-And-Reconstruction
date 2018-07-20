function [] = createManualCatheterMaskCoords(volume, numCatheters, bounds, writePath)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

slices = [28, 78, 128, 178, 228];

coords = zeros(length(slices), 3, numCatheters);

for i=1:length(slices)
    imshow(volume(:,:,slices(i)), bounds, 'InitialMagnification', 'fit');
    
    [x, y] = ginput(numCatheters);
    
    coords(i, 3, :) = slices(i);
    
    coords(i, 1, :) = x;
    coords(i, 2, :) = y;
end

save(writePath, 'coords');

end

