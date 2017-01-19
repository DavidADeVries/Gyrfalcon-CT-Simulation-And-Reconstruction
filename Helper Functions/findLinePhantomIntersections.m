function linePhantomIntersectionPoints = findLinePhantomIntersections(lineDeltas, linePoint, startPoint, phantomLocation,  phantomVoxelDims, phantomData)
%linePhantomIntersectionPoints = findLinePhantomIntersections(lineDeltas, linePoint, startPoint, phantomLocation,  phantomVoxelDims, phantomData)
    
phantomDims = size(phantomData);

phantX = phantomLocation(1);
phantY = phantomLocation(2);
phantZ = phantomLocation(3);
    
phantDelX = phantomVoxelDims(1);
phantDelY = phantomVoxelDims(2);
phantDelZ = phantomVoxelDims(3);

phantNumX = phantomDims(2); %Yup these should be reversed, remember MATLAB does (rows, cols, slice) for size(), so (y,x,z)
phantNumY = phantomDims(1);
phantNumZ = phantomDims(3);

linePhantomIntersectionPoints = [];
linePhantomIntersectionPointNorms = []; 

counter = 1;

bounds = [...
    phantX, phantX + phantNumX*phantDelX;
    phantY - phantNumY*phantDelY, phantY;
    phantZ - phantNumZ*phantDelZ, phantZ];

% NOTE: phantomLocation

% Get YZ Plane Intersections

for i=1:phantNumX
    xVal = phantX + i*phantDelX;
    
    interceptPoint = interceptPointOfLineWithPlaneWithinBounds(linePoint, lineDeltas, xVal, 1, bounds);
    
    if ~isempty(interceptPoint)
        linePhantomIntersectionPoints(counter,:) = interceptPoint;
        linePhantomIntersectionPointNorms(counter,:) = norm(interceptPoint - startPoint); % we keep track of the norm so that we can order these intercepts from hit first to hit last later
        
        counter = counter + 1;
    end
end

% Get XZ Plane Intersections

for i=1:phantNumY
    yVal = phantY - i*phantDelY;
    
    interceptPoint = interceptPointOfLineWithPlaneWithinBounds(linePoint, lineDeltas, yVal, 2, bounds);
    
    if ~isempty(interceptPoint)
        linePhantomIntersectionPoints(counter,:) = interceptPoint;
        linePhantomIntersectionPointNorms(counter,:) = norm(interceptPoint - startPoint); % we keep track of the norm so that we can order these intercepts from hit first to hit last later
        
        counter = counter + 1;
    end
end

% Get XY Plane Intersections

for i=1:phantNumZ
    zVal = phantZ - i*phantDelZ;
    
    interceptPoint = interceptPointOfLineWithPlaneWithinBounds(linePoint, lineDeltas, zVal, 3, bounds);
    
    if ~isempty(interceptPoint)
        linePhantomIntersectionPoints(counter,:) = interceptPoint;
        linePhantomIntersectionPointNorms(counter,:) = norm(interceptPoint - startPoint); % we keep track of the norm so that we can order these intercepts from hit first to hit last later
        
        counter = counter + 1;
    end
end

% now sort and eliminate doubles/triples (if intersection occured at
% lattice point in voxel grid)

[~,sortedIndices,~] = unique(linePhantomIntersectionPointNorms);

linePhantomIntersectionPoints = linePhantomIntersectionPoints(sortedIndices,:);
    

end

