function scanSimRunSimulationButtonCallback(app)
% scanSimRunSimulationButtonCallback(app)
% using the current simulation parameters specified by the GUI a simulation
% is run

simulation = app.workspace.simulation;

simulation = simulation.createFromGUI(app);

displaySlices = app.SimulationRunShowSlicesCheckBox.Value;
displayAngles = app.SimulationRunShowAnglesCheckBox.Value;
displayPerAnglePosition = app.SimulationRunShowPerAngleRasterCheckBox.Value;
displayDetectorRaster = app.SimulationRunShowDetectorRasterCheckBox.Value;

displayDetectorValues = app.SimulationRunShowDetectorValuesCheckBox.Value;
displayDetectorRayTrace = app.SimulationRunShowDetectorRayTracesCheckBox.Value;

displayFreeRun = ~(displaySlices || displayAngles || displayPerAnglePosition || displayDetectorRaster || displayDetectorValues || displayDetectorRayTrace);

% set simulationRun
simulationRun = app.workspace.simulationRun;

simulationRun.displayFreeRun = displayFreeRun;
simulationRun.simulation = simulation;

if ~isempty(simulationRun) && simulationRun.isValidForSave()
    
    simulation = simulation.calibrateAndSetPhantomData();
    
    if ~displayFreeRun %no parallelization possible
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
    elseif simulationRun.computerInfo.usedGPU % GPU computation
        simulationRun = simulation.runScanSimulationHighPerformanceOnGPU(...
            simulationRun,...
            app);
    else % parallelized CPU computation        
        simulationRun = simulation.runScanSimulationHighPerformanceOnCPU(...
            simulationRun,...
            app);
    end
    
    simulationRun.clearBeforeSave();
    simulationRun.save();
end


end
