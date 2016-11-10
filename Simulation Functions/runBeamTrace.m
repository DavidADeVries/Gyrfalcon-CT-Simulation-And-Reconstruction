function detectorData = runBeamTrace(sourcePosition, sourceDirection, detectorCornerCoords, phantomData, voxelDimsInM, phantomLocationInM, beamCharacterization, scatteringNoiseLevel, detectorNoiseLevel,  partialPixelModelling)
% detectorData = runBeamTrace(sourcePosition, sourceDirection, detectorCornerCoords, phantomData, voxelDimsInM, phantomLocationInM, beamCharacterization, scatteringNoiseLevel, detectorNoiseLevel,  partialPixelModelling)
% runs the trace of a beam through the phantom
% descriptions of variables:
%
% detectorData : intensity value that detector feeds out
% sourcePosition : where the source is positioned in 3 space
% sourceDirection : unit vector of where the centre of source is pointed
% detectorCornerCoords : coords in 3 space of where the 4 corners of the detector is
% phantomData : a 3D grid of voxel values
% voxelDimsInM : dimensions of each phantom voxel in metres
% phantomLocationInM : location of the top, left, forward corner is in 3 space in metres
% beamCharacterization : cell array of photon beams
% scatteringNoiseLevel : range of 0 to 1
% detectorNoiseLevel : range 0f 0 to 1
% partialPixel : boolean value: true if the distance travelled through a
% voxel will be taken into account

detectorData = 1;

end

