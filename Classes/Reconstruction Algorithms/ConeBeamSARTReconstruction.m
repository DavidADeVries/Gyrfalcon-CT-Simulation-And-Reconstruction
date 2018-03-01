classdef ConeBeamSARTReconstruction < Reconstruction
    % ConeBeamSARTReconstruction
    
    properties
        displayName = 'SART Algorithm [TIGRE]'
        fullName = 'SART Algorithm (CBCT)'
        
        % reconstruction settings (for Gyrfalcon)
        useRayRejection = false
        
        % reconstruction settings (for TIGRE)
        numberOfIterations = 25
        forwardProjectionAccuracy = 0.5
        
        % specific for SART
        lambda = 1
        lambdaReduction = 0.95
        initialImage = TigreInitialImageChoices.none
        orderStrategy = TigreOrderStrategies.angularDistance
        verbosity = true
    end
    
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.ConeBeamSARTSettingsTab;
        end
    end
    
    methods
        function string = getNameString(recon)
            string = 'CBCT SART';
        end     
        
        function recon = createFromGUIForSubClass(recon, app)
            recon.useRayRejection = app.CBCT_SART_RayRejectionCheckBox.Value;
            
            recon.numberOfIterations = app.CBCT_SART_NumberOfIterationsEditField.Value;
            recon.forwardProjectionAccuracy = app.CBCT_SART_ForwardProjectionAccuracyEditField.Value;
            
            recon.lambda = app.CBCT_SART_LambdaEditField.Value;
            recon.lambdaReduction = app.CBCT_SART_LambdaReductionEditField.Value;
            recon.initialImage = app.CBCT_SART_InitialImageDropDown.Value;
            recon.orderStrategy = app.CBCT_SART_OrderStrategyDropDown.Value;
            recon.verbosity = app.CBCT_SART_VerboseCheckBox.Value;
        end
        
        function app = setGUI(recon, app)
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
            
            % set drop-down options
            setDropDownOptions(...
                app.CBCT_SART_InitialImageDropDown,...
                enumeration('TigreInitialImageChoices'),...
                'displayString');
            setDropDownOptions(...
                app.CBCT_SART_OrderStrategyDropDown,...
                enumeration('TigreOrderStrategies'),...
                'displayString');
            
            % set settings  
            app.CBCT_SART_RayRejectionCheckBox.Value = recon.useRayRejection;
            
            app.CBCT_SART_NumberOfIterationsEditField.Value = recon.numberOfIterations;
            app.CBCT_SART_ForwardProjectionAccuracyEditField.Value = recon.forwardProjectionAccuracy;
            
            app.CBCT_SART_LambdaEditField.Value = recon.lambda;
            app.CBCT_SART_LambdaReductionEditField.Value = recon.lambdaReduction;
            app.CBCT_SART_InitialImageDropDown.Value = recon.initialImage;
            app.CBCT_SART_OrderStrategyDropDown.Value = recon.orderStrategy;
            app.CBCT_SART_VerboseCheckBox.Value = recon.verbosity;
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
                
                reconDataSet = SART_withRayRejection(projections, rejectionMaps, tigreGeometry, tigreAnglesInRadians,...
                    recon.numberOfIterations,...
                    'lambda', recon.lambda,...
                    'lambda_red', recon.lambdaReduction,...
                    'Init', recon.initialImage.tigreString,...
                    'Verbose', recon.verbosity,...
                    'OrderStrategy', recon.orderStrategy.tigreString);
            else
                reconDataSet = SART(projections, tigreGeometry, tigreAnglesInRadians,...
                    recon.numberOfIterations,...
                    'lambda', recon.lambda,...
                    'lambda_red', recon.lambdaReduction,...
                    'Init', recon.initialImage.tigreString,...
                    'Verbose', recon.verbosity,...
                    'OrderStrategy', recon.orderStrategy.tigreString);
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
