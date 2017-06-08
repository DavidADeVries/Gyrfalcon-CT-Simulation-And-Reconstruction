p = phantom(50);

theta = 0:1:179;

firstGenProjectionData = {radon(p, theta)};

scanAngles = -theta;

sourceStartingLocationInM = [0.5 0];

phantomSliceDimensions = [50 50];

phantomVoxelDimensionsInM = [1 1];

phantomLocationInM = [-25 25];

detectorWidthInM = 1;

filterType = FirstGenFilterTypes.none;
applyRampFilter = true;
applyBandlimiting = false;
interpolationType = InterpolationTypes.nearestNeighbour;


[reconDataSet, sinograms, videosFrames] = firstGenFilteredBackProjectionAlgorithm(...
    firstGenProjectionData,...
    scanAngles, sourceStartingLocationInM, phantomSliceDimensions, phantomVoxelDimensionsInM, phantomLocationInM, detectorWidthInM,...
    filterType, applyRampFilter, applyBandlimiting, interpolationType);

figure(2);
imshow(reconDataSet{1},[],'InitialMagnification','fit');