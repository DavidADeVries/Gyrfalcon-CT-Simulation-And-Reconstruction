classdef ThirdGenFilteredBackprojectionReconstruction < ProcessingRun
    % ThirdGenFilteredBackprojectionReconstruction
    
    properties
        displayName = 'Filtered Backprojection'
        fullName = 'Filtered Backprojection (3rd Gen)'
    end
    
    methods
        
        function strings = getSettingsString(recon)
            strings = {'No Settings'};          
        end
        
        function [filterTypes, filterTypeStrings] = getFilterTypes(recon)
            [filterTypes, filterTypeStrings] = enumeration(ThirdGenFilterTypes);
        end
        
    end
    
end

