function [] = saveWorkspaceButtonCallback(app)
%[] = saveWorkspaceButtonCallback(app)
% callback to save the workspace

% get path and filename

workspace = app.workspace;

workspace = workspace.createFromGUI(app);

workspace.saveInSeparateFile = true;

defaultSavePath = app.settings.Simulation_Save_Path;

[saved, workspace, ~,~] = workspace.saveAs(defaultSavePath);

if saved
    app.workspace = workspace;
    
    app = app.workspace.setGUI(app);
end

end

