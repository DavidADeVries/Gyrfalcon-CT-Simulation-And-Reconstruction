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

    questions = {'Please enter beam intensities (a,b,c or start:interval:end) (W/m²):', 'Please enter matching beam energies (a,b,c or start:interval:end) (MeV)'};
    default = {'1','1'};
    numLines = 1;
    
    answers = inputdlg(questions, title, numLines, default);
    
    if isempty(answers) % pressed cancel
        photonBeam = [];
    else
        intensities = getValuesFromIntervalString(answers{1});
        energies = getValuesFromIntervalString(answers{2});
        
        photonBeam = PhotonBeam(energies, intensities);
        
        photonBeam = photonBeam.saveAs();
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