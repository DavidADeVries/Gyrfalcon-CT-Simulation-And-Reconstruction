function phant = loadSheppLoganPhantom(phantomSize, voxelDim)
% phant = loadSheppLoganPhantom()
% load up the Shepp-Logan phantom built into Matlab, and build-up the rest
% of the Phantom class parameters

data = phantom(phantomSize); % "phantom()" is a matlab function to produce the Shepp-Logan phantom

one = ones(phantomSize, 1);
zero = zeros(phantomSize, 1);

data = [zero, one, zero, zero, one, one, zero, zero, zero, one, one, one, data, one, one, one, zero, zero, zero, one, one, zero, zero, one, zero];

dimensions = [voxelDim,voxelDim]; %each pixel is 10mm x 10mm

location = centrePhantom(data, dimensions);

phant = Phantom(data, dimensions, location);