function handles = initializeGyrfalcon(hObject, handles)
% handles = initializeGyrfalcon(hObject, handles)
% initializes the UI and variables for Gyrfalcon.
% Also opens the display figure

% *******************************
% *** INITIALIZE DATA HANDLES ***
% *******************************

handles.simulationSavePath = '';
handles.simulationSaveFileName = '';

handles.detectorSavePath = '';
handles.detectorSaveFileName = '';

handles.sourceSavePath = '';
handles.sourceSaveFileName = '';

handles.scanSavePath = '';
handles.scanSaveFileName = '';

handles.scanBeamCharacterizationPath = '';
handles.scanBeamCharacterizationFileName = '';
handles.scanBeamCharacterization = {};

handles.phantomSavePath = '';
handles.phantomSaveFileName = '';

handles.phantomDataPath = '';
handles.phantomDataFileName = '';
handles.phantomDataSet = [];

% *********************************
% *** INITIALIZE DISPLAY FIGURE ***
% *********************************

handles = initializeDisplayFigure(handles);

% **********************
% *** INITIALIZE GUI ***
% **********************

% *** CONTROL PANEL ***

setString(handles.statusOutputText, {'Initializing Gyrfalcon...Complete'});

set(handles.controlPanelRunScanSimButton, 'Enable', 'on');
set(handles.controlPanelRunReconstructionButton, 'Enable', 'off');
set(handles.controlPanelUnassignedTaskButton, 'Enable', 'off');

% *** SCAN SIMULATION PARAMETERS ***

% SIMULATION
setString(handles.simulationFileNameText, Constants.No_File_Name_String);

setString(handles.simulationScatteringNoiseLevelEdit, '');
setString(handles.simulationDetectorNoiseLevelEdit, '');

set(handles.simulationPartialPixelModellingCheckbox, 'Value', 1);

setString(handles.simulationPartialPixelResolutionEdit, '');

% DETECTOR
setString(handles.detectorFileNameText, Constants.No_File_Name_String);

setString(handles.detectorStartingLocationXEdit, '0'); % assume detector starts along y-axis
setString(handles.detectorStartingLocationYEdit, '');
setString(handles.detectorStartingLocationZEdit, '0'); % assume detector starts along y-axis

setString(handles.detectorWholeDetectorDimensionsXYEdit, '');
setString(handles.detectorWholeDetectorDimensionsZEdit, '0'); % assume 2D

setString(handles.detectorSingleDetectorDimensionsXYEdit, '');
setString(handles.detectorSingleDetectorDimensionsZEdit, '0'); % assume 2D

setPopupMenu(handles.detectorSingleDetectorDimensionsXYUnitsPopupMenu, 'Units', Units.mm);
setPopupMenu(handles.detectorSingleDetectorDimensionsZUnitsPopupMenu, 'Units', Units.mm);

set(handles.detectorMovesWithScanAngleCheckbox, 'Value', 1);
set(handles.detectorMovesWithPerAngleTranslationCheckbox, 'Value', 0);

% SOURCE
setString(handles.sourceFileNameText, Constants.No_File_Name_String);

setString(handles.sourceStartingLocationXEdit, '0'); % assume source starts along y-axis
setString(handles.sourceStartingLocationYEdit, '');
setString(handles.sourceStartingLocationZEdit, '0'); % assume source starts along y-axis

setString(handles.sourceDimensionsXYEdit, '0'); % assume point source
setString(handles.sourceDimensionsZEdit, '0'); % assume point source

setPopupMenu(handles.sourceDimensionsXYUnitsPopupMenu, 'Units', Units.mm);
setPopupMenu(handles.sourceDimensionsZUnitsPopupMenu, 'Units', Units.mm);

setString(handles.sourceBeamAngleXYEdit, '');
setString(handles.sourceBeamAngleZEdit, '0'); %assume 2D

% SCAN
setString(handles.scanFileNameText, Constants.No_File_Name_String);

setString(handles.scanAnglesEdit, '0:10:350'); % default is 360 scan at 10 degree increments
setString(handles.scanSlicePositionsEdit, '0'); % assume one slice only (2D)

setString(handles.scanPerAngleTranslationStepsXYEdit, '0'); % assume no per angle movement
setString(handles.scanPerAngleTranslationStepsZEdit, '0'); % assume no per angle movement

setString(handles.scanPerAngleStepDimensionsXYEdit, '0'); % assume no per angle movement
setString(handles.scanPerAngleStepDimensionsZEdit, '0'); % assume no per angle movement

setString(handles.scanBeamCharacterizationFileNameText, Constants.No_File_Name_String);

% PHANTOM
setString(handles.phantomFileNameText, Constants.No_File_Name_String);

setString(handles.phantomStartingLocationXEdit, '');
setString(handles.phantomStartingLocationYEdit, '');
setString(handles.phantomStartingLocationZEdit, '0'); %assume 2D

setString(handles.phantomVoxelDimensionsXEdit, '');
setString(handles.phantomVoxelDimensionsYEdit, '');
setString(handles.phantomVoxelDimensionsZEdit, '');

setString(handles.phantomDataSetFileNameText, Constants.No_File_Name_String);

end

