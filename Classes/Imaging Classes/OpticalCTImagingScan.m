classdef OpticalCTImagingScan < ImagingScan
    % OpticalCTImagingScan
    % This class contains all the data pertaining to an optical CT dataset
    % that is being imported into Gyrfalcon
    % 
    % FIELDS:
    % 
    % *vistaScannerHeaderData
    % carries the data stored in a Modus scanner XML file, as well as scanner
    % dependent values. Different classes for different Vista versions
    %
    % *targetDetectorDimensions
    % size of detector to interpolate data onto
    %
    % *targetPixelDimensions
    % dimensions (value and units) of pixels in detector to interpolate
    % data onto
    %
    % *usedLightSourceColour
    % colour of the light source used during the optical imaging
    
    properties
        vistaScannerHeaderData    
        
        targetDetectorDimensions
        targetPixelDimensions
        usedLightSourceColour
    end
    
    methods
        function scan = OpticalCTImagingScan()
            
        end
        
        function app = setGUI(scan, app)
            app.ImagingScanTypeDropDown.Value = ImagingScanTypes.opticalCT;
            
            hideAllImagingScanImportSettingsTabs(app);
            app.OpticalCTImportSettingsTab.Parent = app.ImportImagingScanTabGroup;
            
            % set fields
            app.OptCTSettings_DetectorWholeDetectorDimsXYEditField.Value = scan.targetDetectorDimensions(1);
            app.OptCTSettings_DetectorWholeDetectorDimsZEditField.Value = scan.targetDetectorDimensions(2);
            
            app.OptCtSettings_DetectorPixelDimsXYEditField.Value = scan.targetPixelDimensions(1).value;
            app.OptCtSettings_DetectorPixelDimsZEditField.Value = scan.targetPixelDimensions(2).value;
            
            app.OptCtSettings_DetectorPixelDimsXYUnitsDropDown.Value = scan.targetPixelDimensions(1).units;
            app.OptCtSettings_DetectorPixelDimsXYUnitsDropDown.Value = scan.targetPixelDimensions(2).units;
        end
        
        function scan = setDefaultValues(scan)
            scan.vistaScannerHeaderData = [];
            
            scan.targetDetectorDimensions = [256,256];
            
            dim = Dimension(0.5, Units.mm);
            
            scan.targetPixelDimensions = [dim,dim];
            
            scan.usedLightSourceColour = OpticalWavelengthColoursForVistaScanner.amber;
        end
        
        function imagingScan = createFromGUI(imagingScan, app)
            xy = app.OptCTSettings_DetectorWholeDetectorDimsXYEditField.Value;
            z = app.OptCTSettings_DetectorWholeDetectorDimsZEditField.Value;
            
            imagingScan.targetDetectorDimensions = [xy, z];
            
            xyVal = app.OptCtSettings_DetectorPixelDimsXYEditField.Value;
            xyUnits = app.OptCtSettings_DetectorPixelDimsXYUnitsDropDown.Value;
            
            zVal = app.OptCtSettings_DetectorPixelDimsZEditField.Value;
            zUnits = app.OptCtSettings_DetectorPixelDimsZUnitsDropDown.Value;
            
            imagingScan.targetPixelDimensions = [Dimension(xyVal, xyUnits), Dimension(zVal, zUnits)];
            
            imagingScan.usedLightSourceColour = app.OptCtSettings_LightSourceColourDropDown.Value;
        end
        
        function dimsInM = getTargetPixelDimensionsInM(imagingScan)
            xyDim = imagingScan.targetPixelDimensions(1);
            zDim = imagingScan.targetPixelDimensions(2);
            
            dimsInM(1) = xyDim.getLengthInM();
            dimsInM(2) = zDim.getLengthInM();
        end
        
        function string = getSummaryString(imagingScan)
            string = 'N/A';
        end
        
        function imagingScan = importDataSet(imagingScan, importPath, savePath)
                        
            % ***********************
            % Load Vista scanner data
            % ***********************
            vistaScannerData = Vista15ScannerData();
            vistaScannerData = vistaScannerData.loadData(importPath);
            
            imagingScan.vistaScannerHeaderData = vistaScannerData;
            
            % *****************************************************
            % Load-up imaging scan objects (Detector, source, etc.)
            % *****************************************************
            
            targetPixelDimsInM = imagingScan.getTargetPixelDimensionsInM();
            targetDetectorDims = imagingScan.targetDetectorDimensions;
            
            %DETECTOR
            detectorLocationInM = [0, vistaScannerData.getAxisToDetectorInM()];
            wholeDetectorDims = targetDetectorDims;
            singleDetectorDims = [Dimension(targetPixelDimsInM(1), Units.m), Dimension(targetPixelDimsInM(2), Units.m)];
            detectorMovesWithScanAngle = true;
            detectorMovesWithPerAngleTranslation = false;
            
            detector = Detector(...
                detectorLocationInM, wholeDetectorDims, singleDetectorDims,...
                detectorMovesWithScanAngle, detectorMovesWithPerAngleTranslation);
            
            %SOURCE
            sourceLocationInM = [0, -vistaScannerData.getAxisToSourceInM()];
            sourceDims = [Dimension(0, Units.m), Dimension(0, Units.m)]; % point source
            
            radiusInM = vistaScannerData.getAxisToSourceInM() + vistaScannerData.getAxisToDetectorInM();
            detectorDimsInM = detector.getSingleDetectorDimensionsInM();
            
            xyInM = detectorDimsInM(1) .* wholeDetectorDims(1) ./ 2;
            zInM = detectorDimsInM(2) .* wholeDetectorDims(2) ./ 2;
            
            beamAngleInDeg = 2 .* [atand(xyInM/radiusInM), atand(zInM/radiusInM)];
            
            source = Source(sourceLocationInM, sourceDims, beamAngleInDeg);
            
            %SCAN/BEAM CHARACTERIZATION
            angleSpacingInDeg = vistaScannerData.getAngleSpacingInDeg();
            
            scanAnglesInDeg = 0:angleSpacingInDeg:(vistaScannerData.getNumAngles()-1)*angleSpacingInDeg;
            scanAnglesInDeg = -scanAnglesInDeg; % to match Gyrfalcon conventions
            
            slices = 0; % single slice at z=0
            
            perAngleTranslationDimensions = [1,1]; % single point
            perAngleTranslationResolution = [0,0]; % no movement
            
            wavelengthInNm = imagingScan.usedLightSourceColour.wavelengthInNm;                        
            intensity = 1; % actual intensity is irrelevant, just set to 1
            
            beamCharacterization = OpticalPhotonBeam(wavelengthInNm, intensity);
            
            scan = Scan(scanAnglesInDeg, slices,...
                perAngleTranslationDimensions, perAngleTranslationResolution,...
                beamCharacterization);
            
            % set imaging scan fields
            imagingScan.detector = detector;
            imagingScan.source = source;
            imagingScan.scan = scan;
            
            % *****************************************
            % Load, process, and save imaging scan data
            % *****************************************
            
            dataPath = makePath(importPath, vistaScannerData.getDataFrameFolderName());
            refPath = makePath(importPath, vistaScannerData.getReferenceFrameFolderName());
            
            numFrames = vistaScannerData.numImages;
            frameDims = vistaScannerData.getRawImageDimensions();
            numFrameDigits = vistaScannerData.getNumDigitsInFrameNumbering();
            
            aorCorrection = vistaScannerData.axisOfRotationOffsetInPx;
            
            dataPrefix = getFilePrefix(dataPath);
            refPrefix = getFilePrefix(refPath);
            
            darkLabel = vistaScannerData.getDarkFrameLabel();
            
            dataDarkFrame = readOptCtFrameBmp(makePath(dataPath, [dataPrefix, darkLabel, Constants.BMP_File_Extension]), frameDims);
            refDarkFrame = readOptCtFrameBmp(makePath(refPath, [refPrefix, darkLabel, Constants.BMP_File_Extension]), frameDims);
            
            anglesInDeg = scan.getScanAnglesInDegrees();
            
            % interpolation params
            detectorPixelDimsInM = vistaScannerData.getDetectorPixelDimensionsInM();
            targetDetectorSize = imagingScan.targetDetectorDimensions;
            targetPixelDimsInM = imagingScan.getTargetPixelDimensionsInM();
            
            % filename
            isScanMosiac = false;
            positionName = makePositionName(1,1,isScanMosiac);
            saveFileName = makePositionFileName(positionName);
            rayExclusionFileName = makeRayExclusionMapFileName(positionName);
            
            % only one slice, so make slice folder
            sliceNum = 1;
            sliceFolder = makeSliceFolderName(sliceNum);
            
            mkdir(savePath, sliceFolder);
            savePath = makePath(savePath, sliceFolder);
            
            % load up ray exclusion map for jar edges
            data = load('E:\Data Files\Git Repos\Gyrfalcon Data\Imaging Scan Runs\Jar Edges Ray Exclusion Map (134x134).mat');
            jarEdgesMap = data.(Constants.Ray_Exclusion_Map_Var_Name);
            
            %some constants
            gelBathCutoff = 40000;
            gelBathSpeckCutoff = 1000;
            
            catheterCutoff = 4000;
            catheterSpeckCutoff = 500;
            
            jarEdgeOutsideBuffer = 5; %pixels
            jarEdgeInsideBuffer = 25; %pixels
            catheterBuffer = 3;
            
            % read, calibrate, and save each frame                        
            for i=1:numFrames
                % import the data and ref frames
                
                dataFilename = [dataPrefix, padNumberWithLeadingZeros(i,numFrameDigits), Constants.BMP_File_Extension];
                refFilename = [refPrefix, padNumberWithLeadingZeros(i,numFrameDigits), Constants.BMP_File_Extension];
                
                dataFrame = readOptCtFrameBmp(makePath(dataPath, dataFilename), frameDims);
                refFrame = readOptCtFrameBmp(makePath(refPath, refFilename), frameDims);
                                
                % apply dark frame
                dataFrame = dataFrame - dataDarkFrame;
                refFrame = refFrame - refDarkFrame;
                
                
                isBathMap = (dataFrame > gelBathCutoff) | (refFrame > gelBathCutoff);
                isBathMap = bwareaopen(isBathMap, gelBathSpeckCutoff);
                
                leftJarWallMap = getJarWallMap(isBathMap, jarEdgeOutsideBuffer, jarEdgeInsideBuffer, 'left');
                rightJarWallMap = getJarWallMap(isBathMap, jarEdgeOutsideBuffer, jarEdgeInsideBuffer, 'right');
                
                catheterMap = (dataFrame < catheterCutoff) | (refFrame < catheterCutoff);
                catheterMap = bwareaopen(catheterMap, catheterSpeckCutoff);
                catheterMap = imdilate(catheterMap, ones(1+2*catheterBuffer));
                
                rayRejection = leftJarWallMap | rightJarWallMap | catheterMap;
                
%                 reject = bwareaopen(abs(gradient(refFrame-dataFrame)) > 1000,150) | (refFrame < 5000);
%                 
%                 leftJarWallRejection = findRejectionMap(reject, [50,690], [120,300]);
%                 rightJarWallRejection = findRejectionMap(reject, [50,690], [730,910]);
%                 
%                 catheterRejection = findRejectionMapWithoutFullVertical(reject, [50,690],[300,730]);
%                 
%                 rayRejection = (leftJarWallRejection | rightJarWallRejection | catheterRejection);
                                
                % convert to \sigma(delta_attenuation .* distance)
                deltaAttenuationFrame = refFrame ./ dataFrame; % log = ln is matlab
                
                % correct for axis of rotation (AOR) error
                % puts axis of rotation in centre of image
                
                deltaAttenuationFrame = applyAxisOfRotationCorrection(deltaAttenuationFrame, aorCorrection);
                rayRejection = applyAxisOfRotationCorrection(rayRejection, aorCorrection);
                
                deltaAttenuationFrame(rayRejection) = 0; % these ray values cannot be used, but since we want to interpolate the imaging data, we'll set them to zero
                interpolationPixelWeighting = ~rayRejection; % this way we can still interpolate, and as long as least one pixel/ray is not rejected, we can have a value.
                
                % interpolate large frame onto the desired target detector
                % size and pixel res
                
                detectorData = interpolateOptCtFrameToProjectionDataSet(...
                    deltaAttenuationFrame, interpolationPixelWeighting, detectorPixelDimsInM, targetDetectorSize, targetPixelDimsInM);
                
                rayExclusionMap = isnan(detectorData); % if is NaN, means that only rejected rays contributed
                detectorData(rayExclusionMap) = 0; %we'll set NaN values to 0 to keep data valid for display, we'll have the rayExclusionMap to keep track of these values.
                
                % set some maps so that we can figure out which pixels/rays
                % should be rejected
%                 interpolationPixelWeighting = ones(size(rayRejection)); % no 0s because we want to view all "rays" as valid, with valid rays having value 1, and non-valid having value 0
%                 
%                 rayExclusionMap = interpolateOptCtFrameToProjectionDataSet(...
%                     ~rayRejection, interpolationPixelWeighting, detectorPixelDimsInM, targetDetectorSize, targetPixelDimsInM);
%                 rayExclusionMap = (rayExclusionMap == 0); % if an interpolated pixel/ray is 0, it means only rejected rays contributed (see all valid rays had value 1)
                
                % save it in the imaging scan run folder
                angleFolder = makeAngleFolderName(round(anglesInDeg(i),2));
                mkdir(savePath, angleFolder);
                
                path = makePath(savePath, angleFolder, saveFileName);
                
                save(path, Constants.Detector_Data_Var_Name); % save 'detectorData'
                save(makePath(savePath, angleFolder, rayExclusionFileName), Constants.Ray_Exclusion_Map_Var_Name); % save ray exclusion map
            end
                        
        end
    end
end

% HELPER FUNCTIONS
function image = readOptCtFrameBmp(path, frameDims)
    fid = fopen(path);
    
    data = fread(fid, inf, 'uint16');
    
    fclose(fid);
    
    data = data(28:end); %strip header
    
    image = imrotate(reshape(data, frameDims), 90);
    
    image = double(image); %convert to double so we can do math!
end

function map = getJarWallMap(isBathMap, outsideBuffer, insideBuffer, sideString)
    dims = size(isBathMap);
    width = dims(2);
    
    split = floor(width/2);
    
    map = false & zeros(dims);
    
    switch sideString
        case 'left'
            subMap = isBathMap(:, 1:split);
            
            [min, max] = getMinAndMaxRightMostValues(subMap);
            min = min - outsideBuffer;
            max = max + insideBuffer;
            
            map(:,min:max) = true;
        case 'right'
            subMap = isBathMap(:, split:end);
            
            [min, max] = getMinAndMaxLeftMostValues(subMap);
            min = (split - 1) + min - insideBuffer;
            max = (split - 1) + max + outsideBuffer;
            
            map(:,min:max) = true;
        otherwise
            error('String must be left or right');
    end
end

function [minVal, maxVal] = getMinAndMaxRightMostValues(map)
    dims = size(map);
    
    numRows = dims(1);
    numCols = dims(2);
    
    colIndices = repmat(1:numCols, numRows, 1);
    
    map = colIndices .* map;
    invalidRows = (sum(map,2) == 0); % row has no true pixels
    
    [~, rightmostColIndices] = max(map,[],2); %take max along rows, get col index of the max value in each row (which would be the rightmost pixel)
    rightmostColIndices(invalidRows) = [];
    
    minVal = min(rightmostColIndices);
    maxVal = max(rightmostColIndices);
end

function [minVal, maxVal] = getMinAndMaxLeftMostValues(map)
    dims = size(map);
    
    numRows = dims(1);
    numCols = dims(2);
    
    colIndices = repmat(1:numCols, numRows, 1);
    
    map = -(colIndices-numCols-1) .* map; % do some adjustment so that left most pixels have higher col values
    invalidRows = (sum(map,2) == 0); % row has no true pixels
    
    [~, leftmostColIndices] = max(map,[],2); %take max along rows, get col index of the max value in each row (which would be the leftmost pixel)
    leftmostColIndices(invalidRows) = [];
    
    minVal = min(leftmostColIndices);
    maxVal = max(leftmostColIndices);
end

function frames = applyAxisOfRotationCorrection(frames, correction)

    %correction gives number of pixels to shift by, correction is negative
    %to shift to the right, positive to shift to the left
    
    if correction < 0
       frames = frames(:,1:end-correction-1);
    elseif correction > 0
       frames = frames(:,correction+1:end);
    end

end

function projectionDataSet = interpolateOptCtFrameToProjectionDataSet(frame, interpolationWeighting, detectorPixelDimsInM, targetDetectorSize, targetPixelDimsInM)

frameDims = size(frame);
detectorSize = [frameDims(2), frameDims(1)];

originalLocationInM = [0 0]; %top-left corner [x,y]
originalDimsInM = detectorSize .* detectorPixelDimsInM;

targetDimsInM = targetDetectorSize .* targetPixelDimsInM;
targetLocationInM = [1,-1] .* (originalDimsInM - targetDimsInM) ./ 2; % centre it

projectionDataSet = zeros(targetDetectorSize(2), targetDetectorSize(1));

for x=1:targetDetectorSize(1)
    for y=1:targetDetectorSize(2)
        shift = [x,y];
        
        topLeftLoc = targetLocationInM + (shift-1).*[1,-1].*targetPixelDimsInM;
        topRightLoc = topLeftLoc + [1 0].*targetPixelDimsInM;
        bottomLeftLoc = topLeftLoc + [0 -1].*targetPixelDimsInM;
        bottomRightLoc = topLeftLoc + [1 -1].*targetPixelDimsInM;
        
        lowestXLattice = ceil(topLeftLoc(1) ./ detectorPixelDimsInM(1));
        greatestXLattice = floor(topRightLoc(1) ./ detectorPixelDimsInM(1));
        
        lowestYLattice = -ceil(topRightLoc(2) ./ detectorPixelDimsInM(2));
        greatestYLattice = -floor(bottomRightLoc(2) ./ detectorPixelDimsInM(2));
        
        xPoints = (lowestXLattice:1:greatestXLattice).*detectorPixelDimsInM(1);
        
        if topLeftLoc(1) < xPoints(1) 
            xPoints = [topLeftLoc(1), xPoints];
            lowestXLattice = lowestXLattice - 1;
        end
        if xPoints(end) < topRightLoc(1)
            xPoints = [xPoints, topRightLoc(1)];
            greatestXLattice = greatestXLattice + 1;
        end
          
        yPoints = -(greatestYLattice:-1:lowestYLattice).*detectorPixelDimsInM(2);
        
        if bottomRightLoc(2) < yPoints(1)
            yPoints = [bottomRightLoc(2), yPoints];
            lowestYLattice = lowestYLattice - 1;
        end
        if yPoints(end) < topRightLoc(2)
            yPoints = [yPoints, topRightLoc(2)];
            greatestYLattice = greatestYLattice + 1;
        end
        
        numXPoints = length(xPoints);
        numYPoints = length(yPoints);
        
        xSideLengths = zeros(1,numXPoints-1);
        ySideLengths = zeros(1,numYPoints-1);
        
        for i=1:numXPoints-1
            xSideLengths(i) = xPoints(i+1) - xPoints(i);
        end
        for i=1:numYPoints-1
            ySideLengths(i) = yPoints(i+1) - yPoints(i);
        end
        
        [xSide,ySide] = meshgrid(xSideLengths,ySideLengths);
        
        areas = xSide .* ySide;
        
        xIndices = (lowestXLattice+1:1:greatestXLattice) + 1;
        yIndices = (greatestYLattice:-1:lowestYLattice+1) + 1;
        
        [colIndex,rowIndex] = meshgrid(xIndices,yIndices);
        
        frameSelect = sub2ind(frameDims, rowIndex, colIndex);
                
        pixelVals = frame(frameSelect);
        weightVals = interpolationWeighting(frameSelect);
        
        totalArea = sum(sum(areas .* weightVals));
        
        areasNorm = areas ./ totalArea;
        
        weightedPixelVals = pixelVals .* weightVals .* areasNorm;
        
        projectionDataSet(y,x) = sum(sum(weightedPixelVals));        
    end
end


end

% HELPER FUNCTIONS
function rejectionMap = findRejectionMap(image, rowBounds, colBounds)
%     gradientBound = 10000;
%     pixelFleckBound = 100;
%     
%     gradImage = imgradient(image(rowBounds(1):rowBounds(2), colBounds(1):colBounds(2))) >= gradientBound;
%     
%     % get rid of any tiny flecks that could mess us up
%     featureMap = bwareaopen(gradImage, pixelFleckBound);
    
    featureMap = image(rowBounds(1):rowBounds(2), colBounds(1):colBounds(2));

    numPixels = numel(featureMap);
    indices = 1:numPixels;
    
    [r,c] = ind2sub(size(featureMap),indices);
    
    featureMap = reshape(featureMap, size(indices));
    
    chosenCols = c(featureMap);
    
    minCol = min(chosenCols);
    maxCol = max(chosenCols);
    
    rejectionBuffer = 3;
    
    rejectionMap = zeros(size(image));
    
    colSelect = (colBounds(1) + minCol - rejectionBuffer):(colBounds(1) + maxCol + rejectionBuffer);
    
    rejectionMap(:,colSelect) = 1;
    rejectionMap = true & rejectionMap;
end

function rejectionMap = findRejectionMapWithoutFullVertical(image, rowBounds, colBounds)
%     gradientBound = 10000;
%     pixelFleckBound = 100;
%     
%     gradImage = imgradient(image(rowBounds(1):rowBounds(2), colBounds(1):colBounds(2))) >= gradientBound;
%     
%     % get rid of any tiny flecks that could mess us up
%     featureMap = bwareaopen(gradImage, pixelFleckBound);
    
    featureMap = image(rowBounds(1):rowBounds(2), colBounds(1):colBounds(2));

    numPixels = numel(featureMap);
    indices = 1:numPixels;
    
    [r,c] = ind2sub(size(featureMap),indices);
    
    featureMap = reshape(featureMap, size(indices));
    
    chosenCols = c(featureMap);
    chosenRows = r(featureMap);
    
    minCol = min(chosenCols);
    maxCol = max(chosenCols);
    
    maxRow = max(chosenRows); % lowest bound
    
    rejectionBuffer = 1;
    
    rejectionMap = zeros(size(image));
    
    colSelect = (colBounds(1) + minCol - rejectionBuffer):(colBounds(1) + maxCol + rejectionBuffer);
    rowSelect = 1:rowBounds(1) + maxRow + rejectionBuffer;
    
    rejectionMap(rowSelect,colSelect) = 1;
    rejectionMap = true & rejectionMap;
end