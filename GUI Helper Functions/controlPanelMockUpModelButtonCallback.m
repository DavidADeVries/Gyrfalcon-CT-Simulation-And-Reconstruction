function [] = controlPanelMockUpModelButtonCallback(hObject, eventdata, handles)
% [] = controlPanelMockUpModelButton(hObject, eventdata, handles)
% mocks-up up the scan sim model on the display axes

% 1) Create simulation object based on where the parameters are at

simulation = Simulation();

simulation = simulation.createFromGUI(handles);

% 2) Plot it

simulation.plot(handles);

end

