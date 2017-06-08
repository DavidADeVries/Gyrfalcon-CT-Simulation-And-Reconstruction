function [] = dataSetReconRunReconstructionButtonCallback(app)
% [] = dataSetReconRunReconstructionButtonCallback(app)

workspace = app.workspace;

workspace = workspace.createFromGUI(app);

[scanGeometry, ~] = getScanGeometry(workspace.reconstructionRun);

if ~isempty(scanGeometry)
    reconRun = workspace.reconstructionRun;
    
    reconRun.runReconstruction(app);
end


end

