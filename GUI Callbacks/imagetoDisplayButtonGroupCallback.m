function [] = imagetoDisplayButtonGroupCallback(app)
%[] = imagetoDisplayButtonGroupCallback(app)

run = app.workspace.simulationRunForViewing;
image = loadImageForScanSimulationViewer(run, app);

minVal = allMin(image);
maxVal = allMax(image);

app.ImageContrastLowEditField.Value = minVal;
app.ImageContrastHighEditField.Value = maxVal;

showSimulationViewImage(app);

                

end

