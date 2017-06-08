function app = initializeGyrfalcon(app)
% app = initializeGyrfalcon(app)
% initializes the UI and variables for Gyrfalcon.
% Also opens the display figure

% ******************************
% *** INITIALIZE GUI OBJECTS ***
% ******************************

app.StatusOutputTextArea.Value = {''};

pos = app.GyrfalconUIFigure.Position;

pos(1:2) = [0 30]; %is default at 100,100 (not very useful for large apps

app.GyrfalconUIFigure.Position = pos;

% set drop down menus
Units.setDropDown(app.SourceDimsXYUnitsDropDown);
Units.setDropDown(app.SourceDimsZUnitsDropDown);

Units.setDropDown(app.DetectorPixelDimsXYUnitsDropDown);
Units.setDropDown(app.DetectorPixelDimsZUnitsDropDown);

InterpolationTypes3D.setDropDown(app.ReconstructionRun3DInterpolationTypeDropDown);

% set drop down menus in algorithm settings tabs
FirstGenFilterTypes.setDropDown(app.Gen1FBP_FilterTypeDropDown);

InterpolationTypes.setDropDown(app.Gen1FBP_InterpolationTypeDropDown);

% *******************************
% *** INITIALIZE DATA HANDLES ***
% *******************************

app.workspace = GyrfalconWorkspace;
app.workspace = app.workspace.setDefaultValues();

% gets settings loaded up
Settings.load(app);

% **********************
% *** INITIALIZE GUI ***
% **********************

app = app.workspace.setGUI(app);

newString = 'Complete';
newLine = false;

% *********************************
% *** INITIALIZE DISPLAY FIGURE ***
% *********************************

app = initializeDisplayFigure(app);

% FINALIZE
app = updateStatusOutput(app, newString, newLine);

end

