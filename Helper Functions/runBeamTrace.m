function detectorData = runBeamTrace(axesHandle, sourceStartBoxCoords, sourceEndBoxCoords, sourceDirectionUnitVector, detectorCornerCoords, phantomData, voxelDimsInM,  phantomLocationInM,  beamCharacterization, scatteringNoiseLevel, detectorNoiseLevel, partialPixel, partialPixelModelingResolution)
% detectorData = runBeamTrace(sourcePosition, sourceDimensions, sourceDirectionUnitVector, detectorCornerCoords, phantomData, voxelDimsInM, phantomLocationInM, beamCharacterization, scatteringNoiseLevel, detectorNoiseLevel,  partialPixel)
% runs the beam trace for a given detector/source/phantom configuration

if coordsAreFromPointSource(sourceStartBoxCoords)
    pointSourceCoords = sourceStartBoxCoords(1,:); %could choose any coords from the box, since all are the same
    
    if partialPixel
        detectorData = runPartialPixelBeamTraceFromPointSource(axesHandle,pointSourceCoords, sourceEndBoxCoords, detectorCornerCoords, phantomData, voxelDimsInM, phantomLocationInM, beamCharacterization, scatteringNoiseLevel, detectorNoiseLevel, partialPixelModelingResolution);
    else        
        detectorData = runNonPartialPixelBeamTraceFromPointSource(pointSourceCoords, sourceEndBoxCoords, detectorCornerCoords, phantomData, voxelDimsInM, phantomLocationInM, beamCharacterization, scatteringNoiseLevel, detectorNoiseLevel);
    end    
else
    error('Undefined behaviour. Cannot model non-point sources');
end

end




% HELPER FUNCTIONS

function bool = coordsAreFromPointSource(coords)
    bool = all(coords(1,:) == coords(2,:)) && all(coords(2,:) == coords(3,:)) && all(coords(3,:) == coords(4,:));
    
end