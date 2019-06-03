function volume = loadGyrfalconReconForFigures(readPath, reconNum, usedFloodFields)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

[volumeGyr, ~] = loadGyrfalconVolume(readPath, reconNum, usedFloodFields);

volume = zeros(256,256,256);

volume(:,:,21:21+216-1) = volumeGyr;

end

