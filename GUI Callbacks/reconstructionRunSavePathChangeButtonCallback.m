function [] = reconstructionRunSavePathChangeButtonCallback(app)
% [] = reconstructionRunSavePathChangeButtonCallback(app)

reconRun = app.workspace.reconstructionRun;

currentFolder = reconRun.getCurrentSaveFolder();

savePath = reconRun.simulationRun.savePath;

answer = {''}; % this is NOT empty
validFolder = false;
folderName = '';

while ~isempty(answer) && ~validFolder % keep looping till folder found or cancelled
    prompt = ...
        {['The reconstruction results will be save with the Simulation Run at ',...
        savePath,...
        '. Please enter the name of the subdirectory to save the reconstruction to.']};
    dialogTitle = 'Reconstruction Title';
    numLines = 1;
    defaultAns = {currentFolder};
    
    answer = inputdlg(prompt, dialogTitle, numLines, defaultAns);
    
    if ~isempty(answer) % not cancelled
        folderName = answer{1};
        
        validFolder = ~isStrInCellArray(getFolders(savePath), folderName);
    end
end

if ~isempty(answer) && validFolder % didn't cancel
    savePath = makePath(reconRun.simulationRun.savePath, folderName);
    
    reconRun.savePath = savePath;
    
    app.ReconstructionRunSavePathEditField.Value = savePath;
    
    app.workspace.reconstructionRun = reconRun;
end

end

