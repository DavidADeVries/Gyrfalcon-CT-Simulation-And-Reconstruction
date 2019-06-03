classdef ConeBeamCGLSReconstruction < Reconstruction
    % ConeBeamCGLSReconstruction
    
    properties
        displayName = 'CGLS Algorithm [TIGRE]'
        fullName = 'CGLS Algorithm (CBCT)'
                
        % reconstruction settings (for TIGRE)
        numberOfIterations = 25
        forwardProjectionAccuracy = 0.5
        
        % specific for CGLS
        initialImage = TigreInitialImageChoices.none
        verbosity = true
    end
        
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.ConeBeamCGLSSettingsTab;
        end
    end
    
    methods
        function string = getNameString(recon)
            string = 'CBCT CGLS';
        end     
        
        function recon = createFromGUIForSubClass(recon, app)
            recon.useRayRejection = app.CBCT_CGLS_RayRejectionCheckBox.Value;
            
            recon.numberOfIterations = app.CBCT_CGLS_NumberOfIterationsEditField.Value;
            recon.forwardProjectionAccuracy = app.CBCT_CGLS_ForwardProjectionAccuracyEditField.Value;
            
            recon.initialImage = app.CBCT_CGLS_InitialImageDropDown.Value;
            recon.verbosity = app.CBCT_CGLS_VerboseCheckBox.Value;
        end
        
        function app = setGUI(recon, app)
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
            
            % set drop-down options
            setDropDownOptions(...
                app.CBCT_CGLS_InitialImageDropDown,...
                enumeration('TigreInitialImageChoices'),...
                'displayString');
            
            % set settings  
            app.CBCT_CGLS_RayRejectionCheckBox.Value = recon.useRayRejection;
            
            app.CBCT_CGLS_NumberOfIterationsEditField.Value = recon.numberOfIterations;
            app.CBCT_CGLS_ForwardProjectionAccuracyEditField.Value = recon.forwardProjectionAccuracy;
            
            app.CBCT_CGLS_InitialImageDropDown.Value = recon.initialImage;
            app.CBCT_CGLS_VerboseCheckBox.Value = recon.verbosity;
        end
                
        function recon = runReconstruction(recon, reconRun, simulationOrImagingScanRun, app, projectionData, rayRejectionMaps)
            % get everything converted for TIGRE
            [projectionData, rayRejectionMaps, tigreGeometry, tigreAnglesInRadians] = ...
                getValuesForTigreReconstruction(recon, simulationOrImagingScanRun, projectionData, rayRejectionMaps);
            
            % run reconstruction
            if recon.useRayRejection                                
                reconDataSet = CGLS_withRayRejection(projectionData, rayRejectionMaps, tigreGeometry, tigreAnglesInRadians,...
                    recon.numberOfIterations,...
                    'Init', recon.initialImage.tigreString,...
                    'Verbose', recon.verbosity);
            else
                reconDataSet = CGLS(projectionData, tigreGeometry, tigreAnglesInRadians,...
                    recon.numberOfIterations,...
                    'Init', recon.initialImage.tigreString,...
                    'Verbose', recon.verbosity);
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
