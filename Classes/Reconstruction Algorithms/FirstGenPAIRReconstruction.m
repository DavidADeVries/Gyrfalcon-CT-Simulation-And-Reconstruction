classdef FirstGenPAIRReconstruction < Reconstruction
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
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
        end
        
        function string = getNameString(recon)
            string = '1st Gen. PAIR';
        end
              
        function recon = createFromGUIForSubClass(recon, app)
            % nothing yet
        end
        
    end
    
end

