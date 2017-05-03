function app = initializeGyrfalcon(app)
% app = initializeGyrfalcon(app)
% initializes the UI and variables for Gyrfalcon.
% Also opens the display figure

app.StatusOutputTextArea.Value = {''};

pos = app.GyrfalconUIFigure.Position;

pos(1:2) = [0 30]; %is default at 100,100 (not very useful for large apps

app.GyrfalconUIFigure.Position = pos;

% *******************************
% *** INITIALIZE DATA HANDLES ***
% *******************************

app.workspace = GyrfalconWorkspace;
app.workspace = app.workspace.setDefaultValues();

% *********************************
% *** INITIALIZE DISPLAY FIGURE ***
% *********************************

app = initializeDisplayFigure(app);

% **********************
% *** INITIALIZE GUI ***
% **********************

app = app.workspace.setGUI(app);

newString = 'Complete';
newLine = false;

app = updateStatusOutput(app, newString, newLine);

end

