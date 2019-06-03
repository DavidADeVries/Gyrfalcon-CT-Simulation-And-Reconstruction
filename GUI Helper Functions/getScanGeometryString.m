function string = getScanGeometryString(simulationOrImagingScan, scanGeometry, errorMsg)

if isempty(scanGeometry)
    string = errorMsg;
else
    numSlices = num2str(length(simulationOrImagingScan.scan.slices));
    numAngles = num2str(length(simulationOrImagingScan.scan.scanAngles));
    
    angleString = [numAngles, ' Scan Angles [°] (', ')'];
    slicesString = [numSlices, ' Slices [mm] (', ')'];
    
    detectorDims = simulationOrImagingScan.detector.wholeDetectorDimensions;
    
    detectorSizeString = ['Detector Size: ', num2str(detectorDims(1)), 'x', num2str(detectorDims(2))];
    
    perAngleDims = simulationOrImagingScan.scan.perAngleTranslationResolution;
    
    perAngleString = ['Per Angle Translation Steps: ', num2str(perAngleDims(1)), 'x', num2str(perAngleDims(2))];
    
    string = {...
        scanGeometry.displayString,...
        scanGeometry.shortDescriptionString,...
        angleString,...
        slicesString,...
        detectorSizeString,...
        perAngleString};
end

end

