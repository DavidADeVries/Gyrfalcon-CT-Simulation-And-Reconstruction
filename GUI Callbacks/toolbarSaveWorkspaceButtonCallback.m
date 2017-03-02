function [] = toolbarSaveWorkspaceButtonCallback(hObject, eventdata, handles)
%[] = toolbarSaveWorkspaceButtonCallback(hObject, eventdata, handles)
% callback to save the workspace

% get path and filename

workspace = handles.workspace;

clearBeforeSave = true;

workspace = workspace.save(clearBeforeSave);

handles.workspace = workspace;

handles = handles.workspace.setGUI(handles);

guidata(hObject, handles);

end

