classdef FirstGenPAIRReconstruction < Reconstruction
    % FirstGenPAIRReconstruction
    
    properties
        displayName = 'PAIR'
        fullName = 'PAIR (1st Gen)'
        
        usePrecomputedAlphaMatrix
        alphaMatrixSavePath
        alphaMatrixSaveFileName
        
        useNonPartialWeighting
        nonPartialWeightingCutoff
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
            recon.useNonPartialWeighting = app.Gen1PAIR_UseNonPartialVoxelWeightingCheckBox.Value;
            recon.nonPartialWeightingCutoff = app.Gen1PAIR_NonPartialVoxelWeightingCutoffEditField.Value;
        end
        
        function recon = runReconstruction(recon, simulationRun, app)
            recon = firstGenPAIRAlgorithm(recon, simulationRun);
        end
                
    end
    
end