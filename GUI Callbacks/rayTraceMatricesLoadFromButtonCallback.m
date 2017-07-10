function [] = rayTraceMatricesLoadFromButtonCallback(app, buttonToBold, buttonToUnbold)
%[] = rayTraceMatricesLoadFromButtonCallback(app)

recon = app.workspace.reconstructionRun.reconstruction;

newFolder = uigetdir(app.settings.Reconstruction_Pre_Computed_Data_Path, 'Select Folder to Read Ray Trace Matrices From');

if newFolder ~= 0 % not cancelled
    recon.rayTraceMatricesLoadPath = newFolder;
    
    recon.rayTraceMatricesSavePath = '';
    recon.rayTraceMatricesSaveFileName = '';

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

