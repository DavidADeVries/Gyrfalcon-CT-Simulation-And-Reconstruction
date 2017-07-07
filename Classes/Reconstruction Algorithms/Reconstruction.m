classdef Reconstruction
    % Reconstruction
    
    properties
        reconDataSetSlices % the reconstructed data set slices (cell array of slices)
        
        reconDataSet % the 3D reconstructed data set (which can be compared to the original phantom)
        
        reconSliceDimensions = [0 0]% number of voxels in x,y,z for each slice
        reconSliceVoxelDimensionsInM = [0 0]% dimension of each voxel in data set
        reconSliceLocationInM
        
        reconDataSetDimensions = [0 0 0] % number of voxels in x,y,z for dataset
        reconDataSetVoxelDimensionsInM = [0 0 0] % dimension of each voxel
        reconDataSetLocationInM
        
        reconDataSetInterpolationType = InterpolationTypes3D.spline
    end
    
    methods
        function recon = Reconstruction()
            
        end
        
        function recon = transferReconstructionValues(recon, oldRecon)
            recon.reconDataSetSlices = oldRecon.reconDataSetSlices;
            recon.reconDataSet = oldRecon.reconDataSet;
            recon.reconSliceDimensions = oldRecon.reconSliceDimensions;
            recon.reconSliceVoxelDimensionsInM = oldRecon.reconSliceVoxelDimensionsInM;
            recon.reconSliceLocationInM = oldRecon.reconSliceLocationInM;
            recon.reconDataSetDimensions = oldRecon.reconDataSetDimensions;
            recon.reconDataSetVoxelDimensionsInM = oldRecon.reconDataSetVoxelDimensionsInM;
            recon.reconDataSetLocationInM = oldRecon.reconDataSetLocationInM;
            recon.reconDataSetInterpolationType = oldRecon.reconDataSetInterpolationType;
        end
        
        function recon = createFromGUI(recon, app)
            x = app.ReconstructionRunSliceDimsXEditField.Value;
            y = app.ReconstructionRunSliceDimsYEditField.Value;
            
            recon.reconSliceDimensions = [x, y];
            
            x = app.ReconstructionRunSlicePixelDimsXEditField.Value;
            y = app.ReconstructionRunSlicePixelDimsYEditField.Value;
            
            recon.reconSliceVoxelDimensionsInM = [x, y] .* Constants.mm_to_m;
            
            x = app.ReconstructionRunDataSetDimsXEditField.Value;
            y = app.ReconstructionRunDataSetDimsYEditField.Value;
            z = app.ReconstructionRunDataSetDimsZEditField.Value;
            
            recon.reconDataSetDimensions = [x, y, z];
            
            x = app.ReconstructionRunDataSetVoxelDimsXEditField.Value;
            y = app.ReconstructionRunDataSetVoxelDimsYEditField.Value;
            z = app.ReconstructionRunDataSetVoxelDimsZEditField.Value;
            
            recon.reconDataSetVoxelDimensionsInM = [x, y, z];
            
            recon.reconDataSetInterpolationType = app.ReconstructionRun3DInterpolationTypeDropDown.Value;
            
            recon = recon.createFromGUIForSubClass(app);
        end
        
        function recon = setReconDataSetDefaults(recon, phantom)
            % set defaults for the reconDataSet based on the phantom
            % dimensions
            
            if isempty(phantom)
                dims = [256 256 256]; % default
                voxelDimsInM = [1 1 1] .* Constants.mm_to_m; % default (1mm isotropic)
            else
                phantomDataSet = phantom.dataSet;
                
                dims = phantomDataSet.getSize();
                voxelDimsInM = phantom.getVoxelDimensionsInM();
            end
            
            recon.reconSliceDimensions = dims(1:2);
            recon.reconSliceVoxelDimensionsInM = voxelDimsInM(1:2);
                        
            recon.reconDataSetDimensions = dims;
            recon.reconDataSetVoxelDimensionsInM = voxelDimsInM;
        end
        
        function savePath = getSavePath(recon, simulationRunSavePath)
            
            lastReconNumber = getLastReconNumber(simulationRunSavePath);
            numStr = num2str(lastReconNumber+1);
            algoStr = recon.getNameString();
            
            defaultName = [Constants.Reconstruction_Folder_Name, ' ', numStr, ' (', algoStr, ')'];
            
            savePath = makePath(simulationRunSavePath, defaultName);
        end
        
        function strings = getReconstructionSettingsString(recon)
            str1 = 'Reconstruction Settings:';
            
            sliceDimString = makeDimensionString(recon.reconSliceDimensions);
            
            str2 = ['Slice Dimensions: ' sliceDimString];
            
            voxelDimsInMM = Units.mm.convertFromM(recon.reconSliceVoxelDimensionsInM);
            sliceVoxelDimString = makeDimensionString(voxelDimsInMM);
            
            str3 = ['Slice Voxel Dimensions (mm): ', sliceVoxelDimString];
            
            dataSetDimString = makeDimensionString(recon.reconDataSetDimensions);
            
            str4 = ['Data Set Dimensions: ' dataSetDimString];
            
            voxelDimsInMM = Units.mm.convertFromM(recon.reconDataSetVoxelDimensionsInM);
            dataSetVoxelDimString = makeDimensionString(voxelDimsInMM);
            
            str5 = ['Data Set Voxel Dimensions (mm): ', dataSetVoxelDimString];
            
            strings = {str1 str2 str3 str4 str5};
        end
        
        function recon = reconFullDataSet(recon, simulation)
            phantom = simulation.phantom;
            
            reconLocationInM = calculateNewPhantomLocationForReconstruction(...
                phantom.getLocationInM(), phantom.getVoxelDimensionsInM(), phantom.dataSet.getSize(),...
                recon.reconDataSetVoxelDimensionsInM, recon.reconDataSetDimensions);
            
            recon.reconDataSetLocationInM = reconLocationInM;
            
            sliceLocationsInM = simulation.scan.getSlicesInM();
            
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
            
            % save slices to PNG
            for i=1:numSlices
                slice = slices{i};
                
                adjSlice = applyContrastToMaximizeGrayscale(slice, window, 1);
                
                filename = [Constants.Recon_Slices_File_Name, ' ', num2str(i), Constants.PNG_File_Extension];
                
                imwrite(adjSlice, makePath(savePath, sliceFolder, filename));
            end
        end
    end
    
end

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