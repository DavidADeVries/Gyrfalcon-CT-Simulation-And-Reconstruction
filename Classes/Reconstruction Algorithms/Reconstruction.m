classdef Reconstruction
    % Reconstruction
    
    properties
        reconDataSetSlices % the reconstructed data set (cell array of slices)
        
        reconDataSet
        
        reconSliceDimensions % number of voxels in x,y,z for each slice
        reconSliceVoxelDimensionsInM % dimension of each voxel in data set
        
        reconDataSetDimensions % number of voxels in x,y,z for dataset
        reconDataSetVoxelDimensionsInM % dimension of each voxel
        
        reconDataSetInterpolationType = InterpolationTypes.cubic
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
            recon.reconDataSetVoxelDimensionsInM = voxelDimsInM(1:2);
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