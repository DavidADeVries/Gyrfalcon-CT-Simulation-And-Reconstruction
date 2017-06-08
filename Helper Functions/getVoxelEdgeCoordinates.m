function [xCoords, yCoords, zCoords] = getVoxelEdgeCoordinates(locationInM, voxelDimsInM, dims)
% [xCoords, yCoords, zCoords] = getVoxelEdgeCoordinates(locationInM, voxelDimsInM, dims)
% gives coords in order starting a locationInM, proceeding to opposite
% corner

% NOTE: Remember that locationInM specifies the: left-most (x), top-most
% (y), top-most (z) point


xCoords = locationInM(1) : voxelDimsInM(1) : locationInM(1) + dims(1)*voxelDimsInM(1);
yCoords = locationInM(2) : -voxelDimsInM(2) : locationInM(2) - dims(2)*voxelDimsInM(2);
zCoords = locationInM(3) : -voxelDimsInM(3) : locationInM(3) - dims(3)*voxelDimsInM(3);

lessEq0 = dims <= 0;

% if no dimensionality, set centre at location
if lessEq0(1)
    xCoords = locationInM(1) * ones(1,2);
end

if lessEq0(2)
    yCoords = locationInM(2) * ones(1,2);
end

if lessEq0(3)
    zCoords = locationInM(3) * ones(1,2);
end

end

