function [] = scanSimMockUpButtonCallback(app)
% [] = scanSimMockUpButtonCallback(app)
% mocks-up up the scan sim model on the display axes

% 1) Create simulation object based on where the parameters are at

simulation = app.workspace.simulation;

simulation = simulation.createFromGUI(app);

% 2) Plot it

simulation.plot(app);

end

