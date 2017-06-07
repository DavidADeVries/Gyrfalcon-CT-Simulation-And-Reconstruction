function scanSimRunSimulationButtonCallback(app)
% scanSimRunSimulationButtonCallback(app)
% using the current simulation parameters specified by the GUI a simulation
% is run

workspace = app.workspace.createFromGUI(app);
simulation = workspace.simulation;


% set simulationRun
simulationRun = workspace.simulationRun;

simulationRun.simulation = simulation;

if ~isempty(simulationRun) && simulationRun.isValidForSave()
    
    simulation = simulation.calibrateAndSetPhantomData();
    
    switch simulationRun.performanceType
        case SimulationRunPerformanceTypes.low
            displaySlices = app.SimulationRunShowSlicesCheckBox.Value;
            displayAngles = app.SimulationRunShowAnglesCheckBox.Value;
            displayPerAnglePosition = app.SimulationRunShowPerAngleRasterCheckBox.Value;
            displayDetectorRaster = app.SimulationRunShowDetectorRasterCheckBox.Value;
            
            displayDetectorValues = app.SimulationRunShowDetectorValuesCheckBox.Value;
            displayDetectorRayTrace = app.SimulationRunShowDetectorRayTracesCheckBox.Value;
            
            simulationRun = simulation.runScanSimulation(...
                simulationRun,...
                app.axesHandle,...
                displaySlices,...
                displayAngles,...
                displayPerAnglePosition,...
                displayDetectorRaster,...
                displayDetectorValues,...
                displayDetectorRayTrace,...
                app);
        case SimulationRunPerformanceTypes.high
            simulationRun = simulation.runScanSimulationHighPerformanceOnCPU(...
            simulationRun,...
            app);
        case SimulationRunPerformanceTypes.highWithMultipleCPUs
            simulationRun = simulation.runScanSimulationHighPerformanceOnCPU(...
            simulationRun,...
            app);            
        case SimulationRunPerformanceTypes.highWithGPU
            error('Run performance type of "High with GPU" is invalid in this release. No simulation can be run.');
        otherwise
            error('No run performance selected. No simulation can be run.');
    end
    
    % transfer the simulation run to the simulation run for viewing
    workspace.simulationRunForViewing = simulationRun;
        
    % save simulationRun data file
    simulationRun = simulationRun.clearBeforeSave();
    simulationRun.save();
    
    % reset simulationRun for running simulations
    workspace.simulationRun = SimulationRun;
    workspace.simulationRun = workspace.simulationRun.setDefaultValues;
    
    % set GUI
    drawnow;
    workspace.statusOutput = app.StatusOutputTextArea.Value;
    
    app.workspace = workspace;
    
    app = workspace.setGUI(app);
    resetScanSimulationViewerListBoxes(app)
    
    app.TabGroup.SelectedTab = app.ScanSimulationViewerTab;
    
end


end
