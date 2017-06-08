function []  = sourceBeamAngleFillDetectorButtonCallback(app)
%[] = sourceBeamAngleFillDetectorButtonCallback(app)

workspace = app.workspace.createFromGUI(app);

simulation = workspace.simulation;

detector = simulation.detector;
source = simulation.source;
scan = simulation.scan;

% base variables
sourcePositionInM = source.getLocationInM();
detectorPositionInM = detector.getLocationInM();
slicesInM = scan.getSlicesInM();
anglesInDeg = scan.getScanAnglesInDegrees();
perAngleStepDimsInM = scan.getPerAngleTranslationResolutionInM();
numPerAngleSteps = scan.perAngleTranslationDimensions;
detectorDims = detector.wholeDetectorDimensions;
detectorPixelDimsWithUnits = detector.singleDetectorDimensions;
angularDetectorRadiusInM = detector.getAngularDetectorRadiusInM();
detectorMovesWithScanAngle = detector.movesWithScanAngle;
detectorMovesWithPerAngleSteps = detector.movesWithPerAngleTranslation;
beamAnglesInDegrees = source.getBeamAngleInDegrees();

% slight alterations needed:

% set source and detector opposite one another;
anglesInDeg = 0;
slicesInM = 0; % put everything at z = 0;

sourcePositionInM = [0, -norm(sourcePositionInM)];
detectorPositionInM = [0, norm(detectorPositionInM)];

% ******************
% FIND XY BEAM ANGLE
% ******************

newNumPerAngleSteps = [1 1]; % even though it might move, just set to centre for ease

% need detector size to be higher, since to the functions give middle of
% detector, and we want the edge of the detector;
newDetectorDims = detectorDims + 1;

indices = [1 1 1 1 1 1];

[pointSourceCoords, pointDetectorCoords, ~] = ...
    calculateSourceAndDetectorCoords(...
    indices,...
    sourcePositionInM, detectorPositionInM, slicesInM, anglesInDeg,...
    perAngleStepDimsInM, newNumPerAngleSteps, newDetectorDims, detectorPixelDimsWithUnits, angularDetectorRadiusInM,...
    detectorMovesWithScanAngle, detectorMovesWithPerAngleSteps, beamAnglesInDegrees);

if detectorMovesWithScanAngle % can't really help too much if detector doesn't move with the source
    y = abs(pointDetectorCoords(2) - pointSourceCoords(2));
    x = abs(pointDetectorCoords(1) - pointSourceCoords(1));
    
    xyBeamAngle = 2*atand(x / y);
else
    xyBeamAngle = beamAnglesInDegrees(1);
end

% ******************
% FIND Z BEAM ANGLE
% ******************

newNumPerAngleSteps = [1 1]; % even though it might move, just set to centre for ease

% need detector size to be higher, since to the functions give middle of
% detector, and we want the edge of the detector;
newDetectorDims = detectorDims + 1;
newDetectorDims(1) = 1; % just set a single z-strip of detectors directly opposite the source

indices = [1 1 1 1 1 1];

[~, pointDetectorCoords, ~] = ...
    calculateSourceAndDetectorCoords(...
    indices,...
    sourcePositionInM, detectorPositionInM, slicesInM, anglesInDeg,...
    perAngleStepDimsInM, newNumPerAngleSteps, newDetectorDims, detectorPixelDimsWithUnits, angularDetectorRadiusInM,...
    detectorMovesWithScanAngle, detectorMovesWithPerAngleSteps, beamAnglesInDegrees);


% find z
y = abs(detectorPositionInM(2) - sourcePositionInM(2));
z = abs(pointDetectorCoords(3)); % source is at z = 0;

zBeamAngle = 2*atand(z / y);


% convert to proper units
beamAngle = source.beamAngleUnits.convertFromDegrees([xyBeamAngle, zBeamAngle]);

% save it back
workspace.simulation.source.beamAngle = beamAngle;


% update handles

workspace.simulation.setGUI(app);

app.workspace = workspace;


end

