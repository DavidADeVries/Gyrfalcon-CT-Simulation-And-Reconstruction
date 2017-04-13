classdef FirstGenFilteredBackprojectionReconstruction < Reconstruction
    % FirstGenFilteredBackprojectionReconstruction
    
    properties
        displayName = 'Filtered Backprojection'
        fullName = 'Filtered Backprojection (1st Gen)'
        
        filterType = FirstGenFilterTypes.none % these filters (Shepp-Logan, cosine, Hann, etc.) are all noise reduction filters NOT for frequency space weighting
        applyRampFilter = true % boolean of whether to use a ramp (Ram-Lak) filter. This weights the data in frequency space accordingly
        
        applyBandlimiting = true % bandlimiting based on detector widths
        
        interpolationType = InterpolationTypes.linear;
        
        % Data Sets to Save
        
        % reconDataSet (in Reconstruction class)
        sinograms        
        reconVideosFrames
    end
    
    methods        
        function recon = FirstGenFilteredBackprojectionReconstruction()
            
        end
        
        function strings = getSettingsString(recon)
            str1 = ['Filter Type: ', recon.filterType.displayString];
            str2 = ['Apply Ramp Filter: ', convertBoolToYesNo(recon.applyRampFilter)];
            str3 = ['Apply Bandlimiting: ', convertBoolToYesNo(recon.applyBandlimiting)];
            str4 = ['Interpolation Type: ', recon.interpolationType.displayString];

            strings1 = {str1 str2 str3 str4};
            
            strings2 = recon.getReconstructionSettingsString();
            
            strings = [strings1, {''}, strings2];
        end
        
        function [filterTypes, filterTypeStrings] = getFilterTypes(recon)
            [filterTypes, filterTypeStrings] = enumeration(FirstGenFilterTypes);
        end
        
        function recon = changeSettings(recon)
            recon = firstGenFilteredBackprojectionReconSettingsGUI(recon);
        end
        
        function string = getNameString(recon)
            string = '1st Gen. FBP';
        end
        
        function recon = runReconstruction(recon, simulationRun, handles)
            firstGenData = simulationRun.compileProjectionDataFor1stGenRecon();
            
            simulation = simulationRun.simulation;
            phantom = simulation.phantom;
            
            photonBeam = simulationRun.simulation.scan.beamCharacterization;
            
            scanAngles = simulation.scan.getScanAnglesInDegrees();
            sourceStartingLocationInM = simulation.source.getLocationInM();
            
            reconSliceDimensions = recon.reconSliceDimensions;
            reconSliceDimensions = reconSliceDimensions(1:2); % just need x,y
            
            reconSliceVoxelDimsInM = recon.reconSliceVoxelDimensionsInM;
            reconSliceVoxelDimsInM  = reconSliceVoxelDimsInM(1:2); % just need x,y
                        
            slicePhantomLocationInM = calculateNewPhantomLocationForReconstruction(...
                phantom.getLocationInM(), phantom.getVoxelDimensionsInM(), phantom.dataSet.getSize(),...
                recon.reconSliceVoxelDimensionsInM, recon.reconSliceDimensions);

            detectorWidthInM = simulation.detector.getSingleDetectorDimensionsInM();
            detectorWidthInM = detectorWidthInM(1);
            
            filterType = recon.filterType;
            applyRampFilter = recon.applyRampFilter;
            applyBandlimiting = recon.applyBandlimiting;
            interpolationType = recon.interpolationType;
            
            [reconDataSetSlices, sinograms, reconVideosFrames] = firstGenFilteredBackProjectionAlgorithm(...
                firstGenData, photonBeam,...
                scanAngles, sourceStartingLocationInM,...
                reconSliceDimensions, reconSliceVoxelDimsInM, slicePhantomLocationInM, detectorWidthInM,...
                filterType, applyRampFilter, applyBandlimiting, interpolationType);
                            
            recon.reconDataSetSlices = reconDataSetSlices;
            recon.sinograms = sinograms;
            recon.reconVideosFrames = reconVideosFrames;
            
            recon.reconSliceLocationInM = slicePhantomLocationInM;
        end
    end
    
end

