function [] = imagingScanRunSavePathChangeButtonCallback(app)
% [] = imagingScanRunSavePathChangeButtonCallbackapp)

imagingScanRun = app.workspace.imagingScanRun.createFromGUI(app);

startPath = app.settings.Imaging_Scan_Run_Save_Path;

[fileName, path] = uiputfile('*.mat', 'Select Import Save Location', makePath(startPath, imagingScanRun.getDefaultFolderName()));

if fileName ~= 0 % not cancelled
    imagingScanRun.savePath = path(1:end-1); % get rid of trailing slash
    imagingScanRun.saveFileName = fileName;
    
    imagingScanRun.setGUI(app);
    
    app.workspace.imagingScanRun = imagingScanRun;
end


end

