function [] = beamCharacterizationNewButtonCallback(app)
% [] = beamCharacterizationNewButtonCallback(app)
% callback function that creates a new scan beam characterization

photonBeam = createNewBeamCharacterization();

if ~isempty(photonBeam)
    % update handles
    app.workspace.simulation.scan.beamCharacterization = photonBeam;
    
    app.workspace.setGUI(app);
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
        
        photonBeam.saveInSeparateFile = true;
                
        [saved,photonBeam] = photonBeam.saveAs();
        
        if ~saved
            photonBeam.saveInSeparateFile = false;
        end
    end
end
