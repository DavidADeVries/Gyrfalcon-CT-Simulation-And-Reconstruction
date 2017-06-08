function [] = simulationViewerLoopThroughAnglesButtonCallback(app)
% simulationViewerLoopThroughAnglesButtonCallback(app)

items = app.SimulationViewerScanAngleListBox.Items;

numItems = length(items);

i=1;

while app.SimulationViewerLoopThroughAnglesButton.Value
    if i > numItems
        i = 1;
    end

    app.SimulationViewerScanAngleListBox.Value = items{i};
    
    showSimulationViewImage(app);
    
    drawnow;

    i = i+1;
end

end

