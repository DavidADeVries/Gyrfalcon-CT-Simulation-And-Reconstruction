function [] = controlPanelRunReconstructionButtonCallback(hObject, eventdata, handles)
% [] = controlPanelRunReconstructionButtonCallback(hObject, eventdata, handles)

workspace = handles.workspace;

workspace = workspace.createFromGUI(handles);

[scanGeometry, ~] = getScanGeometry(workspace.reconstructionRun);

if ~isempty(scanGeometry)
    reconRun = workspace.reconstructionRun;
    
    reconRun.runReconstruction(handles);
end


end

