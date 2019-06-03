function [detectorData_I0, detectorData_I, detectorDataRatio] = loadProjectionDataFiles(simulationOrImagingScanRun, sliceIndex, angle, xyPositionIndex, zPositionIndex)
%[detectorData_I0, detectorData_I, detectorDataRatio] = loadProjectionDataFiles(simulationOrImagingScanRun, sliceIndex, angle, xyPositionIndex, zPositionIndex)
    
    path = simulationOrImagingScanRun.savePath;
    
    sliceFolder = makeSliceFolderName(sliceIndex);
    angleFolder = makeAngleFolderName(angle);
    
    isScanPositionMosiac = false;
    name = makePositionName(xyPositionIndex, zPositionIndex,  isScanPositionMosiac);
    
    detectorFileName = makePositionFileName(name);
    
    data = load(makePath(path, sliceFolder, angleFolder, detectorFileName));
    
    detectorData_I0 = data.(Constants.Detector_Data_I0_Var_Name);    
    detectorData_I = data.(Constants.Detector_Data_I_Var_Name);
    
    % ratio so that: I0 / I = e^( \mu * x)
    detectorDataRatio = detectorData_I0 ./ detectorData_I;
end

