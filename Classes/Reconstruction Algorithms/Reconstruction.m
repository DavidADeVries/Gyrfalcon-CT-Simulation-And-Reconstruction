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
            
            recon.reconDataSet = reconstructDataSetFromReconstructedSlices(...
                recon.reconDataSetSlices, sliceLocationsInM,...
                reconLocationInM, recon.reconDataSetVoxelDimensionsInM, recon.reconDataSetDimensions,...
                recon.reconSliceLocationInM, recon.reconSliceVoxelDimensionsInM, recon.reconSliceDimensions,...
                recon.reconDataSetInterpolationType);
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