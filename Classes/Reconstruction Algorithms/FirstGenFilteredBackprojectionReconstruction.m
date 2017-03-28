classdef FirstGenFilteredBackprojectionReconstruction < ProcessingRun
    % FirstGenFilteredBackprojectionReconstruction
    
    properties
        displayName = 'Filtered Backprojection'
        fullName = 'Filtered Backprojection (1st Gen)'
        
        applyRampFilter = true% boolean of whether to use a ramp (Ram-Lak) filter. This weights the data in frequency space accordingly
        filterType = FirstGenFilterTypes.none % these filters (Shepp-Logan, cosine, Hann, etc.) are all noise reduction filters NOT for frequency space weighting
        
        applyBandlimiting = true % bandlimiting based on detector widths
        
        interpolationType = InterpolationTypes.linear;
    end
    
    methods
        
        function strings = getSettingsString(recon)
            strings = {'No Settings'};            
        end
        
        function [filterTypes, filterTypeStrings] = getFilterTypes(recon)
            [filterTypes, filterTypeStrings] = enumeration(FirstGenFilterTypes);
        end
        
        function recon = changeSettings(recon)
            recon = firstGenFilteredBackprojectionReconSettingsGUI(recon);
        end
    end
    
end

