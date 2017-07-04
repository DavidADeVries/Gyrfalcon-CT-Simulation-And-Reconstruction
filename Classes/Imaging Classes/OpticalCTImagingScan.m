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
        
        function scan = setDefaultValues(scan)
            scan.vistaScannerHeaderData = [];
            
            scan.targetDetectorDimensions = [256,256];
            
            dim = Dimension(0.5, Units.mm);
            
            scan.targetPixelDimensions = [dim,dim];
            
            scan.usedLightSourceColour = OpticalWavelengthColoursForVistaScanner.amber;
        end
        
        function [targetDetectorDims, targetPixelDims, usedLightColour] = getSettingsFromGUI(imagingScan, app)
            xy = app.OptCTSettings_DetectorWholeDetectorDimsXYEditField.Value;
            z = app.OptCTSettings_DetectorWholeDetectorDimsZEditField.Value;
            
            targetDetectorDims = [xy, z];
            
            xyVal = app.OptCtSettings_DetectorPixelDimsXYEditField.Value;
            xyUnits = app.OptCtSettings_DetectorPixelDimsXYUnitsDropDown.Value;
            
            zVal = app.OptCtSettings_DetectorPixelDimsZEditField.Value;
            zUnits = app.OptCtSettings_DetectorPixelDimsZUnitsDropDown.Value;
            
            targetPixelDims = [Dimension(xyVal, xyUnits), Dimensions(zVal, zUnits)];
            
            usedLightColour = app.OptCtSettings_LightSourceColourDropDown.Value;
        end
        
        function imagingScan = importDataSet(imagingScan, app, importPath, savePath)
            % ******************************
            % Load scan type specific fields
            % ******************************
            [targetDetectorDims, targetPixelDims, usedLightColour] = ...
                imagingScan.getSettingsFromGUI(app);
            
            imagingScan.targetDetectorDimensions = targetDetectorDims;
            imagingScan.targetPixelDimensions = targetPixelDims;
            imagingScan.usedLightSourceColour = usedLightColour;
            
            % ***********************
            % Load Vista scanner data
            % ***********************
            vistaScannerData = Vista15ScannerData();
            vistaScannerData = vistaScannerData.loadData(importPath);
            
            imagingScan.vistaScannerData = vistaScannerData;
            
            % *****************************************************
            % Load-up imaging scan objects (Detector, source, etc.)
            % *****************************************************
            
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
            
            slices = 0; % single slice at z=0
            
            perAngleTranslationDimensions = [1,1]; % single point
            perAngleTranslationResolution = [0,0]; % no movement
            
            numWavelengths = length(usedRGBColours);
            
            wavelengthsInNm = zeros(1,numWavelengths);
            
            for i=1:numWavelengths
                wavelengthsInNm(i) = usedRGBColours(i).wavelengthInNm;
            end
            
            intensities = ones(1,numWavelengths); % actual intensity is irrelevant, just relative intensity (RGB equal)
            
            beamCharacterization = OpticalPhotonBeam(wavelengthsInNm, intensities);
            
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
            
            % only one slice, so make slice folder
            sliceNum = 1;
            sliceFolder = makeSliceFolderName(sliceNum);
            
            mkdir(savePath, sliceFolder);
            savePath = makePath(savePath, sliceFolder);
            
            % read, calibrate, and save each frame
            for i=1:numFrames
                % import the data and ref frames
                dataFilename = [dataPrefix, padNumberWithLeadingZeros(i,numFrameDigits), Constants.BMP_File_Extension];
                refFilename = [refPrefix, padNumberWithLeadingZeros(i,numFrameDigits), Constants.BMP_File_Extension];
                
                dataFrame = readOptCtFrameBmp(makePath(dataPath, dataFilename));
                refFrame = readOptCtFrameBmp(makePath(refPath, refFilename));
                
                % apply dark frame
                dataFrame = dataFrame - dataDarkFrame;
                refFrame = refFrame - refDarkFrame;
                
                % convert to \sigma(delta_attenuation .* distance)
                deltaAttenuationFrame = -log(refFrame ./ dataFrame); % log = ln is matlab
                
                % correct for axis of rotation (AOR) error
                % puts axis of rotation in centre of image
                
                deltaAttenuationFrame = applyAxisOfRotationCorrection(deltaAttenuationFrame, aorCorrection);
                
                % interpolate large frame onto the desired target detector
                % size and pixel res
                
                detectorData = interpolateOptCtFrameToProjectionDataSet(...
                    deltaAttenuationFrame, detectorPixelDimsInM, targetDetectorSize, targetPixelDimsInM);
                
                % save it in the imaging scan run folder
                angleFolder = makeAngleFolderName(anglesInDeg(i));
                mkdir(savePath, angleFolder);
                
                savePath = makePath(savePath, angleFolder, saveFileName);
                
                save(savePath, Constants.Detector_Data_Var_Name);
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

function frames = applyAxisOfRotationCorrection(frames, correction)

    %correction gives number of pixels to shift by, correction is negative
    %to shift to the right, positive to shift to the left
    
    if correction < 0
       frames = frames(:,1:end-correction-1);
    elseif correction > 0
       frames = frames(:,correction+1:end);
    end

end

function projectionDataSet = interpolateOptCtFrameToProjectionDataSet(frame, detectorPixelDimsInM, targetDetectorSize, targetPixelDimsInM)

frameDims = size(frames);
detectorSize = [frameDims(2), frameDims(1)];

originalLocationInM = [0 0]; %top-left corner [x,y]
originalDimsInM = detectorSize .* detectorPixelDimsInM;

targetDimsInM = targetDetectorSize .* targetPixelDimsInM;
targetLocationInM = (originalDimsInM - targetDimsInM) ./ 2; % centre it

projectionDataSet = zeros(targetDetectorSize(2), targetDetectorSize(1));

for x=1:targetDetectorSize(1)
    for y=1:targetDetectorSize(2)
        shift = [x,y];
        
        topLeftLoc = targetLocationInM + (shift-1).*targetDimsInM;
        topRightLoc = topLeftLoc + [1 0].*targetDimsInM;
        bottomLeftLoc = topLeftLoc + [0 1].*targetDimsInM;
        bottomRightLoc = topLeftLoc + [1 1].*targetDimsInM;
        
        lowestXLattice = ceil(topLeftLoc(1) ./ originalDimsInM(1));
        greatestXLattice = floor(topRightLoc(1) ./ originalDimsInM(1));
        
        lowestYLattice = ceil(topRightLoc(2) ./ originalDimsInM(2));
        greatestYLattice = floor(bottomRightLoc(2) ./ originalDimsInM(2));
        
        xPoints = (lowestXLattice:1:greatestXLattice).*originalDimsInM(1);
        
        if xPoints(1) > topLeftLoc(1)
            xPoints = [topLeftLoc(1), xPoints];
            lowestXLattice = lowestXLattice - 1;
        end
        if xPoints(end) < topRightLoc(1)
            xPoints = [xPoints, topRightLoc(1)];
            greatestXLattice = greatestXLattice + 1;
        end
          
        yPoints = (lowestYLattice:1:greatestYLattice).*originalDimsInM(2);
        
        if yPoints(1) > topRightLoc(2)
            yPoints = [topRightLoc(2), xyPoints];
            lowestYLattice = lowestYLattice - 1;
        end
        if yPoints(end) < bottomRightLoc(2)
            yPoints = [yPoints, bottomRightLoc(2)];
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
        
        xIndices = (lowestXLattice:1:greatestXLattice) + 1;
        yIndices = (lowestYLattice:1:greatestYLattice) + 1;
        
        [colIndex,rowIndex] = meshgrid(xIndices,yIndices);
        
        frameSelect = sub2ind(frameDims, rowIndex, colIndex);
        
        pixelVals = frames(frameSelect);
        
        totalArea = sum(sum(areas));
        
        areasNorm = totalArea ./ totalArea;
        
        weightedPixelVals = pixelVals .* areasNorm;
        
        projectionDataSet(y,x) = sum(sum(weightedPixelVals));        
    end
end


end