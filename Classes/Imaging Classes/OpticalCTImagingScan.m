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
                
                dataFrame = readOptCtFrameBmp(makePath(dataPath, dataFilename), frameDims);
                refFrame = readOptCtFrameBmp(makePath(refPath, refFilename), frameDims);
                
                % apply dark frame
                dataFrame = dataFrame - dataDarkFrame;
                refFrame = refFrame - refDarkFrame;
                
                % convert to \sigma(delta_attenuation .* distance)
                deltaAttenuationFrame = refFrame ./ dataFrame; % log = ln is matlab
                
                % correct for axis of rotation (AOR) error
                % puts axis of rotation in centre of image
                
                deltaAttenuationFrame = applyAxisOfRotationCorrection(deltaAttenuationFrame, aorCorrection);
                
                % interpolate large frame onto the desired target detector
                % size and pixel res
                
                detectorData = interpolateOptCtFrameToProjectionDataSet(...
                    deltaAttenuationFrame, detectorPixelDimsInM, targetDetectorSize, targetPixelDimsInM);
                
                % save it in the imaging scan run folder
                angleFolder = makeAngleFolderName(round(anglesInDeg(i),2));
                mkdir(savePath, angleFolder);
                
                path = makePath(savePath, angleFolder, saveFileName);
                
                save(path, Constants.Detector_Data_Var_Name); % save 'detectorData'
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
        
        totalArea = sum(sum(areas));
        
        areasNorm = areas ./ totalArea;
        
        weightedPixelVals = pixelVals .* areasNorm;
        
        projectionDataSet(y,x) = sum(sum(weightedPixelVals));        
    end
end


end