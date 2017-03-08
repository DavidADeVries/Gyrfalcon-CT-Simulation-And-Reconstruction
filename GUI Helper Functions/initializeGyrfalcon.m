function handles = initializeGyrfalcon(hObject, handles)
% handles = initializeGyrfalcon(hObject, handles)
% initializes the UI and variables for Gyrfalcon.
% Also opens the display figure

setString(handles.statusOutputText, {'Initializing Gyrfalcon...'});

% *******************************
% *** INITIALIZE DATA HANDLES ***
% *******************************

handles.workspace = GyrfalconWorkspace;
handles.workspace = handles.workspace.setDefaultValues();

% *********************************
% *** INITIALIZE DISPLAY FIGURE ***
% *********************************

handles = initializeDisplayFigure(handles);

% **********************
% *** INITIALIZE GUI ***
% **********************

% *** CONTROL PANEL ***

set(handles.controlPanelRunScanSimButton, 'Enable', 'on');
set(handles.controlPanelRunReconstructionButton, 'Enable', 'off');
set(handles.controlPanelUnassignedTaskButton, 'Enable', 'off');

% *** SCAN SIMULATION PARAMETERS ***

setString(handles.statusOutputText, {'Initializing Gyrfalcon...Complete'});

handles.workspace.statusOutput = getString(handles.statusOutputText);

handles = handles.workspace.setGUI(handles);

end

