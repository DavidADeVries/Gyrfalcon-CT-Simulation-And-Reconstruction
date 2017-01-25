function controlPanelRunScanSimButtonCallback(hObject, eventdata, handles)
% controlPanelRunScanSimButtonCallback(hObject, eventdata, handles)
% using the current simulation parameters specified by the GUI a simulation
% is run

simulation = Simulation;

simulation = simulation.createFromGUI(handles);

displaySlices = isChecked(handles.scanSimViewSlices);
displayAngles = isChecked(handles.scanSimViewAngles);
displayPerAnglePosition = isChecked(handles.scanSimViewPerAnglePosition);
displayDetectorRaster = isChecked(handles.scanSimViewDetectorRaster);

displayDetectorValues = isChecked(handles.scanSimViewDetectorValues);
displayDetectorRayTrace = isChecked(handles.scanSimViewDetectorRayTraces);

data = simulation.runScanSimulation(...
    handles.axesHandle,...
    displaySlices,...
    displayAngles,...
    displayPerAnglePosition,...
    displayDetectorRaster,...
    displayDetectorValues,...
    displayDetectorRayTrace);


end

function bool = isChecked(handle)
    bool = strcmp(get(handle, 'Checked'), 'on');
end