function [volumeOut] = transformVolume(volumeIn)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

tformMatrix = [...
    0.8 0.6 -0.01 0;
    -0.6 0.8 0 0;
    0 0.01 1 0;
    0 0 0 1];

translate = [89.77 -113.61 -90.14];

ra = imref3d(size(volumeIn), [0.25, 63.75], [0.25, 63.75], [0.25, 63.75]);

tform = affine3d(tformMatrix);

[volumeOut] = imwarp(volumeIn, tform);

end

