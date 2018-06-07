function [projections, rayRejectionMaps, tigreGeometry, tigreAnglesInRadians] = getValuesForTigreReconstruction(recon, simulationOrImagingScanRun, projections, rayRejectionMaps)
%[projections, rayRejectionMaps, tigreGeometry, tigreAnglesInRadians] = getValuesForTigreReconstruction(recon, simulationOrImagingScanRun, projectionData, rayRejectionMaps)

[tigreGeometry, tigreAnglesInRadians] = convertGyrfalconImagingScanAndReconstructionToTigreGeometry(...
    simulationOrImagingScanRun.getImagingSetup(), recon);

% TIGRE needs projections in single precision
projections = single(projections);
rayRejectionMaps = single(rayRejectionMaps);

end

