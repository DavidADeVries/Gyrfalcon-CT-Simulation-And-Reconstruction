function [] = dataSetReconLoadSimulationRunButtonCallback(app)
% [] = dataSetReconLoadSimulationRunButtonCallback(app)

filterSpec = '*.mat';
dialogTitle = 'Open Simulation Run...';
defaultName = app.settings.Simulation_And_Reconstruction_Run_Save_Path;

[fileName, pathName, ~] = uigetfile(filterSpec, dialogTitle, defaultName);

if ~all(fileName == 0) % have a selection
    openPath = [pathName, fileName];
    
    loadedData = load(openPath);
    
    if isfield(loadedData, Constants.Processing_Run_Var_Name)
        simulationRun = loadedData.(Constants.Processing_Run_Var_Name);
        
        if isa(simulationRun, class(SimulationRun)) % we're good!
            h = popupMessage('Loading Simulation Run projection data...', 'Loading...');
            simulationRun = simulationRun.loadData(pathName);
            delete(h);
            
            workspace = app.workspace.createFromGUI(app);
                        
            scanGeometry = simulationRun.simulation.findScanGeometry();
            
            if ~isempty(scanGeometry)
                choice = scanGeometry.getDefaultAlgorithmChoice();
                
                choice = choice.setReconDataSetDefaults(simulationRun.simulation.phantom);
                
                reconRun = ReconstructionRun;
                
                reconRun = reconRun.setDefaultValues();
                
                savePath = choice.getSavePath(simulationRun.savePath);                
                reconRun.savePath = savePath;
                
                reconRun.reconstruction = choice;
                reconRun.simulationRun = simulationRun;
            else
                reconRun = ReconstructionRun;
                reconRun = reconRun.setDefaultValues();
            end
            
            workspace.reconstructionRun = reconRun;
            
            app.workspace = workspace;
            
            app = app.workspace.setGUI(app);
        else
            errordlg('The selected file was not a Simulation Run file and so could not be opened.', 'Invalid File');
        end
    else
        errordlg('The selected file was not a Simulation Run file and so could not be opened.', 'Invalid File');
    end
else
    
end

end

