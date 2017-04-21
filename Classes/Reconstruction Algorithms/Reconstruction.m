classdef Reconstruction
    % Reconstruction
    
    properties
        reconDataSetSlices % the reconstructed data set slices (cell array of slices)
        
        reconDataSet % the 3D reconstructed data set (which can be compared to the original phantom)
        
        reconSliceDimensions % number of voxels in x,y,z for each slice
        reconSliceVoxelDimensionsInM % dimension of each voxel in data set
        reconSliceLocationInM
        
        reconDataSetDimensions % number of voxels in x,y,z for dataset
        reconDataSetVoxelDimensionsInM % dimension of each voxel
        reconDataSetLocationInM
        
        reconDataSetInterpolationType = InterpolationTypes3D.spline
    end
    
    methods
        function recon = Reconstruction()
            
        end
        
        function recon = setReconDataSetDefaults(recon, phantom)
            % set defaults for the reconDataSet based on the phantom
            % dimensions
            
            phantomDataSet = phantom.dataSet;
            
            dims = phantomDataSet.getSize();
            voxelDimsInM = phantom.getVoxelDimensionsInM();
            
            recon.reconSliceDimensions = dims(1:2);
            recon.reconSliceVoxelDimensionsInM = voxelDimsInM(1:2);
            
            recon.reconDataSetDimensions = dims;
            recon.reconDataSetVoxelDimensionsInM = voxelDimsInM;
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