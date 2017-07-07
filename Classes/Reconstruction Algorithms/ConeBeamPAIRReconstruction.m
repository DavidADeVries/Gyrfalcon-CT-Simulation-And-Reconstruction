classdef ConeBeamPAIRReconstruction < Reconstruction
    % ConeBeamPAIRReconstruction
    
    properties
        displayName = 'PAIR Algorithm'
        fullName = 'PAIR Algorithm (CBCT)'

        rayTraceMatricesLoadPath

        rayTraceMatricesSavePath
        rayTraceMatricesSaveFileName

        alphaMatricesLoadPath

        alphaMatricesSavePath
        alphaMatricesSaveFileName

    end
    
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.ConeBeamPAIR_SettingsTab;
        end
    end
    
    methods
        function string = getNameString(recon)
            string = 'CBCT PAIR';
        end     
        
        function recon = createFromGUIForSubClass(recon, app)
            % no GUI fields yet
        end
        
        function app = setGUI(recon, app)
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
            
            % set settings
        end           
    end
    
end

