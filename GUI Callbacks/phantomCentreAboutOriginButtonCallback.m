function [] = phantomCentreAboutOriginButtonCallback(app)
% [] = phantomCentreAboutOriginButtonCallback(app)
% sets x,y,z of phantom location so that the phantomDataSet will appear
% centred at the origin (in the x,y) z will stay untouched

workspace = app.workspace.createFromGUI(app);

dataSet = workspace.simulation.phantom.dataSet;

if ~isempty(dataSet)
    data = dataSet.data;
        
    dimensions = workspace.simulation.phantom.voxelDimensions;
    
    location = centrePhantom(data, dimensions);
    
    workspace.simulation.phantom.location = location;
    
    app = workspace.setGUI(app);
end

end

