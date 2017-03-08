function [] = toolbarSaveWorkspaceButtonCallback(hObject, eventdata, handles)
%[] = toolbarSaveWorkspaceButtonCallback(hObject, eventdata, handles)
% callback to save the workspace

% get path and filename

workspace = handles.workspace;

workspace = workspace.createFromGUI(handles);

workspace.saveInSeparateFile = true;

[saved, workspace, ~,~] = workspace.saveAs();

if saved
    handles.workspace = workspace;
    
    handles = handles.workspace.setGUI(handles);
    
    guidata(hObject, handles);
end

end

