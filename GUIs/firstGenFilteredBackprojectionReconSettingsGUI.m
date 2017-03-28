function varargout = firstGenFilteredBackprojectionReconSettingsGUI(varargin)
% FIRSTGENFILTEREDBACKPROJECTIONRECONSETTINGSGUI MATLAB code for firstGenFilteredBackprojectionReconSettingsGUI.fig
%      FIRSTGENFILTEREDBACKPROJECTIONRECONSETTINGSGUI by itself, creates a new FIRSTGENFILTEREDBACKPROJECTIONRECONSETTINGSGUI or raises the
%      existing singleton*.
%
%      H = FIRSTGENFILTEREDBACKPROJECTIONRECONSETTINGSGUI returns the handle to a new FIRSTGENFILTEREDBACKPROJECTIONRECONSETTINGSGUI or the handle to
%      the existing singleton*.
%
%      FIRSTGENFILTEREDBACKPROJECTIONRECONSETTINGSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRSTGENFILTEREDBACKPROJECTIONRECONSETTINGSGUI.M with the given input arguments.
%
%      FIRSTGENFILTEREDBACKPROJECTIONRECONSETTINGSGUI('Property','Value',...) creates a new FIRSTGENFILTEREDBACKPROJECTIONRECONSETTINGSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before firstGenFilteredBackprojectionReconSettingsGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to firstGenFilteredBackprojectionReconSettingsGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help firstGenFilteredBackprojectionReconSettingsGUI

% Last Modified by GUIDE v2.5 28-Mar-2017 14:06:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @firstGenFilteredBackprojectionReconSettingsGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @firstGenFilteredBackprojectionReconSettingsGUI_OutputFcn, ...
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

% --- Executes just before firstGenFilteredBackprojectionReconSettingsGUI is made visible.
function firstGenFilteredBackprojectionReconSettingsGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to firstGenFilteredBackprojectionReconSettingsGUI (see VARARGIN)

% Choose default command line output for firstGenFilteredBackprojectionReconSettingsGUI
handles.output = 'Yes';

% Update handles structure
guidata(hObject, handles);

% Insert custom Title and Text if specified by the user
% Hint: when choosing keywords, be sure they are not easily confused 
% with existing figure properties.  See the output of set(figure) for
% a list of figure properties.
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        switch lower(varargin{index})
         case 'title'
          set(hObject, 'Name', varargin{index+1});
         case 'string'
          set(handles.text1, 'String', varargin{index+1});
        end
    end
end

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
set(handles.firstGenFilteredBackprojectionReconSettingsGUI,'WindowStyle','modal')

% UIWAIT makes firstGenFilteredBackprojectionReconSettingsGUI wait for user response (see UIRESUME)
uiwait(handles.firstGenFilteredBackprojectionReconSettingsGUI);

% --- Outputs from this function are returned to the command line.
function varargout = firstGenFilteredBackprojectionReconSettingsGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The figure can be deleted now
delete(handles.firstGenFilteredBackprojectionReconSettingsGUI);

% --- Executes on button press in okPushButton.
function okPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to okPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output = get(hObject,'String');

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.firstGenFilteredBackprojectionReconSettingsGUI);

% --- Executes on button press in cancelPushButton.
function cancelPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to cancelPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output = get(hObject,'String');

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.firstGenFilteredBackprojectionReconSettingsGUI);


% --- Executes when user attempts to close firstGenFilteredBackprojectionReconSettingsGUI.
function firstGenFilteredBackprojectionReconSettingsGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to firstGenFilteredBackprojectionReconSettingsGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end


% --- Executes on key press over firstGenFilteredBackprojectionReconSettingsGUI with no controls selected.
function firstGenFilteredBackprojectionReconSettingsGUI_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to firstGenFilteredBackprojectionReconSettingsGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check for "enter" or "escape"
if isequal(get(hObject,'CurrentKey'),'escape')
    % User said no by hitting escape
    handles.output = 'No';
    
    % Update handles structure
    guidata(hObject, handles);
    
    uiresume(handles.firstGenFilteredBackprojectionReconSettingsGUI);
end    
    
if isequal(get(hObject,'CurrentKey'),'return')
    uiresume(handles.firstGenFilteredBackprojectionReconSettingsGUI);
end    


% --- Executes on selection change in filterTypePopupMenu.
function filterTypePopupMenu_Callback(hObject, eventdata, handles)
% hObject    handle to filterTypePopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filterTypePopupMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filterTypePopupMenu


% --- Executes during object creation, after setting all properties.
function filterTypePopupMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterTypePopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in applyRampFilterCheckbox.
function applyRampFilterCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to applyRampFilterCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of applyRampFilterCheckbox


% --- Executes on button press in applyBandlimitingCheckbox.
function applyBandlimitingCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to applyBandlimitingCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of applyBandlimitingCheckbox


% --- Executes on selection change in interpolationTypePopupMenu.
function interpolationTypePopupMenu_Callback(hObject, eventdata, handles)
% hObject    handle to interpolationTypePopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns interpolationTypePopupMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from interpolationTypePopupMenu


% --- Executes during object creation, after setting all properties.
function interpolationTypePopupMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interpolationTypePopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
