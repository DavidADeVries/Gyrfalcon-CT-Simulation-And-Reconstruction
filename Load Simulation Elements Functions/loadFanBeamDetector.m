function detector = loadFanBeamDetector(yPos, numDetectors, singleDetectorAngle)

% load up a fan-beam detector for use in a simulation

location = [0, yPos]; % located along y-axis, 0.5m down

value = singleDetectorAngle; % one degree each
isPlanar = true;%for test false;

singleDetectorDimension = Dimension(value, isPlanar);

detectorMovesWithSource = true;

detector = Detector(location, numDetectors, singleDetectorDimension, detectorMovesWithSource);