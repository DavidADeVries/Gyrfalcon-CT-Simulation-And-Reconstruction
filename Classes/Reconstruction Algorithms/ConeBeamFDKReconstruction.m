classdef ConeBeamFDKReconstruction < Reconstruction
    % ConeBeamFDKReconstruction
    
    properties
        displayName = 'FDK Algorithm [TIGRE]'
        fullName = 'FDK Algorithm (CBCT)'
                
        
        % specific for FDK
        parker = false
        filter = TigreFilterTypes.ramLakFilter
        forwardProjectionAccuracy = 0.5
    end
    
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.ConeBeamFDK_SettingsTab;
        end
    end
    
    methods
        function string = getNameString(recon)
            string = 'CBCT FDK';
        end     
        
        function recon = createFromGUIForSubClass(recon, app)
            
            recon.parker = app.CBCT_FDK_ParkerCheckBox.Value;
            recon.filter = app.CBCT_FDK_FilterDropDown.Value;
        end
        
        function app = setGUI(recon, app)
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
            
            % set drop-down options
            setDropDownOptions(...
                app.CBCT_FDK_FilterDropDown,...
                enumeration('TigreFilterTypes'),...
                'displayString');
            
            % set settings  
            app.CBCT_FDK_ParkerCheckBox.Value = recon.parker;
        end
                
        function recon = runReconstruction(recon, reconRun, simulationOrImagingScanRun, app, projectionData, rayRejectionMaps)
            % get everything converted for TIGRE
            [projectionData, ~, tigreGeometry, tigreAnglesInRadians] = ...
                getValuesForTigreReconstruction(recon, simulationOrImagingScanRun, projectionData, rayRejectionMaps);
            
            % run reconstruction            
                reconDataSet = FDK(projectionData, tigreGeometry, tigreAnglesInRadians,...
                    'parker', recon.parker,...
                    'filter', recon.filter.tigreString);
            
            % convert data set to Gyrfalcon units
            reconDataSet = convertReconDataSetFromTigreToGyrfalcon(reconDataSet);
            
            % set to the Reconstruction object
            recon.reconDataSetSlices = {reconDataSet};
        end
        
        function [] = saveOutputSubclass(recon, savePath)
            % nothing special to do here 
        end
    end
    
end
