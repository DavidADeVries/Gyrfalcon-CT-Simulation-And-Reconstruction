function controlPanelRunScanSimButtonCallback(hObject, eventdata, handles)
% controlPanelRunScanSimButtonCallback(hObject, eventdata, handles)
% using the current simulation parameters specified by the GUI a simulation
% is run

simulation = Simulation;

simulation = simulation.createFromGUI(handles);

displaySlices = strcmp(get(handles.scanSimViewSlices, 'Checked'), 'on');
displayAngles = strcmp(get(handles.scanSimViewAngles, 'Checked'), 'on');
displayPerAnglePosition = strcmp(get(handles.scanSimViewPerAnglePosition, 'Checked'), 'on');
displayDetectorRaster = strcmp(get(handles.scanSimViewDetectorRaster, 'Checked'), 'on');

displayDetectorValues = strcmp(get(handles.scanSimViewDetectorValues, 'Checked'), 'on');

data = simulation.runScanSimulation(...
    handles.axesHandle,...
    displaySlices,...
    displayAngles,...
    displayPerAnglePosition,...
    displayDetectorRaster,...
    displayDetectorValues);


end

