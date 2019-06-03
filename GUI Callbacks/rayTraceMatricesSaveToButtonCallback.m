function [] = rayTraceMatricesSaveToButtonCallback(app, buttonToBold, buttonToUnbold)
%[] = rayTraceMatricesSaveToButtonCallback(app, buttonToBold, buttonToUnbold)

recon = app.workspace.reconstructionRun.reconstruction;

startPath = makePath(app.settings.Reconstruction_Pre_Computed_Data_Path, [Constants.Default_Ray_Trace_Matrices_File_Name, Constants.Matlab_File_Extension]);
filter = ['*', Constants.Matlab_File_Extension];
title = 'Select Folder to Save New Ray Trace Matrices To';

[newFileName, newPath] = uiputfile(filter, title, startPath);
newPath = newPath(1:end-1); % trim trailing slash

if newFileName ~= 0 % not cancelled
    recon.rayTraceMatricesLoadPath = '';
    
    recon.rayTraceMatricesSavePath = newPath;
    recon.rayTraceMatricesSaveFileName = newFileName;

    buttonToBold.FontWeight = 'bold';
    buttonToUnbold.FontWeight = 'normal';
else
    buttonToBold.FontWeight = 'normal';
    buttonToUnbold.FontWeight = 'normal';

    recon.rayTraceMatricesLoadPath = '';
    
    recon.rayTraceMatricesSavePath = '';
    recon.rayTraceMatricesSaveFileName = '';
end

recon.setGUI(app);

app.workspace.reconstructionRun.reconstruction = recon;




end

