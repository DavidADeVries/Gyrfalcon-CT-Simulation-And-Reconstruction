function [] = simulationRunSavePathChangeButtonCallback(app)
%[] = simulationRunSavePathChangeButtonCallback(app)

simulationRun = app.workspace.simulationRun;

simulationRun = simulationRun.createFromGUI(app);

[cancel, simulationRun] = simulationRun.collectSavePathAndFilename(app.settings.Simulation_And_Reconstruction_Run_Save_Path);

if ~cancel
    app.workspace.simulationRun = simulationRun;
    
    app = simulationRun.setGUIForScanSimulation(app);
end

end
