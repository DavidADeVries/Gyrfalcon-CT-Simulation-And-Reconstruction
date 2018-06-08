function [projectionData_I0, projectionData_I, rayRejectionMaps, tigreGeometry, tigreAnglesInRadians] = getValuesForTigreReconstruction(recon, simulationOrImagingScanRun, projectionData_I0, projectionData_I, rayRejectionMaps)
%[projectionData_I0, projectionData_I, rayRejectionMaps, tigreGeometry, tigreAnglesInRadians] = getValuesForTigreReconstruction(recon, simulationOrImagingScanRun, projectionData_I0, projectionData_I, rayRejectionMaps)

[tigreGeometry, tigreAnglesInRadians] = convertGyrfalconImagingScanAndReconstructionToTigreGeometry(...
    simulationOrImagingScanRun.getImagingSetup(), recon);

% TIGRE needs projections in single precision
projectionData_I0 = single(projectionData_I0);
projectionData_I = single(projectionData_I);

rayRejectionMaps = single(rayRejectionMaps);

end

