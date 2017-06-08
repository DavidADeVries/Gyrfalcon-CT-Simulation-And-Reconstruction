function newLocation = calculateNewPhantomLocationForReconstruction(phantomLocationInM, phantomVoxelDimsInM, phantomDims, reconSliceVoxelDimensionsInM, reconSliceDimensions)
% newLocation = calculateNewPhantomLocationForRestruction(phantomLocationInM, phantomVoxelDimsInM, phantomDimensions, reconSliceVoxelDimensionsInM, reconSliceDimensions)

phantomX = phantomLocationInM(1);
phantomY = phantomLocationInM(2);
phantomZ = phantomLocationInM(3);

lengths = phantomDims .* phantomVoxelDimsInM;

newLengths = reconSliceVoxelDimensionsInM .* reconSliceDimensions;

lenDiffs = lengths - newLengths;

shifts = lenDiffs ./ 2; % centre new phantom reconstruction grid

newLocation(1) = phantomX + shifts(1);
newLocation(2) = phantomY - shifts(2);
newLocation(3) = phantomZ + shifts(3);


end

