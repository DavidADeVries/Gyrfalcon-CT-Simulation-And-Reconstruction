function [] = dataSetReconRunReconstructionButtonCallback(app)
% [] = dataSetReconRunReconstructionButtonCallback(app)


workspace = app.workspace;

workspace = workspace.createFromGUI(app);

reconRuns = workspace.reconstructionRunQueue;

if ~isempty(reconRuns)
    for i=1:length(reconRuns)
        reconRun = reconRuns{i};
        
        % update status output
        endFolder = reconRun.getCurrentSaveFolder();
        
        newString = ['Reconstruction ', num2str(i), '/', num2str(length(reconRuns)), ': ', endFolder];
        newLine = true;
    
        app = updateStatusOutput(app, newString, newLine);
        
        % run the reconstruction
        try
            reconRun.runReconstruction(app);
        catch e
            % print stack trace to command line for debug
            disp(' ');
            disp(' ');
            disp('**********************************');
            disp(['ERROR DURING RECONSTRUCTION ', num2str(i)]);            
            disp('**********************************');
            disp(' ');
            disp(getReport(e, 'extended'));
            
            % add error to status output
            newString = ['  ERROR!'];
            newLine = true;
            
            app = updateStatusOutput(app, newString, newLine);
            
            % save recon settings for further recall if needed
            reconRun.saveReconstructionRunFile();
            
            % reset par pool, gpuDevice
            delete(gcp('nocreate'));
            reset(gpuDevice);
        end
    end
    
    % empty out queue
    workspace.reconstructionRunQueue = {};
    
    app.workspace = workspace;
end

end

