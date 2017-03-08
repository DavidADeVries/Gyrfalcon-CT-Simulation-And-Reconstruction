function varargout = SimulationRunSettingsGUI(varargin)
% SIMULATIONRUNSETTINGSGUI MATLAB code for SimulationRunSettingsGUI.fig
%      SIMULATIONRUNSETTINGSGUI by itself, creates a new SIMULATIONRUNSETTINGSGUI or raises the
%      existing singleton*.
%
%      H = SIMULATIONRUNSETTINGSGUI returns the handle to a new SIMULATIONRUNSETTINGSGUI or the handle to
%      the existing singleton*.
%
%      SIMULATIONRUNSETTINGSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULATIONRUNSETTINGSGUI.M with the given input arguments.
%
%      SIMULATIONRUNSETTINGSGUI('Property','Value',...) creates a new SIMULATIONRUNSETTINGSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SimulationRunSettingsGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SimulationRunSettingsGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SimulationRunSettingsGUI

% Last Modified by GUIDE v2.5 08-Mar-2017 10:53:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SimulationRunSettingsGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SimulationRunSettingsGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before SimulationRunSettingsGUI is made visible.
function SimulationRunSettingsGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SimulationRunSettingsGUI (see VARARGIN)

% Choose default command line output for SimulationRunSettingsGUI
handles.cancel = true;


if(length(varargin) == 2)
    numCoresAvailable = varargin{1};
    
    handles.numAvailableCores = numCoresAvailable;
    
    gpuAvailable = varargin{2};
    
    setString(handles.numCPUAvailableText, ['/', num2str(numCoresAvailable)]);
    setDoubleForHandle(handles.numCPUTextEdit, numCoresAvailable);
    
    set(handles.useGPUCheckbox, 'Value', gpuAvailable);
    
    if ~gpuAvailable
        set(handles.useGPUCheckbox, 'Enable', 'off');
    end
    
    setString(handles.notesTextEdit, '');
else
    error('Invalid parameters. Number of available cores and whether GPU available required.');
end

% Update handles structure
guidata(hObject, handles);

% Determine the position of the dialog - centered on the callback figure
% if available, else, centered on the screen
FigPos=get(0,'DefaultFigurePosition');
OldUnits = get(hObject, 'Units');
set(hObject, 'Units', 'pixels');
OldPos = get(hObject,'Position');
FigWidth = OldPos(3);
FigHeight = OldPos(4);
if isempty(gcbf)
    ScreenUnits=get(0,'Units');
    set(0,'Units','pixels');
    ScreenSize=get(0,'ScreenSize');
    set(0,'Units',ScreenUnits);

    FigPos(1)=1/2*(ScreenSize(3)-FigWidth);
    FigPos(2)=2/3*(ScreenSize(4)-FigHeight);
else
    GCBFOldUnits = get(gcbf,'Units');
    set(gcbf,'Units','pixels');
    GCBFPos = get(gcbf,'Position');
    set(gcbf,'Units',GCBFOldUnits);
    FigPos(1:2) = [(GCBFPos(1) + GCBFPos(3) / 2) - FigWidth / 2, ...
                   (GCBFPos(2) + GCBFPos(4) / 2) - FigHeight / 2];
end
FigPos(3:4)=[FigWidth FigHeight];
set(hObject, 'Position', FigPos);
set(hObject, 'Units', OldUnits);


% Make the GUI modal
set(handles.SimulationRunSettingsGUI,'WindowStyle','modal')

% UIWAIT makes SimulationRunSettingsGUI wait for user response (see UIRESUME)
uiwait(handles.SimulationRunSettingsGUI);

% --- Outputs from this function are returned to the command line.
function varargout = SimulationRunSettingsGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.cancel;
varargout{2} = getString(handles.notesTextEdit);

numCores = getDoubleFromHandle(handles.numCPUTextEdit);

if numCores < 1
    numCores = 1;
    
    h = msgbox('The number of cores entered was less than 1, so 1 core will be used.');
    uiwait(h);
    
elseif numCores > handles.numAvailableCores
    numCores = handles.numAvailableCores;
    
    numStr = num2str(handles.numAvailableCores);
    
    h = msgbox(['The number of cores entered was greater than ', numStr, ', so ', numStr, ' will be used.']);
    uiwait(h);
end

varargout{3} = numCores;
varargout{4} = get(handles.useGPUCheckbox, 'Value');

% The figure can be deleted now
delete(handles.SimulationRunSettingsGUI);

% --- Executes on button press in okButton.
function okButton_Callback(hObject, eventdata, handles)
% hObject    handle to okButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cancel = false;

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.SimulationRunSettingsGUI);

% --- Executes on button press in cancelButton.
function cancelButton_Callback(hObject, eventdata, handles)
% hObject    handle to cancelButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cancel = true;

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.SimulationRunSettingsGUI);


% --- Executes when user attempts to close SimulationRunSettingsGUI.
function SimulationRunSettingsGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to SimulationRunSettingsGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end


% --- Executes on key press over SimulationRunSettingsGUI with no controls selected.
function SimulationRunSettingsGUI_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to SimulationRunSettingsGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check for "enter" or "escape"
if isequal(get(hObject,'CurrentKey'),'escape')
    % User said no by hitting escape
    handles.output = 'No';
    
    % Update handles structure
    guidata(hObject, handles);
    
    uiresume(handles.SimulationRunSettingsGUI);
end    
    
if isequal(get(hObject,'CurrentKey'),'return')
    uiresume(handles.SimulationRunSettingsGUI);
end    



function notesTextEdit_Callback(hObject, eventdata, handles)
% hObject    handle to notesTextEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of notesTextEdit as text
%        str2double(get(hObject,'String')) returns contents of notesTextEdit as a double


% --- Executes during object creation, after setting all properties.
function notesTextEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to notesTextEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in useGPUCheckbox.
function useGPUCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to useGPUCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of useGPUCheckbox



function numCPUTextEdit_Callback(hObject, eventdata, handles)
% hObject    handle to numCPUTextEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numCPUTextEdit as text
%        str2double(get(hObject,'String')) returns contents of numCPUTextEdit as a double


% --- Executes during object creation, after setting all properties.
function numCPUTextEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numCPUTextEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function numCPUAvailableText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numCPUAvailableText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
