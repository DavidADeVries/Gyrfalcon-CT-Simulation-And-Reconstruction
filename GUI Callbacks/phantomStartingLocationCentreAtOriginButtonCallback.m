function [] = phantomStartingLocationCentreAtOriginButtonCallback(hObject, eventdata, handles)
% [] = phantomStartingLocationCentreAtOriginButtonCallback(hObject, eventdata, handles)
% sets x,y,z of phantom location so that the phantomDataSet will appear
% centred at the origin (in the x,y) z will stay untouched

workspace = handles.workspace.createFromGUI(handles);

dataSet = workspace.simulation.phantom.dataSet;

if ~isempty(dataSet)
    data = dataSet.data;
        
    dimensions = workspace.simulation.phantom.voxelDimensions;
    
    location = centrePhantom(data, dimensions);
    
    workspace.simulation.phantom.location = location;
    
    handles = workspace.setGUI(handles);
    
    guidata(hObject, handles);
end

end

