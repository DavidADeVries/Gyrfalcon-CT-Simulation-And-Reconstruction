function [] = runHighPerformancePartialPixelWithCentreOf2DDetectorsOnCPU(simulation, simulationRun, app, runIsParallel, slices, angles, numSlices, numAngles, zNumSteps, xyNumSteps, zNumDetectors, xyNumDetectors, optimizeForSlices, optimizeForAngles, optimizeForPerAngleTranslation, optimizeForDetector)
% [] = runHighPerformancePartialPixelWithCentreOf2DDetectorsOnCPU(simulation, simulationRun, app, runIsParallel, slices, angles, numSlices, numAngles, zNumSteps, xyNumSteps, zNumDetectors, xyNumDetectors, optimizeForSlices, optimizeForAngles, optimizeForPerAngleTranslation, optimizeForDetector)

% prep parameters

source = simulation.source;
detector = simulation.detector;
scan = simulation.scan;
savePath = simulationRun.savePath;

useMexCode = simulationRun.useMexCode;

isScanPositionMosiac = simulation.isScanMultiplePositionMosiac();

scatteringNoiseLevel = simulation.scatteringNoiseLevel;
detectorNoiseLevel = simulation.detectorNoiseLevel;

phantomDims = simulation.phantom.getDataSetDimensions();
voxelDimsInM = simulation.phantom.getVoxelDimensionsInM();
phantomLocationInM = simulation.phantom.getLocationInM();

detectorDims = detector.wholeDetectorDimensions;
detectorPixelDims = detector.singleDetectorDimensions;

rawIntensity = simulation.scan.beamCharacterization.rawIntensity();
calibratedPhantomDataSet = simulation.scan.beamCharacterization.calibratedPhantomDataSet{1};

% adjust for partial pixel resolution > 1, if needed
partialPixelRes = simulation.partialPixelResolution;

if partialPixelRes > 1
    averagingBlockSize = [1 1];
    
    for i=1:2 %xy and z
        if detectorPixelDims(i).value ~= 0 % don't increase resolution if there is no height in that direction
            detectorPixelDims(i).value = detectorPixelDims(i).value ./ partialPixelRes;
            detectorDims(i) = detectorDims(i) .* partialPixelRes; % we increased the resolution by basically adding more detectors!
            
            averagingBlockSize(-i + 3) = partialPixelRes; % first index is z, second is xy (flipped)
        end
    end
        
    zNumDetectors = detectorDims(2);
    xyNumDetectors = detectorDims(1);
else
    averagingBlockSize = [1 1]; % don't really need this, but we'll set it.
end

% calculate how to split up calculations
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



% RUN SIMULATION!

if runIsParallel % parallelize run; parallel pool is already online
    
    parfor i=1:numOfOptimizedCalcs % are running multiple optimized ray trace calcs (which are in turn multiple ray traces) in parallel
        runOptimizedRayTraceCalculation(i,...
            indexingLevels, optimizeFlags, numTracesInOptimizedCalc,...
            scatteringNoiseLevel, detectorNoiseLevel,...
            phantomDims, voxelDimsInM, phantomLocationInM,...
            detectorDims, detectorPixelDims,...
            partialPixelRes, averagingBlockSize,...
            rawIntensity, calibratedPhantomDataSet,...
            source, detector, scan,...
            savePath, slices, angles, isScanPositionMosiac, useMexCode);
    end
else % single processor run, though it is heavily optimized      
    for i=1:numOfOptimizedCalcs
        runOptimizedRayTraceCalculation(i,...
            indexingLevels, optimizeFlags, numTracesInOptimizedCalc,...
            scatteringNoiseLevel, detectorNoiseLevel,...
            phantomDims, voxelDimsInM, phantomLocationInM,...
            detectorDims, detectorPixelDims,...
            partialPixelRes, averagingBlockSize,...
            rawIntensity, calibratedPhantomDataSet,...
            source, detector, scan, savePath, slices, angles, isScanPositionMosiac, useMexCode);        
    end
end

end



function indices = getIndices(index, indexingLevels, useFlags)
    dims = ~useFlags + useFlags.*indexingLevels; % dim of 1 at unused levels
    
    % use fliplr so that detector values will be sequential
    [indices(6), indices(5), indices(4), indices(3), indices(2), indices(1)] = ind2sub(fliplr(dims), index);
end

function [] = writeDetectorDataToDisk(detectorData, savePath, parallelBeamTraceIndices, parallelFlags, indexLevels, angles, partialPixelRes, averagingBlockSize, isScanPositionMosiac)
    parallelForDetector = parallelFlags(5) & parallelFlags(6);
    
    numBeamTraces = length(detectorData);
    
    if parallelForDetector
        if isScanPositionMosiac
            numPixelsInDetector = indexLevels(3) * indexLevels(4) * indexLevels(5) * indexLevels(6); % all positions and detectors make up a single image (it is ensured that no geometry in which detector data would overlap would have this)
        else
            numPixelsInDetector = indexLevels(5) * indexLevels(6);
        end
        
        numDetectorImages = numBeamTraces / numPixelsInDetector;
        
        for i=1:numDetectorImages
            
            detectorImage = detectorData((i-1)*numPixelsInDetector+1:(i)*numPixelsInDetector, 1);
        
            if isScanPositionMosiac
                translationZ = indexLevels(3);
                translationXY = indexLevels(4);
                detectorZ = indexLevels(5);
                detectorXY = indexLevels(6);
                                
                if translationXY > 1
                    if partialPixelRes > 1 %need to average
                        averagingBlockSize = [prod(averagingBlockSize),1];
                        
                        detectorImage = blockproc(detectorImage, averagingBlockSize, @(x)mean(x.data)); % average the needed blocks
                    end
                    
                    if translationZ > 1
                        detectorImage = reshape(detectorImage,...
                            translationXY*detectorXY/partialPixelRes,...
                            translationZ*detectorZ/partialPixelRes);
                        
                        detectorImage = detectorImage';
                    else
                        detectorImage = reshape(detectorImage,...
                            translationZ*detectorZ/partialPixelRes,...
                            translationXY*detectorXY/partialPixelRes);
                    end
                else
                    detectorImage = reshape(detectorImage,...
                        translationXY*detectorXY,...
                        translationZ*detectorZ);
                    
                    detectorImage = detectorImage';
                    
                    if partialPixelRes > 1 %need to average
                        detectorImage = blockproc(detectorImage, averagingBlockSize, @(x)mean2(x.data)); % average the needed blocks
                    end
                end
            else
                detectorImage = reshape(detectorImage, indexLevels(6), indexLevels(5));
                                
                detectorImage = detectorImage';
                
                if partialPixelRes > 1 %need to average
                    detectorImage = blockproc(detectorImage, averagingBlockSize, @(x)mean2(x.data)); % average the needed blocks
                end
            end                       
                        
            saveDetectorImage(detectorImage, savePath, parallelBeamTraceIndices((i-1)*numPixelsInDetector+1,:), angles, isScanPositionMosiac);
        end
    else
        error('No specified action for saving Non-Parallelized Detector Calculation');
    end
end

function [] = saveDetectorImage(detectorData, savePath, indices, angles, isScanPositionMosiac)
    sliceFolder = makeSliceFolderName(indices(1));
    angleFolder = makeAngleFolderName(angles(indices(2)));
    positionName = makePositionName(indices(4), indices(3), isScanPositionMosiac);
    
    fileName = makePositionFileName(positionName);
    
    writePath = makePath(savePath, sliceFolder, angleFolder, fileName);
    
    save(writePath, Constants.Detector_Data_Var_Name);
end

function [] = runOptimizedRayTraceCalculation(i, indexingLevels, optimizeFlags, numTracesInOptimizedCalc, scatteringNoiseLevel, detectorNoiseLevel, phantomDims, voxelDimsInM, phantomLocationInM, detectorDims, detectorPixelDims, partialPixelRes, averagingBlockSize, rawIntensity, calibratedPhantomDataSet, source, detector, scan, savePath, slices, angles, isScanPositionMosiac, useMexCode)
nonOptimizedCalcIndices = getIndices(i, indexingLevels, ~optimizeFlags);


% set parallel params

traceIndices = 1:numTracesInOptimizedCalc;

dims = ~optimizeFlags + optimizeFlags.*indexingLevels; % dimensionality of "1" for non-optimized levels

optimizedCalcIndices = zeros(numTracesInOptimizedCalc, length(indexingLevels));

[optimizedCalcIndices(:,6), optimizedCalcIndices(:,5), optimizedCalcIndices(:,4), optimizedCalcIndices(:,3), optimizedCalcIndices(:,2), optimizedCalcIndices(:,1)] = ...
    ind2sub(fliplr(dims), traceIndices);

for i=1:length(indexingLevels)
    if ~optimizeFlags(i) % not being optimized, so values must be set! Are currently set to "1"
        optimizedCalcIndices(:,i) = nonOptimizedCalcIndices(i);
    end
end

[pointSourceCoords, pointDetectorCoords, pointDetectorWithinSourceBeam] = calculateSourceAndDetectorCoords(...
    optimizedCalcIndices, source.getLocationInM(), detector.getLocationInM(),...
    slices', angles',...
    scan.getPerAngleTranslationResolutionInM(), scan.perAngleTranslationDimensions,...
    detectorDims, detectorPixelDims, detector.getAngularDetectorRadiusInM(),...
    detector.movesWithScanAngle, detector.movesWithPerAngleTranslation, source.getBeamAngleInDegrees());

if useMexCode
    fn = @(sourceCoordsX, sourceCoordsY, sourceCoordsZ, detectorCoordsX, detectorCoordsY, detectorCoordsZ)...
        fastRayTrace_mex(...
        [sourceCoordsX, sourceCoordsY, sourceCoordsZ],...
        [detectorCoordsX, detectorCoordsY, detectorCoordsZ],...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        calibratedPhantomDataSet, rawIntensity);
else
    fn = @(sourceCoordsX, sourceCoordsY, sourceCoordsZ, detectorCoordsX, detectorCoordsY, detectorCoordsZ)...
        fastRayTrace(...
        [sourceCoordsX, sourceCoordsY, sourceCoordsZ],...
        [detectorCoordsX, detectorCoordsY, detectorCoordsZ],...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        calibratedPhantomDataSet, rawIntensity);
end

detectorData = +pointDetectorWithinSourceBeam; % 0 where it's not! Perfect! Just convert to a double

detectorData(pointDetectorWithinSourceBeam) = arrayfun(fn,...
    pointSourceCoords(pointDetectorWithinSourceBeam,1),...
    pointSourceCoords(pointDetectorWithinSourceBeam,2),...
    pointSourceCoords(pointDetectorWithinSourceBeam,3),...
    pointDetectorCoords(pointDetectorWithinSourceBeam,1),...
    pointDetectorCoords(pointDetectorWithinSourceBeam,2),...
    pointDetectorCoords(pointDetectorWithinSourceBeam,3));

writeDetectorDataToDisk(detectorData, savePath, optimizedCalcIndices, optimizeFlags, indexingLevels, angles, partialPixelRes, averagingBlockSize, isScanPositionMosiac);

end