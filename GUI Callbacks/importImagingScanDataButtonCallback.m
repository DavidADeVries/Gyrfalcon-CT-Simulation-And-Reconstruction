function [] = importImagingScanDataButtonCallback(app)
%[] = importImagingScanDataButtonCallback(app)

imagingScanRun = app.workspace.imagingScanRun.createFromGUI(app);

handle = popupMessage('Importing imaging scan run...', 'Importing...');

imagingScanRun = imagingScanRun.importDataSet();

delete(handle);

msgbox('Import complete!','Import Complete');

% done import so reset
imagingScanRun = imagingScanRun.setDefaultValues();

imagingScanRun.setGUI(app);

app.workspace.imagingScanRun = imagingScanRun;


end

