function []  = plotSimulation(simulation, app)
%[] = plotSimulation(simulation, app)

axesHandle = app.axesHandle;

axes(axesHandle);

redrawAxes(axesHandle);

% plot phantom
simulation.phantom.plot(axesHandle);

% plot scan geometery

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

% get the source/detector centres

% will plot the first angle and slice, listed, the middle most per angle
% translation step, and the whole detector (but here we just want the
% middle of the detector, so we'll make a small one

newDetectorDims = [1 1];
perAngleIndices = round(numPerAngleSteps / 2);

indices = [1 1 perAngleIndices(2) perAngleIndices(1) 1 1]; % will plot the first step in everything

[pointSourceCoords, pointDetectorCoords, ~] = ...
    calculateSourceAndDetectorCoords(...
    indices,...
    sourcePositionInM, detectorPositionInM, slicesInM, anglesInDeg,...
    perAngleStepDimsInM, numPerAngleSteps, newDetectorDims, detectorPixelDimsWithUnits, angularDetectorRadiusInM,...
    detectorMovesWithScanAngle, detectorMovesWithPerAngleSteps, beamAnglesInDegrees);

newNumPerAngleSteps = [1,1];
[centreSourceCoords, ~, ~] = ...
    calculateSourceAndDetectorCoords(...
    indices,...
    sourcePositionInM, detectorPositionInM, slicesInM, anglesInDeg,...
    perAngleStepDimsInM, newNumPerAngleSteps, newDetectorDims, detectorPixelDimsWithUnits, angularDetectorRadiusInM,...
    detectorMovesWithScanAngle, detectorMovesWithPerAngleSteps, beamAnglesInDegrees);

plotSourceCoords = pointSourceCoords;

sourceNorm = norm(pointSourceCoords(1:2));
detectorNorm = norm(pointDetectorCoords(1:2));

detectorXY = pointDetectorCoords(1:2);
[angle,~] = cart2pol(pointSourceCoords(1:2)

beamAngleRadius = sourceNorm + detectorNorm;



plotSliceRadius = max(sourceNorm, detectorNorm);
plotSliceZValues = slicesInM;


end

