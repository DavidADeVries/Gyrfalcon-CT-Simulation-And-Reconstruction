function [] = saveWorkspaceButtonCallback(app)
%[] = saveWorkspaceButtonCallback(app)
% callback to save the workspace

% get path and filename

workspace = app.workspace;

workspace = workspace.createFromGUI(app);

workspace.saveInSeparateFile = true;

[saved, workspace, ~,~] = workspace.saveAs();

if saved
    app.workspace = workspace;
    
    app = app.workspace.setGUI(app);
end

end

