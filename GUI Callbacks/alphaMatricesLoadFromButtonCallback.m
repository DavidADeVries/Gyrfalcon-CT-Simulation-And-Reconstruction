function [] = alphaMatricesLoadFromButtonCallback(app, buttonToBold, buttonToUnbold)
%[] = alphaMatricesLoadFromButtonCallback(app)

recon = app.reconstructionRun.recon;

newFolder = uigetdir(app.settings.Reconstruction_Pre_Computed_Data_Path, 'Select Folder to Read Alpha Matrices From');

if newFolder ~= 0 % not cancelled
    recon.alphaMatricesLoadPath = newFolder;
    
    recon.alphaMatricesSavePath = '';
    recon.alphaMatricesSaveFileName = '';

    buttonToBold.FontWeigtht = 'bold';
    buttonToUnbold.FontWeight = 'normal';
else
    buttonToBold.FontWeigtht = 'normal';
    buttonToUnbold.FontWeight = 'normal';

    recon.alphaMatricesLoadPath = '';
    
    recon.alphaMatricesSavePath = '';
    recon.alphaMatricesSaveFileName = '';
end

recon.setGUI(app);

app.reconstructionRun.recon = recon;




end

