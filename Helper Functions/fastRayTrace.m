function rawDetectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords, phantomLocationInM, phantomDims, voxelDimsInM, phantomData, beamCharacterization)
% rawDetectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords, phantomLocationInM, phantomDims, voxelDimsInM, phantomData, beamCharacterization)

startingIntensity = beamCharacterization.rawIntensity;

bounds1 = phantomLocationInM;
bounds2 = phantomLocationInM + voxelDimsInM .* phantomDims;

[deltas, point] = createLineEquation(pointSourceCoords, pointDetectorCoords);

diff1 = abs(point - bounds1);
diff2 = abs(point - bounds2);

bounds1Closer = diff1 < diff2; 
bounds2Closer = ~bounds1Closer;

mins = bounds1.*bounds1Closer + bounds2.*bounds2Closer;
maxs = bounds1.*bounds2Closer + bounds2.*bounds1Closer;

minTs = (mins - point) ./ deltas;
maxTs = (maxs - point) ./ deltas;

maxOfMinTs = max(minTs);
minOfMaxTs = min(maxTs);

if any(maxOfMinTs > maxTs) || any(minTs > minOfMaxTs))
    rawDetectorValue = startingIntensity; % no intersection
else
    startingPoint = point + maxOfMinTs .* deltas;
    endPoint = point + minOfMaxTs .* deltas;
end

end

