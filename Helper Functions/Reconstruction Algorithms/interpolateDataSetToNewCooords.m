function newDataSet = interpolateDataSetToNewCooords(oldDataSet, oldLocationInM, oldVoxelDimsInM, oldDims, newLocationInM, newVoxelDimsInM, newDims, interpolationType3D)
% newDataSet = interpolateDataSetToNewCooords(oldDataSet, oldLocationInM, oldVoxelDimsInM, oldDims, newLocationInM, newVoxelDimsInM, newDims, interpolationType3D)

[oldX, oldY, oldZ] = getVoxelCentreAndEndEdgeCoordinates(oldLocationInM, oldVoxelDimsInM, oldDims);

[meshOldX, meshOldY, meshOldZ] = meshgrid(oldX, oldY, oldZ);

% since we get the voxel centres AND edge coords of the outermost voxels
% (this is to provide a hard boundary for the interpolation range), we need
% to give these edge coords a value by padding the array with duplicated
% values on all sides
oldDataSet = padarray(oldDataSet, [1, 1, 1], 'replicate');

% these are the coords we want values at
[newX, newY, newZ] = getVoxelCentreCoordinates(newLocationInM, newVoxelDimsInM, newDims);

[meshNewX, meshNewY, meshNewZ] = meshgrid(newX, newY, newZ);

% set values outside of the interpolation range to NaN
valForPointsBeyondRange = NaN;

newDataSet = interp3(...
        meshOldX, meshOldY, meshOldZ, oldDataSet,...
        meshNewX, meshNewY, meshNewZ,...
        interpolationType3D.getMatlabString(), valForPointsBeyondRange);

end

