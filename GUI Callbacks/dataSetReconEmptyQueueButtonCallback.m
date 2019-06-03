function [] = dataSetReconEmptyQueueButtonCallback(app)
%[] = dataSetReconEmptyQueueButtonCallback(app)

queue = app.workspace.reconstructionRunQueue;
numRecons = length(queue);

yesButton = 'Yes';
cancelButton = 'Cancel';

question = ['Are you sure you want to clear the reconstruction queue (', num2str(numRecons), ' reconstructions)?'];
title = 'Clear Queue';

answer = questdlg(question, title, yesButton, cancelButton, yesButton);

switch answer
    case yesButton
        for i=1:numRecons
            rmdir(app.workspace.reconstructionRunQueue{i}.savePath);
        end
        
        app.workspace.reconstructionRunQueue = {};
end

end

