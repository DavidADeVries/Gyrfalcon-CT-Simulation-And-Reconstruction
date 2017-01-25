function [] = scanBeamCharacterizationLoadButtonCallback(hObject, eventdata, handles)
% [] = scanBeamCharacterizationLoadButtonCallback(hObject, eventdata, handles)
% callback function that loads up a scan beam characterization

question = 'What beam characterization would you like to use?';
title = 'Load Beam Characterization';

createNew = 'Create New';
loadBeam = 'Load Existing';
cancel = 'Cancel';

default = loadBeam;

choice = questdlg(question, title, createNew, loadBeam, cancel, default);

switch choice
    case createNew
        [photonBeam, fileName] = createNewBeamCharacterization();
    case loadBeam
        [photonBeam, fileName] = loadExistingBeamCharacterization();
    case cancel
        photonBeam = [];
        fileName = '';
end

if ~isempty(photonBeam) && ~isempty(fileName)
    % update handles
    setString(handles.scanBeamCharacterizationFileNameText, fileName);
    
    handles.scanBeamCharacterizationPath = '';
    handles.scanBeamCharacterizationFileName = fileName;
    handles.scanBeamCharacterization = photonBeam;
    
    guidata(hObject, handles);
end

end

% HELPER FUNCTIONS

function [photonBeam, fileName] = createNewBeamCharacterization()
    fileName = '';
    
    title = 'Create Beam Characterization';

    questions = {'Please enter beam intensity (W/m²):', 'Please enter beam energy (keV)'};
    default = {'100','1'};
    numLines = 1;
    
    answers = inputdlg(questions, title, numLines, default);
    
    if isempty(answers) % pressed cancel
        photonBeam = [];
    else
        intensity = str2double(answers{1});
        energy = str2double(answers{2});
        
        photonBeam = PhotonBeam(energy, intensity);
        
        enerString = num2str(energy);
        
        fileName = [Constants.Default_Beam_Characterization_File_Name, ' - ', enerString, 'keV'];

        defaultName = [fileName, Constants.Matlab_File_Extension];
        dialogTitle = 'Save Beam Characterization As...';
        
        [fileName, pathName] = uiputfile(defaultName, dialogTitle);
        
        if ischar(fileName) && ischar(pathName) % not cancelled
            savePath = makePath(pathName, fileName);
                        
            save(savePath, Constants.Save_Beam_Characterization_Var_Name); %var: "photonBeam"
        else
            photonBeam = []; % cancelled, so we wipe it out
        end
    end
end


function [photonBeam, fileName] = loadExistingBeamCharacterization()
    filter = ['*', Constants.Matlab_File_Extension];
    dialogTitle = 'Load Beam Characterization...';

    [fileName, pathName] = uigetfile(filter, dialogTitle);

    if ischar(fileName) && ischar(pathName) % not cancelled
        loadPath = makePath(pathName, fileName);

        vars = load(loadPath);

        photonBeam = vars.photonBeam;
    else
        photonBeam = [];
    end
end