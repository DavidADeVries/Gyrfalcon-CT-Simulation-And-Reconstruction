function [] = openWorkspaceButtonCallback(app)
%[] = openWorkspaceButtonCallback(app)
% callback to save the workspace

% get path and filename

workspace = GyrfalconWorkspace; %empty workspace

workspace = workspace.load();

if ~isempty(workspace)

    % update handles
    app = workspace.setGUI(app);
    
    app.workspace = workspace;
end

end

