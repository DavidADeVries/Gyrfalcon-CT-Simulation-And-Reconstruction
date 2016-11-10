function controlPanelRunScanSimButtonCallback(hObject, eventdata, handles)
% controlPanelRunScanSimButtonCallback(hObject, eventdata, handles)
% using the current simulation parameters specified by the GUI a simulation
% is run

simulation = Simulation;

simulation = simulation.createFromGUI(handles);

data = simulation.runScanSimulation();


end

