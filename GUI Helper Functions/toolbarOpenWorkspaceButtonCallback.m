function [] = toolbarOpenWorkspaceButtonCallback(hObject, eventdata, handles)
%[] = toolbarSaveWorkspaceButtonCallback(hObject, eventdata, handles)
% callback to save the workspace

% get path and filename

filter = ['*', Constants.Matlab_File_Extension];
dialogTitle = 'Open Workspace...';

[fileName, pathName] = uigetfile(filter, dialogTitle);

if ischar(fileName) && ischar(pathName) % not cancelled
    loadPath = makePath(pathName, fileName);
    
    vars = load(loadPath);
    
    simulation = vars.simulation;
    statusOutput = vars.statusOutput;
    
    % now that we have the data, load it into the GUI
    
    handles = setGUIFromSimulation(simulation, handles);
    
    setString(handles.statusOutputText, statusOutput);
    
    % update handles
    guidata(hObject, handles);
end

end

