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

workspace = handles.workspace.createFromGUI(handles);

switch choice
    case createNew
        photonBeam = createNewBeamCharacterization();
    case loadBeam
        photonBeam = PhotonBeam;
        
        photonBeam = photonBeam.load();
    case cancel
        photonBeam = [];
end

if ~isempty(photonBeam)
    % update handles
    workspace.simulation.scan.beamCharacterization = photonBeam;
    
    handles = workspace.setGUI(handles);
    
    handles.workspace = workspace;
    
    guidata(hObject, handles);
end

end

% HELPER FUNCTIONS

function photonBeam = createNewBeamCharacterization()
        
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
        
        clearBeforeSave = false;
        
        [saved,photonBeam] = photonBeam.saveAs(clearBeforeSave);
        
        if ~saved
            photonBeam.saveInSeparateFile = false;
        end
    end
end
