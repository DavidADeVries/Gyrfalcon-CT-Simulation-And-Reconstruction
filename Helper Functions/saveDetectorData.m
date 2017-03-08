function [] = saveDetectorData(savePath, distancesAcrossVoxels, voxelPhantomCoords, detectorCornerCoords)
% [] = saveDetectorData(savePath, distancesAcrossVoxels, voxelPhantomCoords, detectorCornerCoords)


save(makePath(savePath,'distancesAcrossVoxels.mat'),'distancesAcrossVoxels','-v7.3');
save(makePath(savePath,'voxelPhantomCoords.mat'),'voxelPhantomCoords','-v7.3');
save(makePath(savePath,'detectorCornerCoords.mat'),'detectorCornerCoords','-v7.3');


end

