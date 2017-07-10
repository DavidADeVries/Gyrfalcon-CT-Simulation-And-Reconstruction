classdef ReconstructionRun < ProcessingRun
    %ReconstructionRun
    
    properties
        reconstruction
        
        simulationOrImagingScanRun
        
        reconPhantomDataSet %reconDataSet but interpolated to size of phantom data set (NaN at voxels if reconDataSet smaller than phantom)
        
        performanceType
    end
    
    methods
        function run = createFromGUI(run, app)
            if app.ReconstructionRunHighPerformanceButton.Value
                run.performanceType = ReconstructionRunPerformanceTypes.high;
            elseif app.ReconstructionRunHighWithMultipleCPUsButton.Value
                run.performanceType = ReconstructionRunPerformanceTypes.highWithMultipleCPUs;
            elseif app.ReconstructionRunHighWithGPUButton.Value
                run.performanceType = ReconstructionRunPerformanceTypes.highWithGPU;
            else
                error('Invalid performace type!');
            end
            
            if run.performanceType == ReconstructionRunPerformanceTypes.highWithMultipleCPUs
                run.computerInfo.numCoresUsed = app.ReconstructionRunNumCPUsEditField.Value;
            else
                run.computerInfo.numCoresUsed = 1;
            end
            
            if run.performanceType == ReconstructionRunPerformanceTypes.highWithGPU
                run.computerInfo.gpuUsed = true;
            else
                run.computerInfo.gpuUsed = false;
            end
            
            run.notes = app.ReconstructionRunNotesTextArea.Value;
            
            if ~strcmp(class(run.reconstruction), class(Reconstruction))
                run.reconstruction = run.reconstruction.createFromGUI(app);
            end
        end
        
        function app = setGUI(run, app)
                        
            % simulationRun 
            if isempty(run.simulationOrImagingScanRun)
                scanGeometry = [];
                erroMsg = '';

                app.SimulationRunInfoLoadPathLabel.Text = 'Simulation/Imaging Run Not Loaded';
                
                app.SimulationRunInfoStartDateTimeEditField.Value = '';
                app.SimulationRunInfoRunTimeEditField.Value = '';
                app.SimulationRunInfoGyrfalconVersionEditField.Value = '';
                app.SimulationRunInfoRunPerformanceEditField.Value = ''; 
                
                app.SimulationRunInfoInterpretedScanGeometryTextArea.Value = {''};
                app.SimulationRunInfoComputerArchitectureSummaryTextArea.Value = {''};
                app.SimulationRunInfoNotesTextArea.Value = {''};
                
                app.SimulationRunInfoLoadSimulationButton.Enable = 'off';
            else
                [scanGeometry, errorMsg] = run.simulationOrImagingScanRun.findScanGeometry();

                run.simulationOrImagingScanRun.setGUIForReconstructionRun(app);
            end
                            
            % reconstructionRun
            savePath = run.getPath();
            
            if isempty(savePath)
                app.ReconstructionRunSavePathEditField.Value = 'Select save path...';
            else
                app.ReconstructionRunSavePathEditField.Value = savePath;
            end
            
            if isempty(scanGeometry)
                app.ReconstructionRunAlgorithmDropDown.Enable = 'off';
                app.ReconstructionRunAlgorithmDropDown.Items = {'Invalid Scan Geometry'};
                app.ReconstructionRunAlgorithmDropDown.ItemsData = {};
                
                app.DataSetReconRunReconstructionButton.Enable = 'off';
                
                % clear out tabs
                hideAllAlgorithmSettingsTabs(app);
            else
                app.ReconstructionRunAlgorithmDropDown.Enable = 'on';
                
                setAlgorithmSelectionPopupMenu(...
                    app.ReconstructionRunAlgorithmDropDown,...
                    scanGeometry,...
                    run.reconstruction)
                
                app.DataSetReconRunReconstructionButton.Enable = 'on';
                
                % set recon type specific GUI elements, including selecting
                % tab
                app = run.reconstruction.setGUI(app);
            end
            
            % recon settings
            app.ReconstructionRunSliceDimsXEditField.Value = run.reconstruction.reconSliceDimensions(1);
            app.ReconstructionRunSliceDimsYEditField.Value = run.reconstruction.reconSliceDimensions(2);
            app.ReconstructionRunSliceDimsZEditField.Value = run.reconstruction.reconSliceDimensions(3);
            
            % convert to mm
            pixelDimsInMM = Units.mm.convertFromM(run.reconstruction.reconSliceVoxelDimensionsInM);
            
            app.ReconstructionRunSlicePixelDimsXEditField.Value = pixelDimsInMM(1);
            app.ReconstructionRunSlicePixelDimsYEditField.Value = pixelDimsInMM(2);
            app.ReconstructionRunSlicePixelDimsZEditField.Value = pixelDimsInMM(3);
            
            app.ReconstructionRunDataSetDimsXEditField.Value = run.reconstruction.reconDataSetDimensions(1);
            app.ReconstructionRunDataSetDimsYEditField.Value = run.reconstruction.reconDataSetDimensions(2);
            app.ReconstructionRunDataSetDimsZEditField.Value = run.reconstruction.reconDataSetDimensions(3);
            
            % convert to mm
            voxelDimsInMM = Units.mm.convertFromM(run.reconstruction.reconDataSetVoxelDimensionsInM);
            
            app.ReconstructionRunDataSetVoxelDimsXEditField.Value = voxelDimsInMM(1);
            app.ReconstructionRunDataSetVoxelDimsYEditField.Value = voxelDimsInMM(2);
            app.ReconstructionRunDataSetVoxelDimsZEditField.Value = voxelDimsInMM(3);
            
            % interpolation type drop-down
            app.ReconstructionRun3DInterpolationTypeDropDown.Value = run.reconstruction.reconDataSetInterpolationType;
                        
            
            % number of CPUs
            app.ReconstructionRunNumCPUsEditField.Value = run.computerInfo.numCoresUsed;
            app.ReconstructionRunNumCPUsEditField.Limits = [1 run.computerInfo.cpuNumCores];
            
            numCPUsAvailableString = ['/' num2str(run.computerInfo.cpuNumCores)];
            app.ReconstructionRunNumCPUsAvailableLabel.Text = numCPUsAvailableString;
            
            app = setReconstructionRunComponentEnableFromPerformanceType(app, run.performanceType);
            
            % notes
            app.ReconstructionRunNotesTextArea.Value = run.notes;
        end
        
        function [scanGeometry, errorMsg] = getScanGeometry(run)
            if isempty(run.simulationOrImagingScanRun)
                scanGeometry = [];
                errorMsg = 'No Simulation/Imaging Scan Selected';
            else
                [scanGeometry, errorMsg] = run.simulationOrImagingScanRun.findScanGeometry();
            end
        end
        
        function run = setDefaultValues(run)
            run.reconstruction = Reconstruction();
            run.simulationOrImagingScanRun = [];
            
            run.performanceType = ReconstructionRunPerformanceTypes.high;
            
            run.notes = '';
        end
        
        function currentFolder = getCurrentSaveFolder(run)
            currentFolder = getLastItemFromPath(run.savePath);
        end
        
        function [] = runReconstruction(run, app)
            run = run.createFromGUI(app);
            
            % set status string with recon running
            
            newString = ['Reconstruction Run Start (', convertTimestampToString(now), ')'];
            newLine = true;
            
            app = updateStatusOutput(app, newString, newLine);
            
            % run the recon
            run = run.startProcessingRun(); % set start time
            run.reconstruction = ...
                run.reconstruction.runReconstruction(run.simulationOrImagingScanRun, app);
            run = run.endProcessingRun(); % set end time
            
            % set status string complete
            
            newString = ['Reconstruction Run Complete (', convertTimestampToString(now), ')'];
            newLine = true;
            
            app = updateStatusOutput(app, newString, newLine);
            
            
            % perform the recon of the 3D data-set from recon'ed
            % slices
            
            run.reconstruction = run.reconstruction.reconFullDataSet(run.simulationOrImagingScanRun);
            
            % compare to the original phantom
            
            run = run.calculateReconPhantomDataSet();
            
            % save files
            run.saveReconstructionValues();                
        end
        
        function run = calculateReconPhantomDataSet(run)
            interpolationType = run.reconstruction.reconDataSetInterpolationType;
            
            recon = run.reconstruction;
            phantom = run.simulationRun.simulation.phantom;
            
            reconCompareSet = interpolateDataSetToNewCooords(...
                recon.reconDataSet, recon.reconDataSetLocationInM, recon.reconDataSetVoxelDimensionsInM, recon.reconDataSetDimensions,...
                phantom.getLocationInM(), phantom.getVoxelDimensionsInM(), phantom.getDataSetDimensions(),...
                interpolationType);
            
            run.reconPhantomDataSet = reconCompareSet;
        end
        
        function [] = saveReconstructionValues(run)
            % clear out simulationRun projection data
            run.simulationOrImagingScanRun.sliceData = {};
            
            % have reconstruction save any extra outputs
            run.reconstruction.saveOuput(run.savePath);
            
            % save this, the reconstruction run
            save(makePath(run.savePath, run.saveFileName), Constants.Processing_Run_Var_Name);
            
        end
        
    end
    
end


function [] = setAlgorithmSelectionPopupMenu(handle, scanGeometry, choice)
    [algorithmChoiceStrings, choices] = scanGeometry.getReconAlgorithmChoices();
    
    numChoices = length(choices);
    
    index = 1;
    
    choiceClass = class(choice);
    
    for i=1:numChoices
        if isa(choices{i}, choiceClass)
            index = i;
            break;
        end
    end
    
    handle.Items = algorithmChoiceStrings;
    handle.ItemsData = choices;
    handle.Value = choices{index};
end

