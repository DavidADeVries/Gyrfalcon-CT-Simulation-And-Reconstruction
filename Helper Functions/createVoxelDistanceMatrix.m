function voxelDistanceMatrix = createVoxelDistanceMatrix(phantomLocation, phantomVoxelDims, linePhantomIntersectionPoints, phantomData)
% voxelDistanceMatrix = createVoxelDistanceMatrix(linePhantomIntersectionPoints, phantomData)

voxelDistanceMatrix = zeros(size(phantomData));

numIntersectionPoints = length(linePhantomIntersectionPoints);

for i=2:numIntersectionPoints
    startPoint = linePhantomIntersectionPoints(i-1,:);
    endPoint = linePhantomIntersectionPoints(i,:);
    
    averPoint = mean([startPoint; endPoint]); %this a point located within the voxel we're interested in

    phantX = phantomLocation(1);
    phantY = phantomLocation(2);
    phantZ = phantomLocation(3);
    
    phantDelX = phantomVoxelDims(1);
    phantDelY = phantomVoxelDims(2);
    phantDelZ = phantomVoxelDims(3);
    
    xIndex = ceil((averPoint(1) - phantX) ./ phantDelX);
    yIndex = ceil((averPoint(2) - phantY) ./ -phantDelY);
    zIndex = ceil((averPoint(3) - phantZ) ./ -phantDelZ);
    
    voxelDistanceMatrix(yIndex, xIndex, zIndex) = norm(endPoint - startPoint);
end


end

