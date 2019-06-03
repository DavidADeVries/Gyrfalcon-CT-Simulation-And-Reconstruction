function [] = imagingScanDataImportPathChangeButtonCallback(app)
% [] = imagingScanDataImportPathChangeButtonCallback(app)

imagingScanRun = app.workspace.imagingScanRun.createFromGUI(app);

startPath = app.settings.Imaging_Scan_Import_Path;

newFolder = uigetdir(startPath, 'Select Import Folder');

if newFolder ~= 0 % not cancelled
    imagingScanRun.importPath = newFolder;
    
    imagingScanRun.setGUI(app);
    
    app.workspace.imagingScanRun = imagingScanRun;
end


end

