function handles = plotSlices(sliceXCoords, sliceYCoords, sliceZCoords, axesHandle, sliceData)
% handles = plotSlices(sliceXCoords, sliceYCoords, sliceZCoords, axesHandle, sliceData)

if iscell(sliceXCoords)
    handles = cell(1,length(sliceXCoords));
    
    for i=1:length(sliceXCoords)
        handles{i} = surf(...
            sliceXCoords{i}, sliceYCoords, sliceZCoords, ones([size(sliceData{i}),3]),...
            'Parent', axesHandle, 'EdgeColor', 'none');
        alpha(handles{i}, sliceData{i});
    end
elseif iscell(sliceYCoords)
    handles = cell(1,length(sliceYCoords));
    
    for i=1:length(sliceYCoords)
        handles{i} = surf(...
            sliceXCoords, sliceYCoords{i}, sliceZCoords, ones([size(sliceData{i}),3]),...
            'Parent', axesHandle, 'EdgeColor', 'none');
        alpha(handles{i}, sliceData{i});
    end
elseif iscell(sliceZCoords)
    handles = cell(1,length(sliceZCoords));
    
    for i=1:length(sliceZCoords)
        handles{i} = surf(...
            sliceXCoords, sliceYCoords, sliceZCoords{i}, ones([size(sliceData{i}),3]),...
            'Parent', axesHandle, 'EdgeColor', 'none');
        alpha(handles{i}, sliceData{i});
    end
else
    handle = surf(...
        sliceXCoords, sliceYCoords, sliceZCoords, ones([size(sliceData),3]),...
        'Parent', axesHandle, 'EdgeColor', 'none');
    alpha(handle, sliceData);
    
    handles = {handle};
end


end

