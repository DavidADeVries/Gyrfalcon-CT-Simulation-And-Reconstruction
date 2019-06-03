function [slice] = getTransverseSlice(volume, sliceNum)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
slice = rot90(squeeze(volume(sliceNum,:,:)),3);

end

