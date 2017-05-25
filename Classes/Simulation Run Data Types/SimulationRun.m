classdef SimulationRun < ProcessingRun
    % SimulationRun
    % Holds data from when the simulation in question was run
    %
    % FIELDS:
    % *simulation
    % See Simulation class. Holds the Simulation used during the Simulation
    % Run
    %
    % *performanceType
    % See SimulationRunPerformanceTypes
    % Holds an enumeration value specifying the performance setting for the
    % simulation run (low, high, high with multiple CPUs, etc.)
    %
    % *startTimestamp
    % Unix timestamp of when the simulation run began
    %
    % *endTimestamp
    % Unix timestamp of when the simulation run ended
    %
    % *computerInfo
    % string with some notes about the computerArchitectureUsed
    
    
    properties
        simulation
        
        performanceType
                
        sliceData
    end
    
    methods
        function simulationRun = SimulationRun(simulation)
            
        end
        
        function run = loadData(run, basePath) %use given basePath in case files are moved around
            sim = run.simulation;
            
            numSlices = length(sim.scan.slices);
                        
            sliceData = cell(1, numSlices);
            
            for i=1:numSlices
                sliceFolder = makeSliceFolderName(i);
                
                path = makePath(basePath, sliceFolder);
                
                data = SliceData;
                
                data = data.loadData(path, sim);
                
                sliceData{i} = data;
            end
            
            run.sliceData = sliceData;
            
        end
        
        function run = setDefaultValues(run)
            run.simulation = [];
            run.performanceType = SimulationRunPerformanceTypes.high;
            run.sliceData = [];
            
            run.startTimestamp = [];
            run.endTimestamp = [];
            
            run.computerInfo = ComputerInfo();
            run.versionUsed = Constants.version;
            
            run.notes = '';
            run.savePath = '';
            run.saveFileName = '';
        end
        
        function run = createFromGUI(run, app)
            if app.SimulationRunLowPerformanceButton.Value
                run.performanceType = SimulationRunPerformanceTypes.low;
            elseif app.SimulationRunHighPerformanceButton.Value
                run.performanceType = SimulationRunPerformanceTypes.high;
            elseif app.SimulationRunHighWithMultipleCPUsButton.Value
                run.performanceType = SimulationRunPerformanceTypes.highWithMultipleCPUs;
            elseif app.SimulationRunHighWithGPUButton.Value
                run.performanceType = SimulationRunPerformanceTypes.highWithGPU;
            else
                error('Invalid radio button state!');
            end
            
            if run.performanceType == SimulationRunPerformanceTypes.highWithMultipleCPUs
                run.computerInfo.numCoresUsed = app.SimulationRunNumCPUsEditField.Value;
            else
                run.computerInfo.numCoresUsed = 1;
            end
            
            run.notes = app.SimulationRunNotesTextArea.Value;
        end
                
        function app = setGUIForScanSimulationViewer(run, app)
            if isempty(run.getPath())
                app.SimulationViewerFilePathLabel.Text = 'No Simulation Run Selected';
                
                app.SimulationViewerSliceListBox.Enable = 'off';
                app.SimulationViewerScanAngleListBox.Enable = 'off';
                app.SimulationViewerPerAngleTranslationPositionListBox.Enable = 'off';
                
                app.SimulationViewerSliceListBox.Items = {};
                app.SimulationViewerScanAngleListBox.Items = {};
                app.SimulationViewerPerAngleTranslationPositionListBox.Items = {};
                
                app.SimulationViewerInfoStartDateTimeEditField.Value = '';
                app.SimulationViewerInfoRunPerformanceEditField.Value = '';
                app.SimulationViewerInfoGyrfalconVersionEditField.Value = '';
                app.SimulationViewerInfoRunTimeEditField.Value = '';
                app.SimulationViewerInfoComputerArchitectureSummaryTextArea.Value = '';
                app.SimulationViewerInfoNotesTextArea.Value = '';
                
                imshow([], 'Parent', app.SimulationViewerAxes);
            else
                app.SimulationViewerFilePathLabel.Text = run.savePath;
                
                app.SimulationViewerSliceListBox.Enable = 'on';
                app.SimulationViewerScanAngleListBox.Enable = 'on';
                app.SimulationViewerPerAngleTranslationPositionListBox.Enable = 'on';
                
                [sliceNames, angleNames, positionNames, positionFileNames] = run.getFolderNames();
                
                app.SimulationViewerSliceListBox.Items = sliceNames;
                app.SimulationViewerScanAngleListBox.Items = angleNames;
                app.SimulationViewerPerAngleTranslationPositionListBox.Items = positionNames;
                app.SimulationViewerPerAngleTranslationPositionListBox.ItemsData = positionFileNames;
                
                if isempty(app.SimulationViewerSliceListBox.Value)
                    app.SimulationViewerSliceListBox.Value = sliceNames{1};
                end
                
                if isempty(app.SimulationViewerScanAngleListBox.Value)
                    app.SimulationViewerScanAngleListBox.Value = angleNames{1};
                end
                
                if isempty(app.SimulationViewerPerAngleTranslationPositionListBox.Value)
                    app.SimulationViewerPerAngleTranslationPositionListBox.Value = positionFileNames{1};
                end
                
                app.SimulationViewerInfoStartDateTimeEditField.Value = datestr(run.startTimestamp, 'mmm dd, yyyy HH:MM:SS');
                app.SimulationViewerInfoRunPerformanceEditField.Value = run.performanceType.displayString;
                app.SimulationViewerInfoGyrfalconVersionEditField.Value = ['v', run.versionUsed];
                app.SimulationViewerInfoRunTimeEditField.Value = run.getRunTimeString();
                app.SimulationViewerInfoComputerArchitectureSummaryTextArea.Value = run.computerInfo.getSummaryString();
                app.SimulationViewerInfoNotesTextArea.Value = run.notes;
                
                image = run.loadImageForScanSimulationViewer(app);
                
                imshow(image, [], 'Parent', app.SimulationViewerAxes);
                
                dims = size(image);
                
                app.SimulationViewerAxes.XLim = [0 dims(2)+0.5];
                app.SimulationViewerAxes.YLim = [0 dims(1)+0.5];
                app.SimulationViewerAxes.BackgroundColor = [0 0 0];
            end            
        end
        
        function app = setGUIForScanSimulation(run, app)
            % save path
            path = run.getPath();
            
            if isempty(path)
                app.SimulationRunSavePathLabel.Text = 'Select Path...';
                
                app.ScanSimRunSimulationButton.Enable = 'off';
            else
                app.SimulationRunSavePathLabel.Text = path;
                
                app.ScanSimRunSimulationButton.Enable = 'on';
            end
            
            % set which radio button is selected for performance type
            
            if run.performanceType == SimulationRunPerformanceTypes.low
                app.SimulationRunLowPerformanceButton.Value = 1;
            elseif run.performanceType == SimulationRunPerformanceTypes.high
                app.SimulationRunHighPerformanceButton.Value = 1;
            elseif run.performanceType == SimulationRunPerformanceTypes.highWithMultipleCPUs
                app.SimulationRunHighWithMultipleCPUsButton.Value = 1;
            elseif run.performanceType == SimulationRunPerformanceTypes.highWithGPU
                app.SimulationRunHighWithGPUButton.Value = 1;
            else
                error('Invalid radio button state!');
            end
                             
            % number of CPUs
            app.SimulationRunNumCPUsEditField.Value = run.computerInfo.numCoresUsed;
            app.SimulationRunNumCPUsEditField.Limits = [1 run.computerInfo.cpuNumCores];
            
            numCPUsAvailableString = ['/' num2str(run.computerInfo.cpuNumCores)];
            app.SimulationRunNumCPUsAvailableLabel.Text = numCPUsAvailableString;
            
            app = setSimulationRunComponentEnableFromPerformanceType(app, run.performanceType);
            
            % notes
            app.SimulationRunNotesTextArea.Value = run.notes;
        end
        
        function [sliceNames, angleNames, positionNames, positionFileNames] = getFolderNames(run)
            numSlices = length(run.simulation.scan.slices);
            
            angles = run.simulation.scan.getScanAnglesInDegrees();
            numAngles = length(angles);
            
            positionDims = run.simulation.scan.perAngleTranslationDimensions;
            
            xyNumSteps = positionDims(1);
            zNumSteps = positionDims(2);
            
            numSteps = xyNumSteps*zNumSteps;
            
            sliceNames = cell(numSlices,1);
            angleNames = cell(numAngles,1);
            positionNames = cell(numSteps,1);
            positionFileNames = cell(numSteps,1);
            
            for i=1:numSlices
                sliceNames{i} = makeSliceFolderName(i);
            end
            
            for i=1:numAngles
                angleNames{i} = makeAngleFolderName(angles(i));
            end
            
            for i=1:zNumSteps
                for j=1:xyNumSteps
                    index = (i-1)*zNumSteps + j;
                    
                    positionNames{index} = makePositionName(i,j);
                    positionFileNames{index} = makePositionFileName(positionNames{index});
                end
            end
            
        end
        
        function image = loadImageForScanSimulationViewer(run, app)
            % get selected folders/files
            sliceFolder = app.SimulationViewerSliceListBox.Value;
            angleFolder = app.SimulationViewerScanAngleListBox.Value;
            positionDetectorDataFilename = app.SimulationViewerPerAngleTranslationPositionListBox.Value; %ItemData used to the filename
            
            loadPath = makePath(run.savePath,...
                sliceFolder,...
                angleFolder,...
                positionDetectorDataFilename);
            
            fileData = load(loadPath);
            
            image = fileData.(Constants.Detector_Data_Var_Name);
        end
        
        function simulationRun = startRun(simulationRun)
            simulationRun = simulationRun.startProcessingRun();
            
            simulationRun = simulationRun.createSaveDir();
        end
        
        function simulationRun = endRun(simulationRun)
            simulationRun = simulationRun.endProcessingRun();
            
            % SimulationRun specific
            simulationRun.sliceData = [];
        end
        
        function run = clearBeforeSave(run)
            for i=1:length(run.sliceData)
                run.sliceData{i} = run.sliceData{i}.clearBeforeSave();
            end
            
            % clear out big chunks of data in simulation data structure,
            % everything else archived.
            run.simulation.phantom.dataSet.data = [];
            run.simulation.scan.beamCharacterization.calibratedPhantomDataSet = [];
        end
        
        function run = createSaveDir(run)
            path = run.savePath;
            dirName = removeFileExtension(run.saveFileName);
            
            mkdir(path,dirName);
            
            run.savePath = makePath(path,dirName);
        end
          
        function firstGenData = compileProjectionDataFor1stGenRecon(run)
            slices = run.sliceData;

            numSlices = length(slices);

            firstGenData = cell(1,numSlices);
            
            for i=1:numSlices
                firstGenData{i} = slices{i}.compileProjectionDataFor1stGenRecon();
            end
        end
        
    end
    
end

