function [] = runHighPerformancePartialPixelWithCentreOf2DDetectorsOnCPU(simulation, simulationRun, app, runIsParallel, slices, angles, numSlices, numAngles, zNumSteps, xyNumSteps, zNumDetectors, xyNumDetectors, optimizeForSlices, optimizeForAngles, optimizeForPerAngleTranslation, optimizeForDetector)
% [] = runHighPerformancePartialPixelWithCentreOf2DDetectorsOnCPU(simulation, simulationRun, app, runIsParallel, slices, angles, numSlices, numAngles, zNumSteps, xyNumSteps, zNumDetectors, xyNumDetectors, optimizeForSlices, optimizeForAngles, optimizeForPerAngleTranslation, optimizeForDetector)

indexingLevels = [numSlices, numAngles, zNumSteps, xyNumSteps, zNumDetectors, xyNumDetectors];
optimizeFlags = [...
    optimizeForSlices,...
    optimizeForAngles,...
    optimizeForPerAngleTranslation,...
    optimizeForPerAngleTranslation,...
    optimizeForDetector,...
    optimizeForDetector];

multTemp = [...
    numSlices,...
    numAngles,...
    zNumSteps,...
    xyNumSteps,...
    xyNumDetectors,...
    zNumDetectors];

optimizedCalcNumbers = multTemp.*optimizeFlags;
nonOptimizedCalcNumbers = multTemp.*(~optimizeFlags);

numTracesInOptimizedCalc = prod(optimizedCalcNumbers(optimizeFlags));
numOfOptimizedCalcs = prod(nonOptimizedCalcNumbers(~optimizeFlags)); %these will be either run in sequence or distributed across parallel workers

if numOfOptimizedCalcs == 0
    numOfOptimizedCalcs = 1; %need at least 1 run (to allow the non-parallel to go)
end

% prep parameters

source = simulation.source;
detector = simulation.detector;
scan = simulation.scan;
savePath = simulationRun.savePath;

scatteringNoiseLevel = simulation.scatteringNoiseLevel;
detectorNoiseLevel = simulation.detectorNoiseLevel;

phantomDims = simulation.phantom.getDataSetDimensions();
voxelDimsInM = simulation.phantom.getVoxelDimensionsInM();
phantomLocationInM = simulation.phantom.getLocationInM();

rawIntensity = simulation.scan.beamCharacterization.rawIntensity();
calibratedPhantomDataSet = simulation.scan.beamCharacterization.calibratedPhantomDataSet{1};

% RUN SIMULATION!

if runIsParallel % parallelize run; parallel pool is already online
    
    parfor i=1:numOfOptimizedCalcs % are running multiple optimized ray trace calcs (which are in turn multiple ray traces) in parallel
        runOptimizedRayTraceCalculation(i,...
            indexingLevels, optimizeFlags, numTracesInOptimizedCalc,...
            scatteringNoiseLevel, detectorNoiseLevel,...
            phantomDims, voxelDimsInM, phantomLocationInM,...
            rawIntensity, calibratedPhantomDataSet,...
            source, detector, scan,...
            savePath, slices, angles);
    end
else % single processor run, though it is heavily optimized      
    for i=1:numOfOptimizedCalcs
        runOptimizedRayTraceCalculation(i,...
            indexingLevels, optimizeFlags, numTracesInOptimizedCalc,...
            scatteringNoiseLevel, detectorNoiseLevel,...
            phantomDims, voxelDimsInM, phantomLocationInM,...
            rawIntensity, calibratedPhantomDataSet,...
            source, detector, scan, savePath, slices, angles);        
    end
end

end

function [pointSourceCoords, pointDetectorCoords] = calculateSourceAndDetectorCoords(indices, sourcePositionInM, detectorPositionInM, slicesInM, anglesInDeg, perAngleStepDimsInM, numPerAngleSteps, detectorDims, detectorPixelDimsInM, detectorMovesWithScanAngle, detectorMovesWithPerAngleSteps)
                
        % pre-allocate
        numCoords = length(indices);
        
        pointSourceCoords = zeros(numCoords,3);
        pointDetectorCoords = zeros(numCoords,3);
        
        % set intial positions
        [sourceAngleInRad, sourceRadius] = cart2pol(sourcePositionInM(1), sourcePositionInM(2));
        [detectorAngleInRad, detectorRadius] = cart2pol(detectorPositionInM(1), detectorPositionInM(2));
        
        sourceAngleInDeg = sourceAngleInRad * Constants.rad_to_deg;
        detectorAngleInDeg = detectorAngleInRad * Constants.rad_to_deg;
        
        % imagine source and detector centres are along positive x-axis
        % now, will rotate everything back later
        pointSourceCoords(:,1) = sourceRadius;
        pointSourceCoords(:,3) = slicesInM(indices(:,1));
        
        pointDetectorCoords(:,1) = detectorRadius;
        pointDetectorCoords(:,3) = slicesInM(indices(:,1));
             
        % SOURCE
        
        % per angle steps
        pointSourceCoords(:,2) = pointSourceCoords(:,2) + ((indices(:,4)-numPerAngleSteps(1)/2) * perAngleStepDimsInM(1));
        pointSourceCoords(:,3) = pointSourceCoords(:,3) + ((indices(:,3)-numPerAngleSteps(2)/2) * perAngleStepDimsInM(2));
        
        % rotate with the scan angle and bring back from x-axis
        [pointSourceCoords(:,1), pointSourceCoords(:,2)] = rotateCoordsAboutOrigin(pointSourceCoords(:,1),pointSourceCoords(:,2), sourceAngleInDeg - anglesInDeg(indices(:,2)));
        
        % DETECTOR
        
        % per angle steps
        if detectorMovesWithPerAngleSteps
            % NOTE: indices for xy steps are negated, so that detector
            % matches source movement (which is opposite it)
            pointDetectorCoords(:,2) = pointDetectorCoords(:,2) + ((-(indices(:,4)-numPerAngleSteps(1)/2)) * perAngleStepDimsInM(1));
            pointDetectorCoords(:,3) = pointDetectorCoords(:,3) + ((indices(:,3)-numPerAngleSteps(2)/2) * perAngleStepDimsInM(2));
        end
        
        % detector placement (for planar 2D detectors only)
        % gives location of detector centre
        pointDetectorCoords(:,2) = pointDetectorCoords(:,2) + ( (indices(:,6)-detectorDims(1)/2) * detectorPixelDimsInM(1) );
        pointDetectorCoords(:,3) = pointDetectorCoords(:,3) + ( (indices(:,5)-detectorDims(2)/2) * detectorPixelDimsInM(2) );
        
        rotateAngles = detectorAngleInDeg;
        
        if detectorMovesWithScanAngle
            rotateAngles = rotateAngles - anglesInDeg(indices(:,2));
        end
        
        [pointDetectorCoords(:,1), pointDetectorCoords(:,2)] = rotateCoordsAboutOrigin(pointDetectorCoords(:,1), pointDetectorCoords(:,2), rotateAngles);
end

function [x, y] = rotateCoordsAboutOrigin(x, y, anglesInDeg)
    tempX = x;
    
    x = x .* cosd(anglesInDeg) - y .* sind(anglesInDeg);
    y = y .* cosd(anglesInDeg) + tempX .* sind(anglesInDeg);
end

function indices = getIndices(index, indexingLevels, useFlags)
    dims = ~useFlags + useFlags.*indexingLevels; % dim of 1 at unused levels
    
    % use fliplr so that detector values will be sequential
    [indices(6), indices(5), indices(4), indices(3), indices(2), indices(1)] = ind2sub(fliplr(dims), index);
end

function [] = writeDetectorDataToDisk(detectorData, savePath, parallelBeamTraceIndices, parallelFlags, indexLevels, angles)
    parallelForDetector = parallelFlags(5) & parallelFlags(6);
    
    numBeamTraces = length(detectorData);
    numPixelsInDetector = indexLevels(5) * indexLevels(6);
    
    if parallelForDetector
        numDetectorImages = numBeamTraces / numPixelsInDetector;
        
        for i=1:numDetectorImages
            detectorImage = detectorData((i-1)*numPixelsInDetector+1:(i)*numPixelsInDetector, 1);
            
            detectorImage = reshape(detectorImage, indexLevels(6), indexLevels(5));
            
            detectorImage = detectorImage';
            
            saveDetectorImage(detectorImage, savePath, parallelBeamTraceIndices((i-1)*numPixelsInDetector+1,:), angles);
        end
    else
        error('No specified action for saving Non-Parallelized Detector Calculation');
    end
end

function [] = saveDetectorImage(detectorData, savePath, indices, angles)
    sliceFolder = makeSliceFolderName(indices(1));
    angleFolder = makeAngleFolderName(angles(indices(2)));
    positionName = makePositionName(indices(3), indices(4));
    
    fileName = makePositionFileName(positionName);
    
    writePath = makePath(savePath, sliceFolder, angleFolder, fileName);
    
    save(writePath, Constants.Detector_Data_Var_Name);
end

function [] = runOptimizedRayTraceCalculation(i, indexingLevels, optimizeFlags, numTracesInOptimizedCalc, scatteringNoiseLevel, detectorNoiseLevel, phantomDims, voxelDimsInM, phantomLocationInM, rawIntensity, calibratedPhantomDataSet, source, detector, scan, savePath, slices, angles)
nonOptimizedCalcIndices = getIndices(i, indexingLevels, ~optimizeFlags);

optimizedCalcIndices = repmat(nonOptimizedCalcIndices, numTracesInOptimizedCalc, 1);

% set parallel params

for j=1:numTracesInOptimizedCalc
    optimizedIndices = getIndices(j, indexingLevels, optimizeFlags);
    
    for k=1:6
        if optimizeFlags(k)
            optimizedCalcIndices(j,k) = optimizedIndices(k);
        end
    end
    
end

[pointSourceCoords, pointDetectorCoords] = calculateSourceAndDetectorCoords(...
    optimizedCalcIndices, source.getLocationInM(), detector.getLocationInM(),...
    slices', angles',...
    scan.getPerAngleTranslationResolutionInM(), scan.perAngleTranslationDimensions,...
    detector.wholeDetectorDimensions, detector.getSingleDetectorDimensionsInM(),...
    detector.movesWithScanAngle, detector.movesWithPerAngleTranslation);

fn = @(sourceCoordsX, sourceCoordsY, sourceCoordsZ, detectorCoordsX, detectorCoordsY, detectorCoordsZ)...
    fastRayTrace(...
    [sourceCoordsX, sourceCoordsY, sourceCoordsZ],...
    [detectorCoordsX, detectorCoordsY, detectorCoordsZ],...
    phantomLocationInM, phantomDims, voxelDimsInM,...
    calibratedPhantomDataSet, rawIntensity);

detectorData = arrayfun(fn,...
    pointSourceCoords(:,1), pointSourceCoords(:,2), pointSourceCoords(:,3),...
    pointDetectorCoords(:,1), pointDetectorCoords(:,2), pointDetectorCoords(:,3));

writeDetectorDataToDisk(detectorData, savePath, optimizedCalcIndices, optimizeFlags, indexingLevels, angles);

end