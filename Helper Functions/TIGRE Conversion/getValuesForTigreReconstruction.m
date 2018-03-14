function [projections, rayRejectionMaps, tigreGeometry, tigreAnglesInRadians] = getValuesForTigreReconstruction(recon, simulationOrImagingScanRun, projections, rayRejectionMaps)
%[projections, rayRejectionMaps, tigreGeometry, tigreAnglesInRadians] = getValuesForTigreReconstruction(recon, simulationOrImagingScanRun, projectionData, rayRejectionMaps)

[tigreGeometry, tigreAnglesInRadians] = convertGyrfalconImagingScanAndReconstructionToTigreGeometry(...
    simulationOrImagingScanRun.getImagingSetup(), recon);

simulationOrImagingScanRun.loadData(simulationOrImagingScanRun.savePath);

% TIGRE needs projections in single precision
projections = single(projections);
rayRejectionMaps = single(rayRejectionMaps);

end

