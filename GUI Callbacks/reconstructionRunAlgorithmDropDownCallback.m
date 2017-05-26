function [] = reconstructionRunAlgorithmDropDownCallback(app)
% [] = reconstructionRunAlgorithmDropDownCallback(app)

value = app.ReconstructionRunAlgorithmDropDown.Value;

recon = app.workspace.reconstructionRun.reconstruction;

recon = recon.createFromGUI(app);

newRecon = value;

newRecon = newRecon.transferReconstructionValues(recon);

app = newRecon.setGUI(app);

app.workspace.reconstructionRun.reconstruction = newRecon;

% change up savePath as needed
savePath = newRecon.getSavePath(app.workspace.reconstructionRun.simulationRun.savePath);                
app.workspace.reconstructionRun.savePath = savePath;

app.ReconstructionRunSavePathEditField.Value = savePath;

end

