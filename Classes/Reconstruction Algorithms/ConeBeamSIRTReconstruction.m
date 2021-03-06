classdef ConeBeamSIRTReconstruction < Reconstruction
    % ConeBeamSIRTReconstruction
    
    properties
        displayName = 'SIRT Algorithm [TIGRE]'
        fullName = 'SIRT Algorithm (CBCT)'
                
        % reconstruction settings (for TIGRE)
        numberOfIterations = 25
        forwardProjectionAccuracy = 0.5
        
        % specific for SIRT
        lambda = 1
        lambdaReduction = 0.95
        initialImage = TigreInitialImageChoices.none
        verbosity = true
    end
    
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.ConeBeamSIRTSettingsTab;
        end
    end
    
    methods
        function string = getNameString(recon)
            string = 'CBCT SIRT';
        end     
        
        function recon = createFromGUIForSubClass(recon, app)
            recon.useRayRejection = app.CBCT_SIRT_RayRejectionCheckBox.Value;
            
            recon.numberOfIterations = app.CBCT_SIRT_NumberOfIterationsEditField.Value;
            recon.forwardProjectionAccuracy = app.CBCT_SIRT_ForwardProjectionAccuracyEditField.Value;
            
            recon.lambda = app.CBCT_SIRT_LambdaEditField.Value;
            recon.lambdaReduction = app.CBCT_SIRT_LambdaReductionEditField.Value;
            recon.initialImage = app.CBCT_SIRT_InitialImageDropDown.Value;
            recon.verbosity = app.CBCT_SIRT_VerboseCheckBox.Value;
        end
        
        function app = setGUI(recon, app)
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
            
            % set drop-down options
            setDropDownOptions(...
                app.CBCT_SIRT_InitialImageDropDown,...
                enumeration('TigreInitialImageChoices'),...
                'displayString');
            
            % set settings  
            app.CBCT_SIRT_RayRejectionCheckBox.Value = recon.useRayRejection;
            
            app.CBCT_SIRT_NumberOfIterationsEditField.Value = recon.numberOfIterations;
            app.CBCT_SIRT_ForwardProjectionAccuracyEditField.Value = recon.forwardProjectionAccuracy;
            
            app.CBCT_SIRT_LambdaEditField.Value = recon.lambda;
            app.CBCT_SIRT_LambdaReductionEditField.Value = recon.lambdaReduction;
            app.CBCT_SIRT_InitialImageDropDown.Value = recon.initialImage;
            app.CBCT_SIRT_VerboseCheckBox.Value = recon.verbosity;
        end
                
        function recon = runReconstruction(recon, reconRun, simulationOrImagingScanRun, app, projectionData, rayRejectionMaps)
            % get everything converted for TIGRE
            [projectionData, rayRejectionMaps, tigreGeometry, tigreAnglesInRadians] = ...
                getValuesForTigreReconstruction(recon, simulationOrImagingScanRun, projectionData, rayRejectionMaps);
               
            % run reconstruction
            if recon.useRayRejection
                reconDataSet = SIRT_withRayRejection(projectionData, rayRejectionMaps, tigreGeometry, tigreAnglesInRadians,...
                    recon.numberOfIterations,...
                    'lambda', recon.lambda,...
                    'lambda_red', recon.lambdaReduction,...
                    'Init', recon.initialImage.tigreString,...
                    'Verbose', recon.verbosity);
            else
                reconDataSet = SIRT(projectionData, tigreGeometry, tigreAnglesInRadians,...
                    recon.numberOfIterations,...
                    'lambda', recon.lambda,...
                    'lambda_red', recon.lambdaReduction,...
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
