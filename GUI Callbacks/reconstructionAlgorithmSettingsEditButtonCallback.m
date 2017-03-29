function [] = reconstructionAlgorithmSettingsEditButtonCallback(hObject, eventdata, handles)
% [] = reconstructionAlgorithmSettingsEditButtonCallback(hObject, eventdata, handles)

workspace = handles.workspace;

workspace = workspace.createFromGUI(handles);

[scanGeometry, ~] = getScanGeometry(workspace.reconstructionRun);

if ~isempty(scanGeometry)
    reconAlgorithm = workspace.reconstructionRun.reconstructionAlgorithm;
    
    reconAlgorithm = reconAlgorithm.changeSettings();
    
    workspace.reconstructionRun.reconstructionAlgorithm = reconAlgorithm;
    
    handles = workspace.setGUI(handles);
    
    handles.workspace = workspace;
    
    guidata(hObject, handles);
end


end

