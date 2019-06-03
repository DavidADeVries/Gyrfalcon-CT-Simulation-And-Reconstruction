function [] = dataSetReconViewQueueButton(app)
%[] = dataSetReconViewQueueButton(app)

queue = app.workspace.reconstructionRunQueue;
numRecons = length(queue);

if numRecons == 0
    msgbox('No reconstructions in queue');
else
    strings = cell(numRecons,1);
    
    for i=1:numRecons
        strings{i} = ['Recon. #', num2str(i), ': ',...
            makePath(getLastItemFromPath(queue{i}.simulationOrImagingScanRun.savePath),...
            getLastItemFromPath(queue{i}.savePath))];
    end
    
    msgbox(strings);
end


end

