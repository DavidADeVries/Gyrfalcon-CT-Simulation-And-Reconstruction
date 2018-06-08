function [value_I0, value_I, isRejected] = interpolateFrameForIndex(x, y, targetLocationInM, targetPixelDimsInM, frame_I0, frame_I, rayRejectionMap, detectorPixelDimsInM)
%function [value, isRejected] = interpolateFrameForIndex(x, y, targetLocationInM, targetPixelDimsInM, frame, rayRejectionMap, detectorPixelDimsInM)

    xLeft = targetLocationInM(1) + (x-1)*targetPixelDimsInM(1);
    xRight = targetLocationInM(1) + (x)*targetPixelDimsInM(1);

    yTop = targetLocationInM(2) + (y)*targetPixelDimsInM(2);
    yBottom = targetLocationInM(2) + (y-1)*targetPixelDimsInM(2);

    xIndices = floor(xLeft / detectorPixelDimsInM(1))+1 : 1 : floor(xRight / detectorPixelDimsInM(1))+1;
    yIndices = floor(yBottom / detectorPixelDimsInM(2))+1 : 1 : floor(yTop / detectorPixelDimsInM(2))+1;
    
    xSideLengths = ones(1,length(xIndices))*detectorPixelDimsInM(1);    
    ySideLengths = ones(1,length(yIndices))*detectorPixelDimsInM(2);
    
    xSideLengths(1) = xSideLengths(1) - (xLeft - (xIndices(1)-1)*detectorPixelDimsInM(1));
    xSideLengths(end) = xSideLengths(end) - ((xIndices(end)*detectorPixelDimsInM(1)) - xRight);

    ySideLengths(1) = ySideLengths(1) - (yBottom - (yIndices(1)-1)*detectorPixelDimsInM(2));
    ySideLengths(end) = ySideLengths(end) - ((yIndices(end)*detectorPixelDimsInM(2)) - yTop);

    [xSide,ySide] = meshgrid(xSideLengths, ySideLengths);

    areas = xSide .* ySide;

    [colIndex,rowIndex] = meshgrid(xIndices, yIndices);
    
    frameIndices = sub2ind(size(frame_I), rowIndex, colIndex);
    
    pixelVals_I0 = frame_I0(frameIndices);
    pixelVals_I = frame_I(frameIndices);
    rayRejectVals = rayRejectionMap(frameIndices);
    
    isRejected = all(all(rayRejectVals));
    
    areas = areas .* (~rayRejectVals);

    totalArea = sum(sum(areas));

    areasNorm = areas ./ totalArea;

    value_I0 = sum(sum(pixelVals_I0 .* areasNorm));    
    value_I = sum(sum(pixelVals_I .* areasNorm));

end
