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
        
        vistaReconstructionData
        
        vistaReconstructionVoxelDimensions
        vistaReconstructionVoxelDimensionsUnits = Units.mm
        
        usedLightSourceColour
    end
    
    methods
        function scan = OpticalCTImagingScan()
            
        end
        
        function app = setGUI(scan, app)
            app.ImagingScanTypeDropDown.Value = ImagingScanTypes.opticalCT;
            
            hideAllImagingScanImportSettingsTabs(app);
            app.OpticalCTImportSettingsTab.Parent = app.ImportImagingScanTabGroup;
        end
        
        function scan = setDefaultValues(scan)
            scan.vistaScannerHeaderData = [];
                        
            scan.usedLightSourceColour = OpticalWavelengthColoursForVistaScanner.amber;
        end
        
        function imagingScan = createFromGUI(imagingScan, app)
            imagingScan.usedLightSourceColour = app.OptCtSettings_LightSourceColourDropDown.Value;
        end
        
        function radonSumData = convertProjectionDataToRadonSumData(imagingScan, projectionData)
            % data is stored as: (I_0 / I)
            % want to get: sum(\del\mu x)
                      
            radonSumData = log(projectionData); % want \del\mu's to be positive
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
            
            targetPixelDimsInM = vistaScannerData.getDetectorPixelDimensionsInM();
            targetDetectorDims = vistaScannerData.getRawImageDimensions;
            
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
            
            % **************************************
            % Load and cache Vista 3D Reconstruction
            % **************************************
            
            imagingScan = importVistaReconstruction(imagingScan, importPath);            
            
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
                        
            %some constants
            gelBathCutoff = 40000;
            gelBathSpeckCutoff = 1000;
            
            catheterRefFrameCutoff = 18000;
            catheterDeltaFrameCutoff = 4.5;
            
            
            catheterSpeckCutoff = 300;
            
            jarEdgeOutsideBuffer = 10; %pixels
            jarEdgeInsideBuffer = 20;%25; %pixels
            catheterBuffer = 1;
            
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
                                
                % ray rejection
                %isBathMap = (dataFrame > gelBathCutoff);% | (refFrame > gelBathCutoff);
                %isBathMap = bwareaopen(isBathMap, gelBathSpeckCutoff);
                
                %leftJarWallMap = getJarWallMap(isBathMap, jarEdgeOutsideBuffer, jarEdgeInsideBuffer, 'left');
                %rightJarWallMap = getJarWallMap(isBathMap, jarEdgeOutsideBuffer, jarEdgeInsideBuffer, 'right');
                
                xBound = 250:760;
                
                catheterMap = ...
                    (refFrame(:,xBound) < catheterRefFrameCutoff) |...
                    (deltaAttenuationFrame(:,xBound) < (1/catheterDeltaFrameCutoff)) |...
                    (deltaAttenuationFrame(:,xBound) > (catheterDeltaFrameCutoff));
                
                catheterMap = bwareaopen(catheterMap, catheterSpeckCutoff);
                catheterMap = imdilate(catheterMap, ones(1+2*catheterBuffer));
                catheterMap = ~bwareaopen(~catheterMap, catheterSpeckCutoff); % fill in catheter if needed
                               
                
                
               % rayExclusionMap = true & (leftJarWallMap | rightJarWallMap | catheterMap);
               rayExclusionMap = false & ones(size(refFrame));
               rayExclusionMap(:,xBound) = true & catheterMap;
                
                % correct for axis of rotation (AOR) error
                % puts axis of rotation in centre of image
                
                detectorData = applyAxisOfRotationCorrection(deltaAttenuationFrame, aorCorrection);
                rayExclusionMap = applyAxisOfRotationCorrection(rayExclusionMap, aorCorrection);
                 
                % save it in the imaging scan run folder                
                angleFolder = makeAngleFolderName(round(anglesInDeg(i),2));
                mkdir(savePath, angleFolder);
                
                path = makePath(savePath, angleFolder, saveFileName);
                
                save(path, Constants.Detector_Data_Var_Name); % save 'detectorData'
                save(makePath(savePath, angleFolder, rayExclusionFileName), Constants.Ray_Exclusion_Map_Var_Name); % save ray exclusion map
            end         
        end
        
        function imagingScan = importVistaReconstruction(imagingScan, importPath)            
            files = dir(importPath);
            
            for i=1:length(files)
                filename = files(i).name;
                len = length(filename);
                
                if len >= 4 && strcmp(filename(end-3:end), Constants.VFF_File_Extension) % got the recon
                    [reconData, voxelDimsInMM] = loadOpticalCtVistaRecon(makePath(importPath, filename));
                    
                    imagingScan.vistaReconstructionData = reconData;
                    imagingScan.vistaReconstructionVoxelDimensions = imagingScan.vistaReconstructionVoxelDimensionsUnits.convertFromM(Units.mm.convertToM(voxelDimsInMM));
                    
                    break;
                end
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
       frames = frames(:,1:end-2*(-correction));
    elseif correction > 0
       frames = frames(:,1+2*correction:end);
    end

end

