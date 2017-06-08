function distanceAcrossVoxel = fastRayTraceForGPU(pointSourceCoordsX, pointSourceCoordsY, pointSourceCoordsZ, pointDetectorCoordsX, pointDetectorCoordsY, pointDetectorCoordsZ, voxelBoundX, voxelBoundY, voxelBoundZ, deltaX, deltaY, deltaZ)
% attenuationForVoxel = fastRayTraceForGPU(pointSourceCoordsX, pointSourceCoordsY, pointSourceCoordsZ, pointDetectorCoordsX, pointDetectorCoordsY, pointDetectorCoordsZ, voxelBoundX1, voxelBoundX2, voxelBoundY1, voxelBoundY2, voxelBoundZ1, voxelBoundZ2)

distanceAcrossVoxel = 0;
missed = false;

bounds1X = voxelBoundX;
bounds1Y = voxelBoundY;
bounds1Z = voxelBoundZ;

bounds2X = voxelBoundX + deltaX;
bounds2Y = voxelBoundY + deltaY;
bounds2Z = voxelBoundZ + deltaZ;

deltaX = pointDetectorCoordsX - pointSourceCoordsY;
deltaY = pointDetectorCoordsY - pointSourceCoordsY;
deltaZ = pointDetectorCoordsZ - pointSourceCoordsZ;

tMin = (bounds1X - pointSourceCoordsX) / deltaX;
tMax = (bounds2X - pointSourceCoordsX) ./ deltaX;

tMinY = (bounds1Y - pointSourceCoordsY) / deltaY;
tMaxY = (bounds2Y - pointSourceCoordsY) ./ deltaY;

tMinZ = (bounds1Z - pointSourceCoordsZ) / deltaZ;
tMaxZ = (bounds2Z - pointSourceCoordsZ) ./ deltaZ;

if deltaX < 0
    temp = tMin;
    tMin = tMax;
    tMax = temp;
end

if deltaY < 0
    temp = tMinY;
    tMinY = tMaxY;
    tMaxY = temp;
end

if deltaZ < 0
    temp = tMinZ;
    tMinZ = tMaxZ;
    tMaxZ = temp;
end

if (tMin > tMaxY) || (tMinY > tMax)
    distanceAcrossVoxel = 0; %missed
    missed = true;
end

if tMinY > tMin
    tMin = tMinY;
end
if tMaxY < tMax
    tMax = tMaxY;
end

if (tMin > tMaxZ) || (tMinZ > tMax)
    distanceAcrossVoxel = 0; %missed
    missed = true;
end

if tMinZ > tMin
    tMin = tMinZ;
end
if tMaxZ < tMax
    tMax = tMaxZ;
end
     
if ~missed
    tDiff = tMax-tMin;
    x = tDiff * deltaX;
    y = tDiff * deltaY;
    z = tDiff * deltaZ;
    
    distanceAcrossVoxel = sqrt((x^2)+(y^2)+(z^2));
end

end

