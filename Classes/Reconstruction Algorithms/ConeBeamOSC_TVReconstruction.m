classdef ConeBeamOSC_TVReconstruction < Reconstruction
    % ConeBeamOSC_TVReconstruction
    
    properties
        displayName = 'OSC-TV Algorithm'
        fullName = 'OSC-TV Algorithm (CBCT)'
                
        % reconstruction settings (for TIGRE)
        numberOfIterations = 10
        forwardProjectionAccuracy = 0.25
        
        % specific for OSC-TV
        initialBlockSize = 26
        finalBlockSize = 2
        blockSizeReductionPower = 1/2
        
        orderStrategy = TigreOrderStrategies.angularDistance
        
        numberOfTvIterations = 20
        
        c = 0.25
    end
        
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.ConeBeamOSCTVSettingsTab;
        end
    end
    
    methods
        function string = getNameString(recon)
            string = 'CBCT OSC-TV';
        end     
        
        function recon = createFromGUIForSubClass(recon, app)            
            recon.numberOfIterations = app.CBCT_OSCTV_NumberOfIterationsEditField.Value;
            recon.forwardProjectionAccuracy = app.CBCT_OSCTV_ForwardProjectionAccuracyEditField.Value;
            
            recon.initialBlockSize = app.CBCT_OSCTV_InitialBlockSizeEditField.Value;
            recon.finalBlockSize = app.CBCT_OSCTV_FinalBlockSizeEditField.Value;
            recon.blockSizeReductionPower = app.CBCT_OSCTV_BlockSizeReductionPowerEditField.Value;
            
            recon.orderStrategy = app.CBCT_OSCTV_OrderStrategyDropDown.Value;
            
            recon.numberOfTvIterations = app.CBCT_OSCTV_NumberOfTvIterationsEditField.Value;
            recon.c = app.CBCT_OSCTV_CEditField.Value;
        end
        
        function app = setGUI(recon, app)
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
            
            % set drop-down options
            setDropDownOptions(...
                app.CBCT_OSCTV_OrderStrategyDropDown,...
                enumeration('TigreOrderStrategies'),...
                'displayString');
            
            % set settings              
            app.CBCT_OSCTV_NumberOfIterationsEditField.Value = recon.numberOfIterations;
            app.CBCT_OSCTV_ForwardProjectionAccuracyEditField.Value = recon.forwardProjectionAccuracy;
            
            app.CBCT_OSCTV_InitialBlockSizeEditField.Value = recon.initialBlockSize;
            app.CBCT_OSCTV_FinalBlockSizeEditField.Value = recon.finalBlockSize;
            app.CBCT_OSCTV_BlockSizeReductionPowerEditField.Value = recon.blockSizeReductionPower;
            
            app.CBCT_OSCTV_OrderStrategyDropDown.Value = recon.orderStrategy;
            
            app.CBCT_OSCTV_NumberOfTvIterationsEditField.Value = recon.numberOfTvIterations;
            app.CBCT_OSCTV_CEditField.Value = recon.c;
        end
                
        function recon = runReconstruction(recon, reconRun, simulationOrImagingScanRun, app, projectionData_I0, projectionData_I, rayRejectionMaps)
            % get everything converted for TIGRE
            [projectionData_I0, projectionData_I, rayRejectionMaps, tigreGeometry, tigreAnglesInRadians] = ...
                getValuesForTigreReconstruction(recon, simulationOrImagingScanRun, projectionData_I0, projectionData_I, rayRejectionMaps);
               
            % run reconstruction            
            reconDataSet = OSC_TV(...
                app,...
                projectionData_I0, projectionData_I,...
                tigreGeometry, tigreAnglesInRadians,...
                recon.numberOfIterations,...
                recon.useRayRejection,...
                'initialBlockSize', recon.initialBlockSize,...
                'finalBlockSize', recon.finalBlockSize,...
                'blockSizeReductionPower', recon.blockSizeReductionPower,...
                'OrderStrategy', recon.orderStrategy.tigreString,...
                'TViter', recon.numberOfTvIterations,...
                'c', recon.c);
            
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
