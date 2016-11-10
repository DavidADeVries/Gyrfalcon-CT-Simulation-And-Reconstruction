function source = loadFanBeamSource(yPos, beamAngle)

% load up a fan-beam x-ray source for use in a simulation

location = [0,yPos]; % located along y-axis

value = 0;
isPlanar = true;

dimension = Dimension(value, isPlanar);

dimensions = [dimension, dimension]; % point source

source = Source(location, dimensions, beamAngle);