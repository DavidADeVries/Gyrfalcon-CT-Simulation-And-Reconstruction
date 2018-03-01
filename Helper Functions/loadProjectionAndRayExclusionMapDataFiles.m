function [projectionImage, rayExclusionMap] = loadProjectionAndRayExclusionMapDataFiles(simulationOrImagingScanRun, sliceIndex, angle, xyPositionIndex, zPositionIndex)
%[projectionImage, rayExclusionMap] = loadProjectionAndRayExclusionMapDataFiles(simulationOrImagingScanRun, sliceIndex, angle, xyPositionIndex, zPositionIndex)
    
    path = simulationOrImagingScanRun.savePath;
    
    sliceFolder = makeSliceFolderName(sliceIndex);
    angleFolder = makeAngleFolderName(angle);
    
    isScanPositionMosiac = false;
    name = makePositionName(xyPositionIndex, zPositionIndex,  isScanPositionMosiac);
    
    detectorFileName = makePositionFileName(name);
    rayExclusionMapFileName = makeRayExclusionMapFileName(name);
    
    data = load(makePath(path, sliceFolder, angleFolder, detectorFileName));
    projectionImage = data.(Constants.Detector_Data_Var_Name);
    
    data = load(makePath(path, sliceFolder, angleFolder, rayExclusionMapFileName));
    rayExclusionMap = data.(Constants.Ray_Exclusion_Map_Var_Name);
end

