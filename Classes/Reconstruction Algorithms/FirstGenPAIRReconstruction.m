classdef FirstGenPAIRReconstruction < ProcessingRun
    % FirstGenPAIRReconstruction
    
    properties
        displayName = 'PAIR'
        fullName = 'PAIR (1st Gen)'
    end
    
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.Gen1PAIR_SettingsTab;
        end
    end
    
    methods
        
        function app = setGUI(recon, app)
        end
        
        function strings = getSettingsString(recon)            
            strings = {'No Settings'};           
        end
        
    end
    
end

