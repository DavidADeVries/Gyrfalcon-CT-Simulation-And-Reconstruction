classdef ConeBeamOS_ASD_POCSReconstruction < Reconstruction
    % ConeBeamOS_ASD_POCSReconstruction
    
    properties
        displayName = 'OS-ASD-POCS Algorithm [TIGRE]'
        fullName = 'OS-ASD-POCS Algorithm (CBCT)'
        
        % reconstruction settings (for Gyrfalcon)
        useRayRejection = false
        
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
        
        numberOfTvIterations = 20
        maxL2ErrorRatio = 0.2
        updateRatio = 0.95
        alpha = 0.002
        alphaReduction = 0.95
    end
        
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.ConeBeamOSASDPOCSSettingsTab;
        end
    end
    
    methods
        function string = getNameString(recon)
            string = 'CBCT OS-ASD-POCS';
        end     
        
        function recon = createFromGUIForSubClass(recon, app)
            recon.useRayRejection = app.CBCT_OSASDPOCS_RayRejectionCheckBox.Value;
            
            recon.numberOfIterations = app.CBCT_OSASDPOCS_NumberOfIterationsEditField.Value;
            recon.forwardProjectionAccuracy = app.CBCT_OSASDPOCS_ForwardProjectionAccuracyEditField.Value;
            
            recon.blockSize = app.CBCT_OSASDPOCS_BlockSizeEditField.Value;
            recon.lambda = app.CBCT_OSASDPOCS_LambdaEditField.Value;
            recon.lambdaReduction = app.CBCT_OSASDPOCS_LambdaReductionEditField.Value;
            recon.initialImage = app.CBCT_OSASDPOCS_InitialImageDropDown.Value;
            recon.orderStrategy = app.CBCT_OSASDPOCS_OrderStrategyDropDown.Value;
            recon.verbosity = app.CBCT_OSASDPOCS_VerboseCheckBox.Value;
            
            recon.numberOfTvIterations = app.CBCT_OSASDPOCS_NumberOfTvIterationsEditField.Value;
            recon.maxL2ErrorRatio = app.CBCT_OSASDPOCS_MaxL2ErrorRatioEditField.Value;
            recon.updateRatio = app.CBCT_OSASDPOCS_UpdateRatioEditField.Value;
            recon.alpha = app.CBCT_OSASDPOCS_AlphaEditField.Value;
            recon.alphaReduction = app.CBCT_OSASDPOCS_AlphaReductionEditField.Value;
        end
        
        function app = setGUI(recon, app)
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
            
            % set drop-down options
            setDropDownOptions(...
                app.CBCT_OSASDPOCS_InitialImageDropDown,...
                enumeration('TigreInitialImageChoices'),...
                'displayString');
            setDropDownOptions(...
                app.CBCT_OSASDPOCS_OrderStrategyDropDown,...
                enumeration('TigreOrderStrategies'),...
                'displayString');
            
            % set settings  
            app.CBCT_OSASDPOCS_RayRejectionCheckBox.Value = recon.useRayRejection;
            
            app.CBCT_OSASDPOCS_NumberOfIterationsEditField.Value = recon.numberOfIterations;
            app.CBCT_OSASDPOCS_ForwardProjectionAccuracyEditField.Value = recon.forwardProjectionAccuracy;
            
            app.CBCT_OSASDPOCS_BlockSizeEditField.Value = recon.blockSize;
            app.CBCT_OSASDPOCS_LambdaEditField.Value = recon.lambda;
            app.CBCT_OSASDPOCS_LambdaReductionEditField.Value = recon.lambdaReduction;
            app.CBCT_OSASDPOCS_InitialImageDropDown.Value = recon.initialImage;
            app.CBCT_OSASDPOCS_OrderStrategyDropDown.Value = recon.orderStrategy;
            app.CBCT_OSASDPOCS_VerboseCheckBox.Value = recon.verbosity;
            
            app.CBCT_OSASDPOCS_NumberOfTvIterationsEditField.Value = recon.numberOfTvIterations;
            app.CBCT_OSASDPOCS_MaxL2ErrorRatioEditField.Value = recon.maxL2ErrorRatio;
            app.CBCT_OSASDPOCS_UpdateRatioEditField.Value = recon.updateRatio;
            app.CBCT_OSASDPOCS_AlphaEditField.Value = recon.alpha;
            app.CBCT_OSASDPOCS_AlphaReductionEditField.Value = recon.alphaReduction;
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
                
                reconDataSet = OS_ASD_POCS_withRayRejection(projections, rejectionMaps, tigreGeometry, tigreAnglesInRadians,...
                    recon.numberOfIterations,...
                    'BlockSize', recon.blockSize,...
                    'lambda', recon.lambda,...
                    'lambda_red', recon.lambdaReduction,...
                    'Init', recon.initialImage.tigreString,...
                    'Verbose', recon.verbosity,...
                    'OrderStrategy', recon.orderStrategy.tigreString,...
                    'TViter', recon.numberOfTvIterations,...
                    'alpha', recon.alpha,...
                    'alpha_red', recon.alphaReduction,...
                    'maxL2err', im3Dnorm(FDK(projections, tigreGeometry, tigreAnglesInRadians),'L2')*recon.maxL2ErrorRatio,...
                    'Ratio', recon.updateRatio);
            else
                reconDataSet = OS_ASD_POCS(projections, tigreGeometry, tigreAnglesInRadians,...
                    recon.numberOfIterations,...
                    'BlockSize', recon.blockSize,...
                    'lambda', recon.lambda,...
                    'lambda_red', recon.lambdaReduction,...
                    'Init', recon.initialImage.tigreString,...
                    'Verbose', recon.verbosity,...
                    'OrderStrategy', recon.orderStrategy.tigreString,...
                    'TViter', recon.numberOfTvIterations,...
                    'alpha', recon.alpha,...
                    'alpha_red', recon.alphaReduction,...
                    'maxL2err', im3Dnorm(FDK(projections, tigreGeometry, tigreAnglesInRadians),'L2')*recon.maxL2ErrorRatio,...
                    'Ratio', recon.updateRatio);
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
