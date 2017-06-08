function [] = beamCharacterizationLoadButtonCallback(app)
% [] = beamCharacterizationLoadButtonCallback(app)
% callback function that loads up a scan beam characterization

photonBeam = PhotonBeam;

photonBeam.saveInSeparateFile = true;

photonBeam = photonBeam.load(app.settings.Simulation_Save_Path);

if ~isempty(photonBeam)
    % update handles
    app.workspace.simulation.scan.beamCharacterization = photonBeam;
    
    app.workspace.setGUI(app);
end

end

