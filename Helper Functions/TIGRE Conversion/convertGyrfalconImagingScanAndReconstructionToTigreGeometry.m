function [tigreGeometry, tigreAnglesInRadians] = convertGyrfalconImagingScanAndReconstructionToTigreGeometry(gyrfalconImagingScan, gyrfalconReconstruction)
%[tigreGeometry, tigreAnglesInRadians] = convertGyrfalconImagingScanAndReconstructionToTigreGeometry(gyrfalconImagingScan, gyrfalconReconstruction)

% distances
[DSD, DSO] = getTigreDsdAndDSO(gyrfalconImagingScan.source, gyrfalconImagingScan.detector);

tigreGeometry.DSD = DSD;
tigreGeometry.DSO = DSO;

% detector params
[nDetector, dDetector, sDetector] = getTigreDetectorValues(gyrfalconReconstruction);

tigreGeometry.nDetector = nDetector;
tigreGeometry.dDetector = dDetector;
tigreGeometry.sDetector = sDetector;

% image/phantom params
[nVoxel, dVoxel, sVoxel] = getTigreVoxelValues(gyrfalconReconstruction.reconDataSetDimensions, gyrfalconReconstruction.getReconDataSetVoxelDimensionsInM());

tigreGeometry.nVoxel = nVoxel;
tigreGeometry.dVoxel = dVoxel;
tigreGeometry.sVoxel = sVoxel;

% offset
tigreGeometry.offOrigin = [0;0;0]; % can't change from centre
tigreGeometry.offDetector = [0;0];

% foward projection accuracy
tigreGeometry.accuracy = gyrfalconReconstruction.forwardProjectionAccuracy;

% angles
tigreAnglesInRadians = getTigreAngles(gyrfalconImagingScan.scan);

end

