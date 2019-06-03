function filename = makePositionName(xyIndex, zIndex, isScanPositionMosiac)
% filename = makePositionName(xyIndex, zIndex, isScanPositionMosiac)

if isScanPositionMosiac
    filename = Constants.All_Positions_Filename;
else
    filename = [Constants.Position_Filename, ' (', num2str(xyIndex), ',', num2str(zIndex), ')'];
end

end