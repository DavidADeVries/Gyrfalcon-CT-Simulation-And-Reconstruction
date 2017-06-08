function [xCoords, yCoords, zCoords] = getVoxelCentreCoordinates(locationInM, voxelDimsInM, dims)
% [xCoords, yCoords, zCoords] = getVoxelCentreCoordinates(locationInM, voxelDimsInM, dims)
% gives coords in order starting a locationInM, proceeding to opposite
% corner

% NOTE: Remember that locationInM specifies the: left-most (x), top-most
% (y), top-most (z) point

dims = dims - 1; % this will be how many steps we take

xCoords = locationInM(1) + voxelDimsInM(1)/2 : voxelDimsInM(1) : locationInM(1) + voxelDimsInM(1)/2 + dims(1)*voxelDimsInM(1);
yCoords = locationInM(2) - voxelDimsInM(2)/2 : -voxelDimsInM(2) : locationInM(2) - voxelDimsInM(2)/2 - dims(2)*voxelDimsInM(2);
zCoords = locationInM(3) - voxelDimsInM(3)/2 : -voxelDimsInM(3) : locationInM(3) - voxelDimsInM(3)/2 - dims(3)*voxelDimsInM(3);

less0 = dims < 0;
voxDimsEq0 = voxelDimsInM == 0;

% if no dimensionality, set centre at location
if less0(1) || voxDimsEq0(1)
    xCoords = locationInM(1);
end

if less0(2) || voxDimsEq0(2)
    yCoords = locationInM(2);
end

if less0(3) || voxDimsEq0(3)
    zCoords = locationInM(3);
end

end

