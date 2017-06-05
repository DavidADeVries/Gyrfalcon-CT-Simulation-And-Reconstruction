function [] = runHighPerformancePartialPixelWithCentreOf2DDetectorsOnCPU(simulation, simulationRun, app, runIsParallel, slices, angles, numSlices, numAngles, zNumSteps, xyNumSteps, zNumDetectors, xyNumDetectors, optimizeForSlices, optimizeForAngles, optimizeForPerAngleTranslation, optimizeForDetector)
% [] = runHighPerformancePartialPixelWithCentreOf2DDetectorsOnCPU(simulation, simulationRun, app, runIsParallel, slices, angles, numSlices, numAngles, zNumSteps, xyNumSteps, zNumDetectors, xyNumDetectors, optimizeForSlices, optimizeForAngles, optimizeForPerAngleTranslation, optimizeForDetector)

% prep parameters

source = simulation.source;
detector = simulation.detector;
scan = simulation.scan;
savePath = simulationRun.savePath;

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
            savePath, slices, angles, isScanPositionMosiac);
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
            source, detector, scan, savePath, slices, angles, isScanPositionMosiac);        
    end
end

end

function [pointSourceCoords, pointDetectorCoords] = calculateSourceAndDetectorCoords(indices, sourcePositionInM, detectorPositionInM, slicesInM, anglesInDeg, perAngleStepDimsInM, numPerAngleSteps, detectorDims, detectorPixelDimsWithUnits, angularDetectorRadiusInM, detectorMovesWithScanAngle, detectorMovesWithPerAngleSteps)
                
        % pre-allocate
        dims = size(indices);
        numCoords = dims(1);
        
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
        pointSourceCoords(:,2) = pointSourceCoords(:,2) + ((indices(:,4)-(numPerAngleSteps(1)+1)/2) * perAngleStepDimsInM(1));
        pointSourceCoords(:,3) = pointSourceCoords(:,3) - ((indices(:,3)-(numPerAngleSteps(2)+1)/2) * perAngleStepDimsInM(2));
        
        % rotate with the scan angle and bring back from x-axis
        [pointSourceCoords(:,1), pointSourceCoords(:,2)] = rotateCoordsAboutOrigin(pointSourceCoords(:,1),pointSourceCoords(:,2), sourceAngleInDeg - anglesInDeg(indices(:,2)));
        
        % DETECTOR
        
        % detector placement (for planar 2D detectors only)
        % gives location of detector centre
        if detectorPixelDimsWithUnits(1).isPlanar
            detectorDimInM = detectorPixelDimsWithUnits(1).getLengthInM();
            
            pointDetectorCoords(:,2) = pointDetectorCoords(:,2) - ( (indices(:,6)-(detectorDims(1)/2)-0.5) * detectorDimInM );
        else %isAngular
            detectorDimInDeg = detectorPixelDimsWithUnits(1).getAngleInDegrees();
            
            pointDetectorCoords(:,2) = pointDetectorCoords(:,2) + (angularDetectorRadiusInM * sind( (indices(:,6)-(detectorDims(1)/2)-0.5) * detectorDimInDeg ));
            pointDetectorCoords(:,1) = pointDetectorCoords(:,1) + (angularDetectorRadiusInM * (cosd( (indices(:,6)-(detectorDims(1)/2)-0.5) * detectorDimInDeg )-1));
        end
        
        if detectorPixelDimsWithUnits(2).isPlanar
            detectorDimInM = detectorPixelDimsWithUnits(2).getLengthInM();
            
            pointDetectorCoords(:,3) = pointDetectorCoords(:,3) - ( (indices(:,5)-(detectorDims(2)/2)-0.5) * detectorDimInM );
        else
            detectorDimInDeg = detectorPixelDimsWithUnits(2).getAngleInDegrees();
            
            pointDetectorCoords(:,3) = pointDetectorCoords(:,3) + (angularDetectorRadiusInM * sind( (indices(:,5)-(detectorDims(2)/2)-0.5) * detectorDimInDeg ));
            pointDetectorCoords(:,1) = pointDetectorCoords(:,1) + (angularDetectorRadiusInM * (cosd( (indices(:,5)-(detectorDims(2)/2)-0.5) * detectorDimInDeg )-1));
        end
                
        % per angle steps
        if detectorMovesWithPerAngleSteps
            % NOTE: indices for xy steps are negated, so that detector
            % matches source movement (which is opposite it)
            pointDetectorCoords(:,2) = pointDetectorCoords(:,2) - ((indices(:,4)-(numPerAngleSteps(1)+1)/2) * perAngleStepDimsInM(1));
            pointDetectorCoords(:,3) = pointDetectorCoords(:,3) - ((indices(:,3)-(numPerAngleSteps(2)+1)/2) * perAngleStepDimsInM(2));
        end
        
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
                
                if detectorXY == 1 && translationZ == 1                
                    detectorImage = reshape(detectorImage,...
                        translationZ*detectorZ,...
                        translationXY*detectorXY);
                else                
                    detectorImage = reshape(detectorImage,...
                        translationXY*detectorXY,...
                        translationZ*detectorZ);
                    
                    detectorImage = detectorImage';
                end
            else
                detectorImage = reshape(detectorImage, indexLevels(6), indexLevels(5));
                                
                detectorImage = detectorImage';
            end
                        
            if partialPixelRes > 1 %need to average
                detectorImage = blockproc(detectorImage, averagingBlockSize, @(x)mean2(x.data)); % average the needed blocks
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

function [] = runOptimizedRayTraceCalculation(i, indexingLevels, optimizeFlags, numTracesInOptimizedCalc, scatteringNoiseLevel, detectorNoiseLevel, phantomDims, voxelDimsInM, phantomLocationInM, detectorDims, detectorPixelDims, partialPixelRes, averagingBlockSize, rawIntensity, calibratedPhantomDataSet, source, detector, scan, savePath, slices, angles, isScanPositionMosiac)
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
    detectorDims, detectorPixelDims, detector.getAngularDetectorRadiusInM(),...
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

writeDetectorDataToDisk(detectorData, savePath, optimizedCalcIndices, optimizeFlags, indexingLevels, angles, partialPixelRes, averagingBlockSize, isScanPositionMosiac);

end