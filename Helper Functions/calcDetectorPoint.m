function detectorPoint = calcDetectorPoint(detectorCornerCoords, partialPixelSteps, partialPixelResolution)
% detectorPoint = calcDetectorPoint(detectorCornerCoords, partialPixelRatios)

numDims = length(partialPixelSteps);

clockwisePosZ = detectorCornerCoords(1,:);
clockwiseNegZ = detectorCornerCoords(2,:);
counterClockwisePosZ = detectorCornerCoords(3,:);
counterClockwiseNegZ = detectorCornerCoords(4,:);

if numDims == 1 % 1D
    % find direction of 1D (either xy or z)
    zCoords = detectorCornerCoords(:,3);
    
    allZCoordsEqual = all(zCoords ./ zCoords(1));
    
    if allZCoordsEqual % must be 1D in xy
        xyPartialPixelResolution = partialPixelResolution;
        zPartialPixelResolution = 1;
        
        xyStep = partialPixelSteps(1);
        zStep = 1;
    else
        xyPartialPixelResolution = 1;
        zPartialPixelResolution = partialPixelResolution;
        
        xyStep = 1;
        zStep = partialPixelSteps(1);
    end
elseif numDims == 2 % 2D
    xyPartialPixelResolution = partialPixelResolution;
    zPartialPixelResolution = partialPixelResolution;
    
    xyStep = partialPixelSteps(1);
    zStep = partialPixelSteps(2);
else
    error('Undefined behaviour');
end
        
posZLength = norm(clockwisePosZ - counterClockwisePosZ);
negZLength = norm(clockwiseNegZ - counterClockwiseNegZ);
clockwiseHeight = norm(clockwisePosZ - clockwiseNegZ);
counterClockwiseHeight = norm(counterClockwisePosZ - counterClockwiseNegZ);

% no spacing in z
posZDelta = posZLength ./ (xyPartialPixelResolution);
negZDelta = negZLength ./ (xyPartialPixelResolution);

clockwiseDelta = clockwiseHeight ./ (zPartialPixelResolution);
counterClockwiseDelta = counterClockwiseHeight ./ (zPartialPixelResolution);

posZShift = (posZDelta / 2) + (zStep-1)*posZDelta;
negZShift = (negZDelta / 2) + (zStep-1)*negZDelta;

clockwiseShift = (clockwiseDelta / 2) + (xyStep-1)*clockwiseDelta;
counterClockwiseShift = (counterClockwiseDelta / 2) + (xyStep-1)*counterClockwiseDelta;

posZLinePoint = findPointAlongLineFromShift(clockwisePosZ, counterClockwisePosZ, posZShift);
negZLinePoint = findPointAlongLineFromShift(clockwiseNegZ, counterClockwiseNegZ, negZShift);

clockwiseLinePoint = findPointAlongLineFromShift(clockwisePosZ, clockwiseNegZ, clockwiseShift);
counterClockwiseLinePoint = findPointAlongLineFromShift(counterClockwisePosZ, counterClockwiseNegZ, counterClockwiseShift);

[zLineDeltas, zLinePoint] = createLineEquation(posZLinePoint, negZLinePoint);
[xyLineDeltas, xyLinePoint] = createLineEquation(clockwiseLinePoint, counterClockwiseLinePoint);

detectorPoint = findLineIntersectionPoint(zLineDeltas, zLinePoint, xyLineDeltas, xyLinePoint);

if isempty(detectorPoint)
    error('Error in detector point calculation');
end


end


function point = findPointAlongLineFromShift(linePoint1, linePoint2, shift)
    if shift == 0
        point = linePoint1;
    else
        lineDeltas = linePoint2 - linePoint1;
        
        deltasNorm = norm(lineDeltas);
        
        t = shift / deltasNorm;
        
        nonZeroDim = [];
        
        for i=1:length(lineDeltas)
            if lineDeltas(i) ~= 0
                nonZeroDim = i;
                break;
            end
        end
        
        if isempty(nonZeroDim)
            error('Invalid line to shift along');
        else            
            point = linePoint1 + t*lineDeltas;
        end
    end
end
