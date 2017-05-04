function [] = simulationRunSavePathChangeButtonCallback(app)
%[] = simulationRunSavePathChangeButtonCallback(app)

simulationRun = app.workspace.simulationRun;

simulationRun = simulationRun.createFromGUI(app);

[cancel, simulationRun] = simulationRun.collectSavePathAndFilename();

if ~cancel
    app.workspace.simulationRun = simulationRun;
    
    app = simulationRun.setGUIForScanSimulation(app);
end

end
