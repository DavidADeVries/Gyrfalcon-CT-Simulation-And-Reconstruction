function [] = runHighPerformancePartialPixelWithCentreOf2DDetectorsOnGPU(simulation, simulationRun, app, runIsParallel, slices, angles, numSlices, numAngles, zNumSteps, xyNumSteps, zNumDetectors, xyNumDetectors, optimizeForSlices, optimizeForAngles, optimizeForPerAngleTranslation, optimizeForDetector)
% [] = runHighPerformancePartialPixelWithCentreOf2DDetectorsOnGPU(simulation, simulationRun, app, runIsParallel, slices, angles, numSlices, numAngles, zNumSteps, xyNumSteps, zNumDetectors, xyNumDetectors, optimizeForSlices, optimizeForAngles, optimizeForPerAngleTranslation, optimizeForDetector)

indexingLevels = [numSlices, numAngles, zNumSteps, xyNumSteps, zNumDetectors, xyNumDetectors];
optimizeFlags = [...
    optimizeForSlices,...
    optimizeForAngles,...
    optimizeForPerAngleTranslation,...
    optimizeForPerAngleTranslation,...
    optimizeForDetector,...
    optimizeForDetector];

multTemp = [...
    optimizeForSlices * numSlices,...
    optimizeForAngles * numAngles,...
    optimizeForPerAngleTranslation * zNumSteps,...
    optimizeForPerAngleTranslation * xyNumSteps,...
    optimizeForDetector * xyNumDetectors,...
    optimizeForDetector * zNumDetectors];

numTracesInOptimizedCalc = prod(multTemp(optimizeFlags));
numOfOptimizedCalcs = prod(multTemp(~optimizeFlags)); %these will be either run in sequence or distributed across parallel workers

if numOfOptimizedCalcs == 0
    numOfOptimizedCalcs = 1; %need at least 1 run (to allow the non-parallel to go)
end

% RUN SIMULATION!

if runIsParallel % parallelize run; parallel pool is already online    
    parfor i=1:numOfOptimizedCalcs
        runOptimizedRayTraceCalculation(i,...
            indexingLevels, optimizeFlags, numTracesInOptimizedCalc,...
            scatteringNoiseLevel, detectorNoiseLevel,...
            phantomDims, voxelDimsInM, phantomLocationInM,...
            rawIntensity, calibratedPhantomDataSet,...
    end
else % single processor run, though it is heavily optimized
    for i=1:numOfOptimizedCalcs
        
    end
end

for i=1:numOfOptimizedCalcs
    nonParallelIndices = getIndices(i, indexingLevels, ~optimizeFlags);
    
    parallelBeamTraceIndices = repmat(nonParallelIndices, numTracesInOptimizedCalc, 1);
    
    % set parallel params
    
    for j=1:numTracesInOptimizedCalc
        parallelIndices = getIndices(j, indexingLevels, optimizeFlags);
        
        for k=1:6
            if optimizeFlags(k)
                parallelBeamTraceIndices(j,k) = parallelIndices(k);
            end
        end
        
    end
    
    % copy out variables to avoid unecesary broadcasting
        
    scatteringNoiseLevel = simulation.scatteringNoiseLevel;
    detectorNoiseLevel = simulation.detectorNoiseLevel;
    
    %beamCharacterization = parallel.pool.Constant(simulation.scan.beamCharacterization);
    
    %phantomData = parallel.pool.Constant(simulation.phantom.dataSet.data);
    phantomDims = simulation.phantom.getDataSetDimensions();
    voxelDimsInM = simulation.phantom.getVoxelDimensionsInM();
    phantomLocationInM = simulation.phantom.getLocationInM();
        
    beamCharacterization = simulation.scan.beamCharacterization;
    calibratedPhantomData = simulation.scan.beamCharacterization.calibratedPhantomDataSet{1};
        
    [pointSourceCoords, pointDetectorCoords] = calculateSourceAndDetectorCoords(...
        parallelBeamTraceIndices, simulation.source.getLocationInM(), simulation.detector.getLocationInM(),...
        slices, angles,...
        simulation.scan.getPerAngleTranslationResolutionInM(), simulation.scan.perAngleTranslationDimensions,...
        simulation.detector.wholeDetectorDimensions, simulation.detector.getSingleDetectorDimensionsInM(),...
        simulation.detector.movesWithScanAngle, simulation.detector.movesWithPerAngleTranslation);
    
    rawIntensity = beamCharacterization.rawIntensity;
    roundOffError = Constants.Round_Off_Error_Bound;
       
    
    xVoxelLowBounds = linspace(phantomLocationInM(1), phantomLocationInM(1) + phantomDims(1)*voxelDimsInM(1), phantomDims(1));
        
    yVoxelLowBounds = linspace(phantomLocationInM(2) - (phantomDims(2)+1)*voxelDimsInM(2), phantomLocationInM(2) - voxelDimsInM(2), phantomDims(2));
        
    zVoxelLowBounds = linspace(phantomLocationInM(3) - (phantomDims(3)+1)*voxelDimsInM(3), phantomLocationInM(3) - voxelDimsInM(3), phantomDims(3));
        
    [lowX, lowY, lowZ] = meshgrid(xVoxelLowBounds, yVoxelLowBounds, zVoxelLowBounds);
    
    lowX = gpuArray(lowX);
    lowY = gpuArray(lowY);
    lowZ = gpuArray(lowZ);
    
    voxelDimsInM = gpuArray(voxelDimsInM);
    
%     pointSourceCoords = gpuArray(pointSourceCoords);
%     pointDetectorCoords = gpuArray(pointDetectorCoords);
    
    phantomData = gpuArray(calibratedPhantomData);
    
%     numTraces = length(pointDetectorCoords);
%     detectorData = zeros(numTraces,1);
    
    wrapper = @(PSCX, PSCY, PSCZ, PDCX, PDCY, PDCZ) rasterOnGPU(...
        [PSCX, PSCY, PSCY], [PDCX, PDCY, PDCZ],...
        lowX, lowY, lowZ, voxelDimsInM, phantomData);
    
    detectorData = arrayfun(wrapper,...
        pointSourceCoords(:,1), pointSourceCoords(:,2), pointSourceCoords(:,3),...
        pointDetectorCoords(:,1), pointDetectorCoords(:,2), pointDetectorCoords(:,3));
    
%     for j=1:numTraces
%         rasterResults = arrayfun(@fastRayTraceForGPU,...
%             pointSourceCoords(j,1), pointSourceCoords(j,2), pointSourceCoords(j,3),...
%             pointDetectorCoords(j,1), pointDetectorCoords(j,2), pointDetectorCoords(j,3),...
%             lowX, lowY, lowZ,...
%             voxelDimsInM(1), voxelDimsInM(2), voxelDimsInM(3));
%         detectorData(j) = gather(sum(sum(sum(rasterResults .* phantomData))));
%         disp(j);
%     end

    detectorData = rawIntensity .* exp(-detectorData);
    
    writeDetectorDataToDisk(detectorData, simulationRun.savePath, parallelBeamTraceIndices, optimizeFlags, indexingLevels, angles);
end

end

function detectorData = rasterOnGPU(pointSourceCoords, pointDetectorCoords, lowX, lowY, lowZ, voxelDimsInM, phantomData)
    rasterResults = arrayfun(@fastRayTraceForGPU,...
            pointSourceCoords(1), pointSourceCoords(2), pointSourceCoords(3),...
            pointDetectorCoords(1), pointDetectorCoords(2), pointDetectorCoords(3),...
            lowX, lowY, lowZ,...
            voxelDimsInM(1), voxelDimsInM(2), voxelDimsInM(3));
        detectorData = gather(sum(sum(sum(rasterResults .* phantomData))));
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
    positionFolder = makePositionFolderName(indices(3), indices(4));
    
    fileName = [Constants.Detector_Data_Filename, Constants.Matlab_File_Extension];
    
    writePath = makePath(savePath, sliceFolder, angleFolder, positionFolder, fileName);
    
    save(writePath, Constants.Detector_Data_Var_Name);
end

function folder = makeSliceFolderName(index)
    folder = [Constants.Slice_Folder, ' ', num2str(index)];
end

function folder = makeAngleFolderName(angle)
    folder = [Constants.Angle_Folder, ' ', num2str(angle)];
end

function folder = makePositionFolderName(zIndex, xyIndex)
    folder = [Constants.Position_Folder, ' (', num2str(zIndex), ',', num2str(xyIndex), ')'];
end