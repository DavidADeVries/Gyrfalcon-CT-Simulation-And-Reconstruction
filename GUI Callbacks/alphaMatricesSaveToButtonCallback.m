function [] = alphaMatricesSaveToButtonCallback(app, buttonToBold, buttonToUnbold)
%[] = alphaMatricesSaveToButtonCallback(app, buttonToBold, buttonToUnbold)

recon = app.workspace.reconstructionRun.reconstruction;

startPath = makePath(app.settings.Reconstruction_Pre_Computed_Data_Path, [Constants.Default_Alpha_Matrices_File_Name, Constants.Matlab_File_Extension]);
filter = ['*', Constants.Matlab_File_Extension];
title = 'Select Folder to Save New Alpha Matrices To';

[newFileName, newPath] = uiputfile(filter, title, startPath);
newPath = newPath(1:end-1); % trim trailing slash

if newFileName ~= 0 % not cancelled
    recon.alphaMatricesLoadPath = '';
    
    recon.alphaMatricesSavePath = newPath;
    recon.alphaMatricesSaveFileName = newFileName;

    buttonToBold.FontWeight = 'bold';
    buttonToUnbold.FontWeight = 'normal';
else
    buttonToBold.FontWeight = 'normal';
    buttonToUnbold.FontWeight = 'normal';

    recon.alphaMatricesLoadPath = '';
    
    recon.alphaMatricesSavePath = '';
    recon.alphaMatricesSaveFileName = '';
end

recon.setGUI(app);

app.workspace.reconstructionRun.reconstruction = recon;




end

