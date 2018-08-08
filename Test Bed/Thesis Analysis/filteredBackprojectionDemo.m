function [] = filteredBackprojectionDemo()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

angles = 0:179;

head_orig = phantom(128);

head_radon = radon(head_orig, angles);

head_filtered = iradon(head_radon, angles);
head_unfiltered = iradon(head_radon, angles, 'linear', 'none');

point_orig = zeros(128,128);
point_orig(62:65,62:65) = 1;

point_radon = radon(point_orig, angles);

point_filtered = iradon(point_radon, angles);
point_unfiltered = iradon(point_radon, angles, 'linear', 'none');

root = 'E:\Thesis Figures\Theory\';

writeGrayscaleImage(head_orig, [0,1], [root, 'FBP - Head.png']);
writeGrayscaleImage(head_filtered, [0,1], [root, 'FBP - Head Filtered.png']);
writeGrayscaleImage(head_unfiltered, [min(min(head_unfiltered)),max(max(head_unfiltered))], [root, 'FBP - Head Unfiltered.png']);

writeGrayscaleImage(point_orig, [0,1], [root, 'FBP - Point.png']);
writeGrayscaleImage(point_filtered, [0,1], [root, 'FBP - Point Filtered.png']);
writeGrayscaleImage(point_unfiltered, [min(min(point_unfiltered)),max(max(point_unfiltered))], [root, 'FBP - Point Unfiltered.png']);

end

