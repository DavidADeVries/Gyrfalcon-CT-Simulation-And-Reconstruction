function [] = rayTraceMatricesLoadFromButtonCallback(app, buttonToBold, buttonToUnbold)
%[] = rayTraceMatricesLoadFromButtonCallback(app)

recon = app.reconstructionRun.recon;

newFolder = uigetdir(app.settings.Reconstruction_Pre_Computed_Data_Path, 'Select Folder to Read Ray Trace Matrices From');

if newFolder ~= 0 % not cancelled
    recon.rayTraceMatricesLoadPath = newFolder;
    
    recon.rayTraceMatricesSavePath = '';
    recon.rayTraceMatricesSaveFileName = '';

    buttonToBold.FontWeigtht = 'bold';
    buttonToUnbold.FontWeight = 'normal';
else
    buttonToBold.FontWeigtht = 'normal';
    buttonToUnbold.FontWeight = 'normal';

    recon.rayTraceaMatricesLoadPath = '';
    
    recon.rayTraceMatricesSavePath = '';
    recon.rayTraceMatricesSaveFileName = '';
end

recon.setGUI(app);

app.reconstructionRun.recon = recon;




end

