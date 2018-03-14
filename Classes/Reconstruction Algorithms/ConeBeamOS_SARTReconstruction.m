classdef ConeBeamOS_SARTReconstruction < Reconstruction
    % ConeBeamOS_SARTReconstruction
    
    properties
        displayName = 'OS-SART Algorithm [TIGRE]'
        fullName = 'OS-SART Algorithm (CBCT)'
        
        % reconstruction settings (for TIGRE)
        numberOfIterations = 25
        forwardProjectionAccuracy = 0.5
        
        % specific for OS-SART
        blockSize = 20
        lambda = 1
        lambdaReduction = 0.95
        initialImage = TigreInitialImageChoices.none
        orderStrategy = TigreOrderStrategies.angularDistance
        verbosity = true
    end
    
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.ConeBeamOSSARTSettingsTab;
        end
    end
    
    methods
        function string = getNameString(recon)
            string = 'CBCT OS-SART';
        end     
        
        function recon = createFromGUIForSubClass(recon, app)
            recon.useRayRejection = app.CBCT_OSSART_RayRejectionCheckBox.Value;
            
            recon.numberOfIterations = app.CBCT_OSSART_NumberOfIterationsEditField.Value;
            recon.forwardProjectionAccuracy = app.CBCT_OSSART_ForwardProjectionAccuracyEditField.Value;
            
            recon.blockSize = app.CBCT_OSSART_BlockSizeEditField.Value;
            recon.lambda = app.CBCT_OSSART_LambdaEditField.Value;
            recon.lambdaReduction = app.CBCT_OSSART_LambdaReductionEditField.Value;
            recon.initialImage = app.CBCT_OSSART_InitialImageDropDown.Value;
            recon.orderStrategy = app.CBCT_OSSART_OrderStrategyDropDown.Value;
            recon.verbosity = app.CBCT_OSSART_VerboseCheckBox.Value;
        end
        
        function app = setGUI(recon, app)
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
            
            % set drop-down options
            setDropDownOptions(...
                app.CBCT_OSSART_InitialImageDropDown,...
                enumeration('TigreInitialImageChoices'),...
                'displayString');
            setDropDownOptions(...
                app.CBCT_OSSART_OrderStrategyDropDown,...
                enumeration('TigreOrderStrategies'),...
                'displayString');
            
            % set settings  
            app.CBCT_OSSART_RayRejectionCheckBox.Value = recon.useRayRejection;
            
            app.CBCT_OSSART_NumberOfIterationsEditField.Value = recon.numberOfIterations;
            app.CBCT_OSSART_ForwardProjectionAccuracyEditField.Value = recon.forwardProjectionAccuracy;
            
            app.CBCT_OSSART_BlockSizeEditField.Value = recon.blockSize;
            app.CBCT_OSSART_LambdaEditField.Value = recon.lambda;
            app.CBCT_OSSART_LambdaReductionEditField.Value = recon.lambdaReduction;
            app.CBCT_OSSART_InitialImageDropDown.Value = recon.initialImage;
            app.CBCT_OSSART_OrderStrategyDropDown.Value = recon.orderStrategy;
            app.CBCT_OSSART_VerboseCheckBox.Value = recon.verbosity;
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
                
                reconDataSet = OS_SART_withRayRejection(projections, rejectionMaps, tigreGeometry, tigreAnglesInRadians,...
                    recon.numberOfIterations,...
                    'BlockSize', recon.blockSize,...
                    'lambda', recon.lambda,...
                    'lambda_red', recon.lambdaReduction,...
                    'Init', recon.initialImage.tigreString,...
                    'Verbose', recon.verbosity,...
                    'OrderStrategy', recon.orderStrategy.tigreString);
            else
                reconDataSet = OS_SART(projections, tigreGeometry, tigreAnglesInRadians,...
                    recon.numberOfIterations,...
                    'BlockSize', recon.blockSize,...
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
