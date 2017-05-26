function [] = simulationViewerListBoxValueChangedCallback(app)
%[] = simulationViewerListBoxValueChangedCallback(app)

image = app.workspace.simulationRunForViewing.loadImageForScanSimulationViewer(app);
                
imshow(-image, [], 'Parent', app.SimulationViewerAxes);

end

