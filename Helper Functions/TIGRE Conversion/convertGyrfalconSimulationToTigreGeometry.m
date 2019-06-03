function [tigreGeometry, tigrePhantom, tigreAnglesInRadians, tigrePoissonNoise, tigreGaussianNoise] = convertGyrfalconSimulationToTigreGeometry(gyrfalconSimulation)
%[tigreGeometry, tigrePhantom, tigreAnglesInRadians, tigrePoissonNoise, tigreGaussianNoise] = convertGyrfalconSimulationToTigreGeometry(gyrfalconSimulation)


% ** CHECK IF VALID FOR TIGRE **

% 1) Can't have curved detectors
if gyrfalconSimulation.detector.singleDetectorDimensions(1).isAngular() || gyrfalconSimulation.detector.singleDetectorDimensions(2).isAngular()
    error('Invalid Geometry for TIGRE Simulation: No curved detectors.');
end

% 2) Source & Detector must be opposite of one another
if ~gyrfalconSimulation.isSourceOppositeOfDetector()
    error('Invalid Geometry for TIGRE Simulation: Source and Detector must be opposite of each other.');
end

% 3) No detector translation steps (could do this w/ TIGRE by using
% multiple calls, but not a priority right now)
if any(gyrfalconSimulation.scan.perAngleTranslationDimensions > 1)
    error('Invalid Geometry for TIGRE Simulation: Detector may not translate during scan.');
end

% 4) Detector must move with source
if ~gyrfalconSimulation.detector.movesWithScanAngle
    error('Invalid Geometry for TIGRE Simulation: Detector must move with source.');
end

% 5) Only one slice at z=0 can be imaged
% again this could be done with TIGRE by offseting the phantom, but it's
% not a priority
if ~(length(gyrfalconSimulation.scan.slices) == 1 && gyrfalconSimulation.scan.slices(1) == 0)
    error('Invalid Geometry for TIGRE Simulation: Can only image a single slice at z=0');
end

% 6) Only mono-energetic beams
% could be done with multiple TIGRE runs for re-calibrated HU datasets, but
% let's not
if length(gyrfalconSimulation.scan.beamCharacterization.energies) > 1
    error('Invalid Geometry for TIGRE Simulation: Can only use mono-energetic beams.');
end


% ** PHYSICAL GEOMETRY **

% distances
[DSD, DSO] = getTigreDsdAndDSO(gyrfalconSimulation.source, gyrfalconSimulation.detector);

tigreGeometry.DSD = DSD;
tigreGeometry.DSO = DSO;

% detector params
[nDetector, dDetector, sDetector] = getTigreDetectorValues(gyrfalconSimulation.detector);

tigreGeometry.nDetector = nDetector;
tigreGeometry.dDetector = dDetector;
tigreGeometry.sDetector = sDetector;

% image/phantom params
[nVoxel, dVoxel, sVoxel] = getTigreVoxelValues(gyrfalconSimulation.phantom.dataSet.getSize(), gyrfalconSimulation.phantom.getVoxelDimensionsInM());

tigreGeometry.nVoxel = nVoxel;
tigreGeometry.dVoxel = dVoxel;
tigreGeometry.sVoxel = sVoxel;

% phantom offset
% Gyrfalcon gives (x,y,z) of min-x, max-y, max-z corner
% TIGRE specifies the centre of the phantom at the origin as default.
% the centre can then be offset as needed.

centreLocationInM = gyrfalconSimulation.phantom.getCentreLocationInM();
tigreGeometry.offOrigin = (centreLocationInM .* Constants.m_to_mm)';

% detector offset (Gyrfalcon doesn't do this, TIGRE does)
tigreGeometry.offDetector = [0;0];

% ** SIMULATION PARAMETERS **

% foward projection accuracy
if gyrfalconSimulation.partialPixelModelling
    tigreGeometry.accuracy = 1 / gyrfalconSimulation.partialPixelResolution;
else
    tigreGeometry.accuracy = 1;
end

% ** PHANTOM **

tigrePhantom = gyrfalconSimulation.scan.beamCharacterization.calibratedPhantomDataSet{1};
tigrePhantom = single(tigrePhantom .* (1 / Constants.m_to_mm));

% ** SCAN ANGLES **
tigreAnglesInRadians = getTigreAngles(gyrfalconSimulation.scan);

% ** NOISE LEVELS **
% Poisson (Scatter) Noise

scatteringNoiseLevel = gyrfalconSimulation.scatteringNoiseLevel;

if scatteringNoiseLevel == 0 %avoid division by zero
    scatteringNoiseLevel = 1e-10;
end

tigrePoissonNoise = 1 ./ scatteringNoiseLevel;

% Gaussian (Detector) Noise

tigreGaussianNoise = [0, gyrfalconSimulation.detectorNoiseLevel];


end

