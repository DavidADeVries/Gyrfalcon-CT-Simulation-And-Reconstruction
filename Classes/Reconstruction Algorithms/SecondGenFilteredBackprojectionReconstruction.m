classdef SecondGenFilteredBackprojectionReconstruction < ProcessingRun
    % SecondGenFilteredBackprojectionReconstruction
    
    properties
        displayName = 'Filtered Backprojection'
        fullName = 'Filtered Backprojection (2nd Gen)'
    end
    
    methods
        
        function strings = getSettingsString(recon)
            strings = {'No Settings'};            
        end
        
        function [filterTypes, filterTypeStrings] = getFilterTypes(recon)
            [filterTypes, filterTypeStrings] = enumeration(SecondGenFilterTypes);
        end
        
    end
    
end

