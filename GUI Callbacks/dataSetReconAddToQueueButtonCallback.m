function [] = dataSetReconAddToQueueButtonCallback(app)
% [] = dataSetReconAddToQueueButtonCallback(app)

workspace = app.workspace;

workspace = workspace.createFromGUI(app);

[scanGeometry, ~] = getScanGeometry(workspace.reconstructionRun);

if ~isempty(scanGeometry)
    reconRun = workspace.reconstructionRun;
    
    app.workspace.reconstructionRunQueue = [app.workspace.reconstructionRunQueue {reconRun}];
    
    % create directory already to avoid overwriting by other recons
    reconRun.createReconDirectory();
    
    % show that it was added in the status output
    endFolder = reconRun.getCurrentSaveFolder();
    
    newString = [endFolder, ' added to queue (Recon #', num2str(length(app.workspace.reconstructionRunQueue)), ')'];
    newLine = true;
    
    app = updateStatusOutput(app, newString, newLine);
    
    % keep the data loaded and parameters set, but find a new folder for
    % the run to be save in
    newSavePath = reconRun.reconstruction.getSavePath(reconRun.simulationOrImagingScanRun.savePath);
    
    reconRun.savePath = newSavePath;
    
    app.workspace.reconstructionRun = reconRun;
    app.workspace.reconstructionRun.setGUI(app);
end


end

