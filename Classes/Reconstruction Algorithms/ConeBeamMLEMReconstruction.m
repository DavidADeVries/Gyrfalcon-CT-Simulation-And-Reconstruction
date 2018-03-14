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
                
        function recon = runReconstruction(recon, reconRun, simulationOrImagingScanRun, app)
            % get everything converted for TIGRE
            [projections, tigreGeometry, tigreAnglesInRadians] = getValuesForTigreReconstruction(recon, simulationOrImagingScanRun);
               
            % run reconstruction
            if recon.useRayRejection
                rejectionMaps = single(zeros(size(projections)));
                anglesInDeg = simulationOrImagingScanRun.scan.getScanAnglesInDegrees();
                
                for i=1:length(anglesInDeg)
                    [~, rayExclusionMap] = loadProjectionAndRayExclusionMapDataFiles(simulationOrImagingScanRun, 1, anglesInDeg(i), 1, 1);
                    
                    rejectionMaps(:,:,i) = single(~rayExclusionMap);
                end
                
                reconDataSet = MLEM_withRayRejection(projections, rejectionMaps, tigreGeometry, tigreAnglesInRadians,...
                    recon.numberOfIterations);
            else
                reconDataSet = MLEM(projections, tigreGeometry, tigreAnglesInRadians,...
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
