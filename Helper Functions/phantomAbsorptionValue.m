function [absorptionVal, phantomCoords] = phantomAbsorptionValue(startPoint, endPoint, phantomData, phantomVoxelDims, phantomLocation)
% [absorptionVal, phantomCoords] = phantomAbsorptionValue(startPoint, endPoint, phantomData, phantomVoxelDims, phantomLocation)
% from the intersection points startPoint and endPoint

dims = size(phantomData);

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

xIndex = dims(2) - xIndex + 1;
yIndex = dims(1) - yIndex + 1;
zIndex = dims(3) - zIndex + 1;

absorptionVal = phantomData(yIndex, xIndex, zIndex); %have to flip x and y for the MATLAB (row,col,slice) convention
phantomCoords = [yIndex, xIndex, zIndex];

end

