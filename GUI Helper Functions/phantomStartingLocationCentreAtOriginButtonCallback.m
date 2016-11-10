function [] = phantomStartingLocationCentreAtOriginButtonCallback(hObject, eventdata, handles)
% [] = phantomStartingLocationCentreAtOriginButtonCallback(hObject, eventdata, handles)
% sets x,y,z of phantom location so that the phantomDataSet will appear
% centred at the origin (in the x,y) z will stay untouched

data = handles.phantomDataSet;

x = getDoubleFromHandle(handles.phantomVoxelDimensionsXEdit);
y = getDoubleFromHandle(handles.phantomVoxelDimensionsYEdit);
z = getDoubleFromHandle(handles.phantomVoxelDimensionsZEdit);

dimensions = [x,y,z];

location = centrePhantom(data, dimensions);

xStr = num2str(location(1));
yStr = num2str(location(2));
zStr = num2str(location(3));

setString(handles.phantomStartingLocationXEdit, xStr);
setString(handles.phantomStartingLocationYEdit, yStr);
setString(handles.phantomStartingLocationZEdit, zStr);

end

