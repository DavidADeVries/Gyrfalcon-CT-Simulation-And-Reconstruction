function [] = simulationRunLoadButtonCallback(hObject, eventdata, handles)
% [] = simulationRunLoadButtonCallback(hObject, eventdata, handles)

filterSpec = '*.mat';
dialogTitle = 'Open Simulation Run...';
defaultName = Constants.object_save_directory;

[fileName, pathName, ~] = uigetfile(filterSpec, dialogTitle, defaultName);

if ~all(fileName == 0) % have a selection
    openPath = makePath(pathName, fileName);
    
    loadedData = load(openPath);
    
    if isfield(loadedData, Constants.Processing_Run_Var_Name)
        simulationRun = loadedData.(Constants.Processing_Run_Var_Name);
        
        if isa(simulationRun, class(SimulationRun)) % we're good!
            workspace = handles.workspace.createFromGUI(handles);
            
            workspace.simulationRun = simulationRun;
            
            scanGeometry = simulationRun.simulation.findScanGeometry();
            
            if ~isempty(scanGeometry)
                choice = scanGeometry.getDefaultAlgorithmChoice();
                
                reconRun = ReconstructionRun;
                
                reconRun.reconstructionAlgorithm = choice;
                reconRun.simulationRun = simulationRun;
            else
                reconRun = [];
            end
            
            workspace.reconstructionRun = reconRun;
            
            handles.workspace = workspace;
            
            handles = handles.workspace.setGUI(handles);
            
            guidata(hObject, handles);
        else
            errordlg('The selected file was not a Simulation Run file and so could not be opened.', 'Invalid File');
        end
    else
        errordlg('The selected file was not a Simulation Run file and so could not be opened.', 'Invalid File');
    end
else
    
end

end

