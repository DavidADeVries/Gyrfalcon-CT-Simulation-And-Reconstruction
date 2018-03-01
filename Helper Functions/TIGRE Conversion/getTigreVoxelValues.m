function [nVoxel, dVoxel, sVoxel] = getTigreVoxelValues(phantomDimensions, voxelDimensionsInM)
%function [nVoxel, dVoxel, sVoxel] = getTigreVoxelValues(phantomDimensions, voxelDimensionsInM)

nVoxel = (phantomDimensions)';
nVoxel([1,2]) = nVoxel([2,1]);

dVoxel = (voxelDimensionsInM * Constants.m_to_mm)';
dVoxel([1,2]) = dVoxel([2,1]);

sVoxel = nVoxel .* dVoxel;

end

