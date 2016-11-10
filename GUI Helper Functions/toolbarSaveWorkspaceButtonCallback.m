function [] = toolbarSaveWorkspaceButtonCallback(hObject, eventdata, handles)
%[] = toolbarSaveWorkspaceButtonCallback(hObject, eventdata, handles)
% callback to save the workspace

% get path and filename

defaultName = [Constants.Default_Workspace_File_Name, Constants.Matlab_File_Extension];
dialogTitle = 'Save Workspace As...';

[fileName, pathName] = uiputfile(defaultName, dialogTitle);

if ischar(fileName) && ischar(pathName) % not cancelled
    savePath = makePath(pathName, fileName);
    
    simulation = Simulation();
    
    simulation = simulation.createFromGUI(handles);
    statusOutput = get(handles.statusOutputText, 'String');
    
    save(savePath,...
        Constants.Save_Workplace_Simulation_Var_Name,...
        Constants.Save_Workplace_Status_Output_Var_Name);
end

end

