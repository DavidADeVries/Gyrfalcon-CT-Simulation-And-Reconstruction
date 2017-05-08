classdef SimulationRun < ProcessingRun
    % SimulationRun
    % Holds data from when the simulation in question was run
    %
    % FIELDS:
    % *simulation
    % See Simulation class. Holds the Simulation used during the Simulation
    % Run
    %
    % *startTimestamp
    % Unix timestamp of when the simulation run began
    %
    % *endTimestamp
    % Unix timestamp of when the simulation run ended
    %
    % *displayFreeRun
    % boolean that is true if and only if no display/visualizations were
    % turned on during the simulation run. This would allow for maximum speed
    % in the simulation run. Comparing simulation run speeds from runs with
    % any display/visualizations activated is not recommended, as these
    % would bog down run times
    %
    % *computerInfo
    % string with some notes about the computerArchitectureUsed
    
    
    properties
        simulation
        
        displayFreeRun
        
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
                sliceFolder = [Constants.Slice_Folder, ' ', num2str(i)];
                
                path = makePath(basePath, sliceFolder);
                
                data = SliceData;
                
                data = data.loadData(path, sim);
                
                sliceData{i} = data;
            end
            
            run.sliceData = sliceData;
            
        end
        
        function run = setDefaultValues(run)
            run.simulation = [];
            run.displayFreeRun = false;
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
            run.computerInfo.gpuUsed = app.SimulationRunUseGPUCheckBox.Value;
            run.computerInfo.numCoresUsed = app.SimulationRunNumCPUsEditField.Value;
            run.notes = app.SimulationRunNotesTextArea.Value;
        end
        
        function handles = setGUIForDatasetReconstruction(run, handles)
            if isempty(run.getPath())
                setString(handles.simulationRunPathText, 'No Simulation Run Selected');
                
                set(handles.simulationRunShowSimulationInControlPanelToggleButton, 'Enable', 'off', 'Value', 0);
            else
                setString(handles.simulationRunPathText, run.saveFileName);
                
                set(handles.simulationRunShowSimulationInControlPanelToggleButton, 'Enable', 'on');
            end
            
            if isempty(run.startTimestamp)
                setString(handles.simulationRunStartText, '');
                setString(handles.simulationRunRunTimeText, '');
            else
                startText = datestr(run.startTimestamp, 'mmm dd, yyyy HH:MM:SS');
                
                runTimeText = run.getRunTimeString();
                
                setString(handles.simulationRunStartText, startText);
                setString(handles.simulationRunRunTimeText, runTimeText);
            end
            
            if isempty(run.versionUsed)
                setString(handles.simulationRunGyrfalconVersionText, '');
            else
                setString(handles.simulationRunGyrfalconVersionText, ['v', run.versionUsed]);
            end
            
            set(handles.simulationRunDisplayFreeRunCheckbox, 'Value', run.displayFreeRun);
            
            if isempty(run.computerInfo)
                setString(handles.simulationRunComputerInfoText, '');
            else
                setString(handles.simulationRunComputerInfoText, run.computerInfo.getSummaryString());
            end
            
            setString(handles.simulationRunNotesText, run.notes);
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
            
            % use GPU checkbox
            app.SimulationRunUseGPUCheckBox.Value = run.computerInfo.gpuUsed;
            
            if isempty(run.computerInfo.gpuDevice)
                app.SimulationRunUseGPUCheckBox.Enable = 'off';
            else
                app.SimulationRunUseGPUCheckBox.Enable = 'on';
            end
            
            % number of CPUs
            app.SimulationRunNumCPUsEditField.Value = run.computerInfo.numCoresUsed;
            app.SimulationRunNumCPUsEditField.Limits = [1 run.computerInfo.cpuNumCores];
            
            numCPUsAvailableString = ['/' num2str(run.computerInfo.cpuNumCores)];
            app.SimulationRunNumCPUsAvailableLabel.Text = numCPUsAvailableString;
            
            % notes
            app.SimulationRunNotesTextArea.Value = run.notes;
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

