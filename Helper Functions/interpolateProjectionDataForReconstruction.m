function [interpolatedData_I0, interpolatedData_I, interpolatedRayRejectionMap] = interpolateProjectionDataForReconstruction(detectorData_I0, detectorData_I, rayRejectionMap, useRayRejection, origPixelDimsInM, targetDetectorDims, targetPixelDimsInM)
%[interpolatedImage, interpolatedRayRejectionMap] = interpolateProjectionDataForReconstruction(projectionImage, rayRejectionMap, useRayRejection, origPixelDimsInM, targetDetectorDims, targetPixelDimsInM)

imageDims = size(detectorData_I0);
origDetectorSize = [imageDims(2), imageDims(1)];

origDimsInM = origDetectorSize .* origPixelDimsInM;

targetDimsInM = targetDetectorDims .* targetPixelDimsInM;
targetLocationInM = (origDimsInM - targetDimsInM) ./ 2; % centre it

xVals = 1:targetDetectorDims(1);
yVals = 1:targetDetectorDims(2);
[xVals, yVals] = meshgrid(xVals, yVals);

if ~useRayRejection
    rayRejectionMap = false & zeros(size(rayRejectionMap));
end

fn = @(x,y) interpolateFrameForIndex_mex(...
    x, y,...
    targetLocationInM, targetPixelDimsInM,...
    detectorData_I0, detectorData_I, rayRejectionMap, origPixelDimsInM);

[interpolatedData_I0, interpolatedData_I, interpolatedRayRejectionMap] ....
    = arrayfun(fn, xVals, yVals);

end