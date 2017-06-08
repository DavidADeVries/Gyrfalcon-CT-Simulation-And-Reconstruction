function [] = resetScanSimulationViewerListBoxes(app)
% resetScanSimulationViewerListBoxes(app)

app.SimulationViewerSliceListBox.Value = app.SimulationViewerSliceListBox.Items{1};
app.SimulationViewerScanAngleListBox.Value = app.SimulationViewerScanAngleListBox.Items{1};
app.SimulationViewerPerAngleTranslationPositionListBox.Value = app.SimulationViewerPerAngleTranslationPositionListBox.ItemsData{1};

end

