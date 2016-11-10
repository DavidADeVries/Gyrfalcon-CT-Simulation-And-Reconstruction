%runFanBeamSim
%
%this script:
% - loads up a fan beam source and detector, and Shepp-Logan phantom
% - plots scan config
% - runs simulation

% 1 -- LOAD SIM

% PHANTOM
phantomSize = 100;
voxelSize = 10; %10mm

phantom = loadSheppLoganPhantom(phantomSize, voxelSize);

% SOURCE
yPos = 0.5; %0.5m up on the y-axis
beamAngle = 30; %degrees

source = loadFanBeamSource(yPos, beamAngle);

% DETECTOR
yPos = -0.5;
numDetectors = 60;
singleDetectorAngle = 10;

detector = loadFanBeamDetector(yPos, numDetectors, singleDetectorAngle);

% SCAN
scanAngles = (0:35) * 10; % [0,10,20,30,...,350]

scan = loadFanBeamScan(scanAngles);

% SIMULATION
scatteringNoiseLevel = 0.1;
detectorNoiseLevel = 0.1;
partialPixelModelling = false;

simulation = Simulation(phantom,detector, source, scan, scatteringNoiseLevel, detectorNoiseLevel, partialPixelModelling);


% 2 -- PLOT SCAN CONFIG

simulation.plot();