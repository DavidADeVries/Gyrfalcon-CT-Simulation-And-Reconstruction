function detectorData = runPartialPixelBeamTraceFromPointSource(pointSourceCoords, sourceEndBoxCoords, detectorCornerCoords, phantomData, voxelDimsInM, phantomLocationInM, beamCharacterization, scatteringNoiseLevel, detectorNoiseLevel, partialPixelModelingResolution)
% detectorData = runPartialPixelBeamTraceFromPointSource(pointSourceCoords, sourceEndBoxCoords, detectorCornerCoords, phantomData, voxelDimsInM, phantomLocationInM, beamCharacterization, scatteringNoiseLevel, detectorNoiseLevel, partialPixelModelingResolution)
% for this beam trace, partial pixel modelling is used. This requires a
% resolution to be given (how many ray traces to run per detector), and
% then these will be averaged out to give the detector value

detectorDimensions = dimensionalityOfObject(detectorCornerCoords);

switch detectorDimensions
    case 0
        % for a point detector, we can't have a "resolution" for our
        % detector, so just run a ray trace from source to detector
        
        detectorPoint = detectorCornerCoords(1,:);
        
        rawDetectorValue = runRayTrace(...
            pointSourceCoords,...
            sourceEndBoxCoords,...
            detectorPoint,...
            phantomData,...
            voxelDimsInM,...
            phantomLocationInM,...
            beamCharacterization);
        
        averDetectorValue = rawDetectorValue; %no averaging required, only a single point
    case 1
        
    case 2
        
    otherwise
        error('Invalid detector dimensions');
end
    
detectorData = applyNoise(averDetectorValue, scatteringNoiseLevel, detectorNoiseLevel); 


end



function valueWithNoise = applyNoise(detectorValue, scatteringNoiseLevel, detectorNoiseLevel)
    % TODO
    valueWithNoise = detectorValue;
end