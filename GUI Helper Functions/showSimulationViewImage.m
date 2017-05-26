function [] = showSimulationViewImage(app)
% [] = showSimulationViewImage(app)

[invert, contrastBounds] = getSimulationViewerImageDisplaySettings(app);

image = app.workspace.simulationRunForViewing.loadImageForScanSimulationViewer(app);
         
if invert
    image = -image;
    contrastBounds = -contrastBounds;
    contrastBounds = fliplr(contrastBounds);    
end

imshow(image, contrastBounds, 'Parent', app.SimulationViewerAxes);

dims = size(image);

app.SimulationViewerAxes.XLim = [0 dims(2)+0.5];
app.SimulationViewerAxes.YLim = [0 dims(1)+0.5];
app.SimulationViewerAxes.BackgroundColor = [0 0 0];

end

