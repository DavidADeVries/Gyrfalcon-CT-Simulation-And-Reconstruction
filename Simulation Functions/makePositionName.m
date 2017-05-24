function filename = makePositionName(zIndex, xyIndex)
% filename = makePositionName(zIndex, xyIndex)
    filename = [Constants.Position_Filename, ' (', num2str(zIndex), ',', num2str(xyIndex), ')'];
end