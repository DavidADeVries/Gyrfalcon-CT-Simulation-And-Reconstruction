function [] = beamCharacterizationLoadButtonCallback(app)
% [] = beamCharacterizationLoadButtonCallback(app)
% callback function that loads up a scan beam characterization

photonBeam = PhotonBeam;

photonBeam.saveInSeparateFile = true;

photonBeam = photonBeam.load();

if ~isempty(photonBeam)
    % update handles
    app.workspace.simulation.scan.beamCharacterization = photonBeam;
    
    app.workspace.setGUI(app);
end

end

