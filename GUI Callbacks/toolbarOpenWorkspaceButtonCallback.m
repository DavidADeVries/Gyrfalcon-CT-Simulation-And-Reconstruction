function [] = toolbarOpenWorkspaceButtonCallback(hObject, eventdata, handles)
%[] = toolbarSaveWorkspaceButtonCallback(hObject, eventdata, handles)
% callback to save the workspace

% get path and filename

workspace = GyrfalconWorkspace; %empty workspace

workspace = workspace.load();

if ~isempty(workspace)

    % update handles
    handles = workspace.setGUI(handles);
    
    handles.workspace = workspace;
    
    guidata(hObject, handles);
end

end

