classdef ConeBeamFDKReconstruction < ProcessingRun
    % ConeBeamFDKReconstruction
    
    properties
        displayName = 'FDK Algorithm'
        fullName = 'FDK Algorithm (CBCT)'
    end
    
    methods
        
        function strings = getSettingsString(recon)
            strings = {'No Settings'};          
        end
        
    end
    
end

