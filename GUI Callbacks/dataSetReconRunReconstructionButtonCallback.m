function [] = dataSetReconRunReconstructionButtonCallback(app)
% [] = dataSetReconRunReconstructionButtonCallback(app)

workspace = app.workspace;

workspace = workspace.createFromGUI(app);

[scanGeometry, ~] = getScanGeometry(workspace.reconstructionRun);

if ~isempty(scanGeometry)
    reconRun = workspace.reconstructionRun;
    
    reconRun.runReconstruction(app);
    
    % keep the data loaded and parameters set, but find a new folder for
    % the run to be save in
    newSavePath = reconRun.reconstruction.getSavePath(reconRun.simulationOrImagingScanRun.savePath);
    
    reconRun.savePath = newSavePath;
    
    app.workspace.reconstructionRun = reconRun;
    app.workspace.reconstructionRun.setGUI(app);
end


end

