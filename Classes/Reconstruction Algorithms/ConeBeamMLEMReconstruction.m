classdef ConeBeamMLEMReconstruction < Reconstruction
    % ConeBeamMLEMReconstruction
    
    properties
        displayName = 'MLEM Algorithm [TIGRE]'
        fullName = 'MLEM Algorithm (CBCT)'
                
        % reconstruction settings (for TIGRE)
        numberOfIterations = 25
        forwardProjectionAccuracy = 0.5
        
    end
    
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.ConeBeamMLEMSettingsTab;
        end
    end
    
    methods
        function string = getNameString(recon)
            string = 'CBCT MLEM';
        end     
        
        function recon = createFromGUIForSubClass(recon, app)
            recon.useRayRejection = app.CBCT_MLEM_RayRejectionCheckBox.Value;
            
            recon.numberOfIterations = app.CBCT_MLEM_NumberOfIterationsEditField.Value;
            recon.forwardProjectionAccuracy = app.CBCT_MLEM_ForwardProjectionAccuracyEditField.Value;
        end
        
        function app = setGUI(recon, app)
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
                        
            % set settings  
            app.CBCT_MLEM_RayRejectionCheckBox.Value = recon.useRayRejection;
            
            app.CBCT_MLEM_NumberOfIterationsEditField.Value = recon.numberOfIterations;
            app.CBCT_MLEM_ForwardProjectionAccuracyEditField.Value = recon.forwardProjectionAccuracy;
        end
                
        function recon = runReconstruction(recon, reconRun, simulationOrImagingScanRun, app, projectionData, rayRejectionMaps)
            % get everything converted for TIGRE
            [projectionData, rayRejectionMaps, tigreGeometry, tigreAnglesInRadians] = ...
                getValuesForTigreReconstruction(recon, simulationOrImagingScanRun, projectionData, rayRejectionMaps);
            
            % run reconstruction
            if recon.useRayRejection 
                reconDataSet = MLEM_withRayRejection(projectionData, rayRejectionMaps, tigreGeometry, tigreAnglesInRadians,...
                    recon.numberOfIterations);
            else
                reconDataSet = MLEM(projectionData, tigreGeometry, tigreAnglesInRadians,...
                    recon.numberOfIterations);
            end
            
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
