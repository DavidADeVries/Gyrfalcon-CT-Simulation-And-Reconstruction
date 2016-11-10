function [] = phantomDataSetLoadButtonCallback(hObject, eventdata, handles)
% [] = phantomDataSetLoadButtonCallback(hObject, eventdata, handles)
% callback function that loads up a phantom data set

question = 'What phantom data set would you like to use?';
title = 'Load Phantom Data Set';

createNew = 'Create New';
loadDataSet = 'Load Existing';
cancel = 'Cancel';

default = loadDataSet;

choice = questdlg(question, title, createNew, loadDataSet, cancel, default);

switch choice
    case createNew
        [dataSet, fileName] = createNewDataSet();
    case loadDataSet
        [dataSet, fileName] = loadExistingDataSet();
    case cancel
        dataSet = [];
        fileName = '';
end

if ~isempty(dataSet) && ~isempty(fileName)
    % update handles
    setString(handles.phantomDataSetFileNameText, fileName);
    handles.phantomDataSet = dataSet;
    
    guidata(hObject, handles);
end

end

% HELPER FUNCTIONS

function [dataSet, fileName] = createNewDataSet()
    fileName = '';
    
    title = 'Create Shepp-Logan Phantom Data Set';

    questions = {'Please enter the x/y dimension (will be square!):', 'Please enter the z dimension (will duplicate xy slice):'};
    default = {'50','1'};
    numLines = 1;
    
    answers = inputdlg(questions, title, numLines, default);
    
    if isempty(answers) % pressed cancel
        dataSet = [];
    else
        xyDim = str2double(answers{1});
        zDim = str2double(answers{2});
        
        dataSet = zeros(xyDim, xyDim, zDim);
        
        slice = phantom(xyDim); %use Matlab Shepp-Logan phantom
        
        for i=1:zDim
            dataSet(:,:,i) = slice;
        end
    end
    
    if ~isempty(dataSet)
        % must save it!
        
        % get path and filename
        
        xStr = num2str(xyDim);
        yStr = num2str(xyDim);
        zStr = num2str(zDim);
        
        byStr = 'x';
        
        fileName = [Constants.Default_Phantom_Data_Set_File_Name, ' - ', xStr, byStr, yStr, byStr, zStr];

        defaultName = [fileName, Constants.Matlab_File_Extension];
        dialogTitle = 'Save Phantom Data Set As...';
        
        [fileName, pathName] = uiputfile(defaultName, dialogTitle);
        
        if ischar(fileName) && ischar(pathName) % not cancelled
            savePath = makePath(pathName, fileName);
                        
            save(savePath, Constants.Save_Phantom_Data_Set_Var_Name); %var: "dataSet"
        else
            dataSet = []; % cancelled, so we wipe it out
        end
    end
end


function [dataSet, fileName] = loadExistingDataSet()
    filter = ['*', Constants.Matlab_File_Extension];
    dialogTitle = 'Load Phantom Data Set...';

    [fileName, pathName] = uigetfile(filter, dialogTitle);

    if ischar(fileName) && ischar(pathName) % not cancelled
        loadPath = makePath(pathName, fileName);

        vars = load(loadPath);

        dataSet = vars.dataSet;
    else
        dataSet = [];
    end
end