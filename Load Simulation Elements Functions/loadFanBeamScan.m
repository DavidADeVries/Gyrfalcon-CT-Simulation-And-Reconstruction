function scan = loadFanBeamScan(scanAngles)

% load up a fan-beam scan for use in a simulation

slices = 0; % just the one slice (aka 2D)

perAngleTranslationDimensions = [0,0]; %doesn't move
perAngleTranslationResolution = [0,0]; %doesn't move

beamEnergy = 175; %in kEv
beamIntensity = 30; %in w/m^2

photonBeam = PhotonBeam(beamEnergy, beamIntensity);

beamCharacterization = {photonBeam}; %an ideal case

scan = Scan(scanAngles, slices, perAngleTranslationDimensions, perAngleTranslationResolution, beamCharacterization);