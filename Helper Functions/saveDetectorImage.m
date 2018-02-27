function [] = saveDetectorImage(detectorData, savePath, indices, angles, isScanPositionMosiac)
%function [] = saveDetectorImage(detectorData, savePath, indices, angles, isScanPositionMosiac)
    sliceFolder = makeSliceFolderName(indices(1));
    angleFolder = makeAngleFolderName(angles(indices(2)));
    positionName = makePositionName(indices(4), indices(3), isScanPositionMosiac);
    
    fileName = makePositionFileName(positionName);
    
    writePath = makePath(savePath, sliceFolder, angleFolder, fileName);
    
    save(writePath, Constants.Detector_Data_Var_Name);
end

