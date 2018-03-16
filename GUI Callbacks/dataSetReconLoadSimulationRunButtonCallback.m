function [] = dataSetReconLoadSimulationRunButtonCallback(app)
% [] = dataSetReconLoadSimulationRunButtonCallback(app)

filterSpec = '*.mat';
dialogTitle = 'Open Simulation Or Imaging Scan Run...';
defaultName = app.settings.Simulation_And_Reconstruction_Run_Save_Path;

[fileName, pathName, ~] = uigetfile(filterSpec, dialogTitle, defaultName);

if ~all(fileName == 0) % have a selection
    openPath = [pathName, fileName];
    
    loadedData = load(openPath);
    
    if isfield(loadedData, Constants.Processing_Run_Var_Name)
        simulationOrImagingScanRun = loadedData.(Constants.Processing_Run_Var_Name);
        
        if isa(simulationOrImagingScanRun, class(SimulationRun)) || isa(simulationOrImagingScanRun, class(ImagingScanRun))% we're good!
%             h = popupMessage('Loading projection data...', 'Loading...');
%             simulationOrImagingScanRun = simulationOrImagingScanRun.loadData(pathName);
%             delete(h);
            
            workspace = app.workspace.createFromGUI(app);
                        
            scanGeometry = simulationOrImagingScanRun.findScanGeometry();
            
            if ~isempty(scanGeometry)
                choice = scanGeometry.getDefaultAlgorithmChoice();
                
                choice = choice.setReconDataSetDefaults(...
                    simulationOrImagingScanRun.getPhantom(),...
                    simulationOrImagingScanRun.getDetector());
                
                reconRun = ReconstructionRun;
                
                reconRun = reconRun.setDefaultValues();
                
                savePath = choice.getSavePath(simulationOrImagingScanRun.savePath);                
                reconRun.savePath = savePath;
                
                reconRun.reconstruction = choice;
                reconRun.simulationOrImagingScanRun = simulationOrImagingScanRun;
            else
                reconRun = ReconstructionRun;
                reconRun = reconRun.setDefaultValues();
            end
            
            workspace.reconstructionRun = reconRun;
            
            app.workspace = workspace;
            
            app = app.workspace.setGUI(app);
        else
            errordlg('The selected file was not a Simulation or Imaging Scan Run file and so could not be opened.', 'Invalid File');
        end
    else
        errordlg('The selected file was not a Simulation Run file and so could not be opened.', 'Invalid File');
    end
else
    
end

end

