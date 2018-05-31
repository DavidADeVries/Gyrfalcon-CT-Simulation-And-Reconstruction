classdef Reconstruction
    % Reconstruction
    
    properties
        reconDataSetSlices % the reconstructed data set slices (cell array of slices)
        
        reconDataSet % the 3D reconstructed data set (which can be compared to the original phantom)
        
        reconSliceDimensions = [0 0 0]% number of voxels in x,y,z for each slice
        
        reconSliceVoxelDimensions = [0 0 0]% dimension of each voxel in data set
        reconSliceVoxelDimensionUnits = Units.mm
        
        reconSliceLocation
        reconSliceLocationUnits = Units.m
        
        reconDataSetDimensions = [0 0 0] % number of voxels in x,y,z for dataset
        
        reconDataSetVoxelDimensions = [0 0 0] % dimension of each voxel
        reconDataSetVoxelDimensionUnits = Units.mm
        
        reconDataSetLocation
        reconDataSetLocationUnits = Units.m
        
        interpolateDetectorData = false
        processingWholeDetectorDimensions = [256 256]
        processingSingleDetectorDimensions = [0.5 0.5]
        
        processingSingleDetectorUnits = Units.mm
        
        useRayRejection = false
        
        reconDataSetInterpolationType = InterpolationTypes3D.spline
    end
    
    methods
        function recon = Reconstruction()
            
        end
        
        function recon = transferReconstructionValues(recon, oldRecon)
            recon.reconDataSetSlices = oldRecon.reconDataSetSlices;
            recon.reconDataSet = oldRecon.reconDataSet;
            recon.reconSliceDimensions = oldRecon.reconSliceDimensions;
            recon.reconSliceVoxelDimensions = oldRecon.reconSliceVoxelDimensions;
            recon.reconSliceLocation = oldRecon.reconSliceLocation;
            recon.reconDataSetDimensions = oldRecon.reconDataSetDimensions;
            recon.reconDataSetVoxelDimensions = oldRecon.reconDataSetVoxelDimensions;
            recon.reconDataSetLocation = oldRecon.reconDataSetLocation;
            recon.reconDataSetInterpolationType = oldRecon.reconDataSetInterpolationType;
        end
        
        function recon = createFromGUI(recon, app)
            x = app.ReconstructionRunSliceDimsXEditField.Value;
            y = app.ReconstructionRunSliceDimsYEditField.Value;
            z = app.ReconstructionRunSliceDimsZEditField.Value;
            
            recon.reconSliceDimensions = [x, y, z];
            
            x = app.ReconstructionRunSlicePixelDimsXEditField.Value;
            y = app.ReconstructionRunSlicePixelDimsYEditField.Value;
            z = app.ReconstructionRunSlicePixelDimsZEditField.Value;
            
            recon.reconSliceVoxelDimensions= [x, y, z];
            
            x = app.ReconstructionRunDataSetDimsXEditField.Value;
            y = app.ReconstructionRunDataSetDimsYEditField.Value;
            z = app.ReconstructionRunDataSetDimsZEditField.Value;
            
            recon.reconDataSetDimensions = [x, y, z];
            
            x = app.ReconstructionRunDataSetVoxelDimsXEditField.Value;
            y = app.ReconstructionRunDataSetVoxelDimsYEditField.Value;
            z = app.ReconstructionRunDataSetVoxelDimsZEditField.Value;
            
            recon.reconDataSetVoxelDimensions = [x, y, z];
            
            recon.interpolateDetectorData = app.ReconstructionRunInterpolateDetectorDataCheckBox.Value;
            
            recon.reconDataSetInterpolationType = app.ReconstructionRun3DInterpolationTypeDropDown.Value;
            
            xy = app.ReconstructionRunWholeDetectorDimsXYEditField.Value;
            z = app.ReconstructionRunWholeDetectorDimsZEditField.Value;
            
            recon.processingWholeDetectorDimensions = [xy, z];
            
            xy = app.ReconstructionRunPixelDimsXYEditField.Value;
            z = app.ReconstructionRunPixelDimsZEditField.Value;
            
            recon.processingSingleDetectorDimensions = [xy, z];
            
            recon.useRayRejection = app.ReconstructionRunUseRayExclusionCheckBox.Value;
            
            recon = recon.createFromGUIForSubClass(app);
        end
        
        function recon = setReconDataSetDefaults(recon, phantom, detector)
            % set defaults for the reconDataSet based on the phantom and
            % detector dimensions
            
            if isempty(phantom)
                dims = [256 256 256]; % default
                voxelDimsInM = [0.5 0.5 0.5]; % default (0.5mm isotropic)
            else
                phantom = phantom.loadFields('');
                phantomDataSet = phantom.dataSet;
                
                dims = phantomDataSet.getSize();
                voxelDimsInM = phantom.getVoxelDimensionsInM();
            end
            
            recon.reconSliceDimensions = dims(1:3);
            recon.reconSliceVoxelDimensions = voxelDimsInM(1:3);
                        
            recon.reconDataSetDimensions = dims;
            recon.reconDataSetVoxelDimensions = voxelDimsInM;
                    
            recon.interpolateDetectorData = false;
            
            if ~isempty(detector)
                recon.processingWholeDetectorDimensions = detector.wholeDetectorDimensions;
                recon.processingSingleDetectorDimensions = recon.processingSingleDetectorUnits.convertFromM(detector.getSingleDetectorDimensionsInM());
            else
                recon.processingWholeDetectorDimensions = [256 256];
                recon.processingSingleDetectorDimensions = [0.5 0.5];
            end
        end
        
        function savePath = getSavePath(recon, simulationRunSavePath)
            
            lastReconNumber = getLastReconNumber(simulationRunSavePath);
            numStr = num2str(lastReconNumber+1);
            algoStr = recon.getNameString();
            
            defaultName = [Constants.Reconstruction_Folder_Name, ' ', numStr, ' (', algoStr, ')'];
            
            savePath = makePath(simulationRunSavePath, defaultName);
        end
        
        function dimsInM = getReconDataSetVoxelDimensionsInM(recon)
            dimsInM = recon.reconDataSetVoxelDimensionUnits.convertToM(recon.reconDataSetVoxelDimensions);
        end
        
        function dimsInM = getReconSliceVoxelDimensionsInM(recon)
            dimsInM = recon.reconSliceVoxelDimensionUnits.convertToM(recon.reconSliceVoxelDimensions);
        end
        
        function strings = getReconstructionSettingsString(recon)
            str1 = 'Reconstruction Settings:';
            
            sliceDimString = makeDimensionString(recon.reconSliceDimensions);
            
            str2 = ['Slice Dimensions: ' sliceDimString];
            
            voxelDimsInMM = Units.mm.convertFromM(recon.getReconSliceVoxelDimensionsInM());
            sliceVoxelDimString = makeDimensionString(voxelDimsInMM);
            
            str3 = ['Slice Voxel Dimensions (mm): ', sliceVoxelDimString];
            
            dataSetDimString = makeDimensionString(recon.reconDataSetDimensions);
            
            str4 = ['Data Set Dimensions: ' dataSetDimString];
            
            voxelDimsInMM = Units.mm.convertFromM(recon.getReconDataSetVoxelDimensionsInM());
            dataSetVoxelDimString = makeDimensionString(voxelDimsInMM);
            
            str5 = ['Data Set Voxel Dimensions (mm): ', dataSetVoxelDimString];
            
            strings = {str1 str2 str3 str4 str5};
        end
        
        function [projectionData, rayRejectionMaps, simulationOrImagingScanRun] = organizeDataForReconstruction(reconstruction, simulationOrImagingScanRun)
                
            [scanGeometry] = simulationOrImagingScanRun.findScanGeometry();
            
            % interpolate data from what resolution it was obtained at to
            % resolution the reconstruction will use
            [projectionData, rayRejectionMaps] = scanGeometry.compileProjectionData(...
                simulationOrImagingScanRun, reconstruction);
            projectionData(isnan(projectionData)) = 0;
            
            % clear out original data
            simulationOrImagingScanRun.sliceData = {};
        end
        
        function [projectionData, rayRejectionMaps, simulationOrImagingScanRun] = getCachedReconstructionData(recon, simulationOrImagingScanRun)
            filename = recon.getCachedProjectionDataFilename();
            
            loadPath = makePath(simulationOrImagingScanRun.savePath, Constants.Projection_Data_Cache_Folder, filename);
            
            if exist(loadPath, 'file')
                data = load(loadPath);
                
                projectionData = data.('projectionData');
                rayRejectionMaps = data.('rayRejectionMaps');
                
                simulationOrImagingScanRun.sliceData = {};
            else
                [projectionData, rayRejectionMaps, simulationOrImagingScanRun] = ...
                    recon.organizeDataForReconstruction(simulationOrImagingScanRun);
                
                if ~exist(makePath(simulationOrImagingScanRun.savePath, Constants.Projection_Data_Cache_Folder), 'dir')
                    mkdir(simulationOrImagingScanRun.savePath, Constants.Projection_Data_Cache_Folder);
                end
                
                save(loadPath, 'projectionData', 'rayRejectionMaps');
            end
        end
        
        function filename = getCachedProjectionDataFilename(recon)
            xy = recon.processingWholeDetectorDimensions(1);
            z = recon.processingWholeDetectorDimensions(2);
            
            detectorDims = [num2str(xy), 'x' num2str(z)];
            
            dimsInM = recon.getSingleDetectorDimensionsInM();
            dimsInMM = dimsInM * Constants.m_to_mm;
            
            pixelDims = [num2str(dimsInMM(1)), 'x', num2str(dimsInMM(2)),'mm'];
            
            if recon.useRayRejection
                rayReject = 'RR';
            else
                rayReject = '';
            end
            
            filename = ['Projection Data (', detectorDims, ')(', pixelDims, ')(', rayReject, ')', Constants.Matlab_File_Extension];
        end
        
        function recon = reconFullDataSet(recon, simulationOrImagingScanRun)
            recon.reconDataSet = recon.reconDataSetSlices{1};
%             phantom = simulationOrImagingScanRun.phantom;
%             
%             reconLocationInM = calculateNewPhantomLocationForReconstruction(...
%                 phantom.getLocationInM(), phantom.getVoxelDimensionsInM(), phantom.dataSet.getSize(),...
%                 recon.reconDataSetVoxelDimensionsInM, recon.reconDataSetDimensions);
%             
%             recon.reconDataSetLocationInM = reconLocationInM;
%             
%             sliceLocationsInM = simulationOrImagingScanRun.scan.getSlicesInM();
            
%             recon.reconDataSet = reconstructDataSetFromReconstructedSlices(...
%                 recon.reconDataSetSlices, sliceLocationsInM,...
%                 reconLocationInM, recon.reconDataSetVoxelDimensionsInM, recon.reconDataSetDimensions,...
%                 recon.reconSliceLocationInM, recon.reconSliceVoxelDimensionsInM, recon.reconSliceDimensions,...
%                 recon.reconDataSetInterpolationType);
        end
        
        function [] = saveOuput(recon, savePath)
            % call individualized saveOutput for each child class
            recon.saveOutputSubclass(savePath);
            
            % save slices
            sliceFolder = Constants.Recon_Slices_Folder_Name;
            
            mkdir(savePath, sliceFolder);
            
            slices = recon.reconDataSetSlices;
            numSlices = length(slices);
            
            % find min and max for window setting
            allSliceMin = inf;
            allSliceMax = -inf;
            
            for i=1:numSlices
                sliceMin = allMin(slices{i});
                sliceMax = allMax(slices{i});
                
                allSliceMin = min([allSliceMin sliceMin]);
                allSliceMax = max([allSliceMax sliceMax]);
            end
            
            window = [allSliceMin allSliceMax]; %for max contrast
            
            % save slices to .png and .mat
            for i=1:numSlices
                baseFilename = [Constants.Recon_Slices_File_Name, ' ', num2str(i)];
                
                slice = slices{i};
                
                dims = size(slice);
                middleZ = ceil(dims(3)./2);
                slice = slice(:,:,middleZ);
                
                adjSlice = applyContrastToMaximizeGrayscale(slice, window, 1);
                
                % write slice to png
                filename = [baseFilename, Constants.PNG_File_Extension];
                
                imwrite(adjSlice, makePath(savePath, sliceFolder, filename));
                
                % write to matlab file
                filename = [baseFilename, Constants.Matlab_File_Extension];
                
                reconData = slices{i};
                save(makePath(savePath, sliceFolder, filename), Constants.Recon_Slice_Data_Var_Name);
            end
        end
        
        function dimsInM = getSingleDetectorDimensionsInM(recon)
            dimsInM = recon.processingSingleDetectorUnits.convertToM(recon.processingSingleDetectorDimensions);
        end
            
    end
    
end

% HELPER FUNCTIONS

function string = makeDimensionString(dims)
    string = '';
    
    numDims = length(dims);
    
    for i=1:numDims
        if i == numDims
            string = [string num2str(dims(i))];
        else
            string = [string num2str(dims(i)) ' x '];
        end
    end
end

function lastReconNumber = getLastReconNumber(path)
    
folders = getFolders(path);

lastReconNumber = 0;

prefixLen = length(Constants.Reconstruction_Folder_Name);

for i=1:length(folders)
    folderName = folders{i};
    
    indices = strfind(folderName, Constants.Reconstruction_Folder_Name);
    
    if ~isempty(indices)
        index = indices(1);
        
        searchStart = index + prefixLen;
        
        num = searchStringForNumber(folderName(searchStart:end));
        
        if ~isempty(num) && num > lastReconNumber
            lastReconNumber = num;
        end
    end
end

end

function num = searchStringForNumber(string)

num = [];

digits = [];
digitCounter = 1;
started = false;

for i=1:length(string)
    c = string(i);
    
    if isstrprop(c, 'digit')
        digits(digitCounter) = str2double(c);
        
        digitCounter = digitCounter + 1;
        started = true;
    elseif started
        break;
    end
end

if digitCounter > 1
    num = 0;
    power = 0;
    
    for i=length(digits):-1:1
        num = num + digits(i)*10^power;
        
        power = power + 1;
    end
end

end