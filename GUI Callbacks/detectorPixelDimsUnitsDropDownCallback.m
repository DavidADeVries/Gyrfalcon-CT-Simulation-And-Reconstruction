function [] = detectorPixelDimsUnitsDropDownCallback(app)
% detectorPixelDimsUnitsDropDownCallback(app)

detector = app.workspace.simulation.detector.createFromGUI(app);

detector.setGUI(app);

end

