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
        function strings = getSettingsString(recon)
            str1 = ['Filter Type: ', recon.filterType.displayString];
            str2 = ['Apply Ramp Filter: ', convertBoolToYesNo(recon.applyRampFilter)];
            str3 = ['Apply Bandlimiting: ', convertBoolToYesNo(recon.applyBandlimiting)];
            str4 = ['Interpolation Type: ', recon.interpolationType.displayString];

            strings = {str1 str2 str3 str4};            
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
            
            scanAngles = simulation.scan.getScanAnglesInDegrees();
            sourceStartingLocationInM = simulation.source.getLocationInM();
            
            phantomSliceDimensions = size(simulation.phantom.dataSet.data);
            phantomSliceDimensions = phantomSliceDimensions(1:2); % just need x,y
            
            phantomVoxelDimensionsInM = simulation.phantom.getVoxelDimensionsInM();
            phantomVoxelDimensionsInM  = phantomVoxelDimensionsInM(1:2); % just need x,y
            
            phantomLocationInM = simulation.phantom.getLocationInM();
            phantomLocationInM  = phantomLocationInM(1:2); % just need x,y

            detectorWidthInM = simulation.detector.getSingleDetectorDimensionsInM();
            detectorWidthInM = detectorWidthInM(1);
            
            filterType = recon.filterType;
            applyRampFilter = recon.applyRampFilter;
            applyBandlimiting = recon.applyBandlimiting;
            interpolationType = recon.interpolationType;
            
            [reconDataSet, sinograms, reconVideosFrames] = firstGenFilteredBackProjectionAlgorithm(...
                firstGenData,...
                scanAngles, sourceStartingLocationInM,...
                phantomSliceDimensions, phantomVoxelDimensionsInM, phantomLocationInM, detectorWidthInM,...
                filterType, applyRampFilter, applyBandlimiting, interpolationType);
                            
            recon.reconDataSet = reconDataSet;
            recon.sinograms = sinograms;
            recon.reconVideosFrames = reconVideosFrames;
        end
    end
    
end

