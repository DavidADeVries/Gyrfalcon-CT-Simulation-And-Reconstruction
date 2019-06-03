function [] = barGraphDataCollectionAndCreation(readPath, sheet, groupRows, column, graphWritePath, groupLabels, subgroupLabels, subgroupLabelWriteIndex, subgroupLabelOrientation, subgroupLabelAngle, figDimsInCm, subgroupColours, customColours, yLabel, title, unitConversionFn, lineAtBar, linePosAndNeg) 


[~,~,sheetData] = xlsread(readPath, sheet);

numGroups = length(groupRows);

barData = cell(numGroups,1);

for i=1:numGroups
    rows = groupRows{i};
    
    numPoints = length(rows);
    
    data = zeros(1,numPoints);
    
    for j=1:numPoints
        data(j) = sheetData{rows(j),column};
    end
    
    barData{i} = data;
end

createAndWriteBarGraph(...
    graphWritePath, figDimsInCm,...
    barData, groupLabels, subgroupLabels,...
    subgroupLabelWriteIndex, subgroupLabelOrientation, subgroupLabelAngle,...
    subgroupColours, customColours,...
    yLabel, title,...
    unitConversionFn, lineAtBar, linePosAndNeg);

end