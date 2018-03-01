function [projections, tigreGeometry, tigreAnglesInRadians] = getValuesForTigreReconstruction(recon, simulationOrImagingScanRun)
%[projections, tigreGeometry, tigreAnglesInRadians] = getValuesForTigreReconstruction(recon, simulationOrImagingScanRun)

[tigreGeometry, tigreAnglesInRadians] = convertGyrfalconImagingScanAndReconstructionToTigreGeometry(...
    simulationOrImagingScanRun.getImagingSetup(), recon);

simulationOrImagingScanRun.loadData(simulationOrImagingScanRun.savePath);

% set up projections
imageDims = fliplr(simulationOrImagingScanRun.getImagingSetup().detector.wholeDetectorDimensions);
anglesInDeg = simulationOrImagingScanRun.getImagingSetup().scan.getScanAnglesInDegrees();

numAngles = length(anglesInDeg);

projections = zeros(imageDims(1),imageDims(2),numAngles);

for i=1:numAngles
    projections(:,:,i) = simulationOrImagingScanRun.sliceData{1,1}.angleData{1,i}.positionData{1,1}.detectorData;
end

% convert projection data to cleaned-up Radon transform data
projections = simulationOrImagingScanRun.getImagingSetup().convertProjectionDataToRadonSumData(projections);
projections = correctRadonSumData(projections);

% TIGRE needs projections in single precision
projections = single(projections);

end

