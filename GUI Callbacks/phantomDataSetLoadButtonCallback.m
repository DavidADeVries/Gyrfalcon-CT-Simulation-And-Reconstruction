function [] = phantomDataSetLoadButtonCallback(app)
% [] = phantomDataSetLoadButtonCallback(app)
% callback function that loads up a phantom data set

dataSet = PhantomDataSet;

dataSet.saveInSeparateFile = true;

dataSet = dataSet.load(app.settings.Simulation_Save_Path);  

if ~isempty(dataSet)
    % update handles
    app.workspace.simulation.phantom.dataSet = dataSet;
        
    app.workspace.setGUI(app);
end

end


