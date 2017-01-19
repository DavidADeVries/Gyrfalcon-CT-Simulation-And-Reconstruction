function absorptionVal = phantomAbsorptionValue(startPoint, endPoint, phantomData, phantomVoxelDims, phantomLocation)
% absorptionVal = phantomAbsorptionValue(startPoint, endPoint, phantomData, phantomVoxelDims, phantomLocation)
% from the intersection points startPoint and endPoint

averPoint = mean([startPoint; endPoint]); %this a point located within the voxel we're interested in

phantX = phantomLocation(1);
phantY = phantomLocation(2);
phantZ = phantomLocation(3);
    
phantDelX = phantomVoxelDims(1);
phantDelY = phantomVoxelDims(2);
phantDelZ = phantomVoxelDims(3);

xIndex = floor((averPoint(1) - phantX) ./ phantDelX);
yIndex = ceil((averPoint(2) - phantY) ./ -phantDelY);
zIndex = ceil((averPoint(3) - phantZ) ./ -phantDelZ);

absorptionVal = phantomData(yIndex, xIndex, zIndex); %have to flip x and y for the MATLAB (row,col,slice) convention

end

