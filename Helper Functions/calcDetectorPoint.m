function detectorPoint = calcDetectorPoint(detectorCornerCoords, partialPixelSteps, partialPixelResolution)
% detectorPoint = calcDetectorPoint(detectorCornerCoords, partialPixelRatios)

numDims = length(partialPixelSteps);

clockwiseXY = detectorCornerCoords(1,1:2);
counterClockwiseXY = detectorCornerCoords(3,1:2);

posZ = detectorCornerCoords(1,3);
negZ = detectorCornerCoords(2,3);

if numDims == 1 % 1D
    % find direction of 1D (either xy or z)
    zCoords = detectorCornerCoords(:,3);
    
    allZCoordsEqual = all(zCoords ./ zCoords(1));
    
    if allZCoordsEqual % must be 1D in xy
        
        delta = clockwiseXY - counterClockwiseXY;
        
        deltaForCounterClockwise = delta .* (partialPixelSteps(1)-1) ./ partialPixelResolution;
        deltaForClockwise = delta .* (partialPixelSteps(1)) ./ partialPixelResolution;
        
        detectorClockwiseXY = counterClockwiseXY + deltaForClockwise;
        detectorCounterClockwiseXY = counterClockwiseXY + deltaForCounterClockwise;
        
        detectorCoords = [...
            [detectorClockwiseXY, posZ];...
            [detectorClockwiseXY, negZ];...
            [detectorCounterClockwiseXY, posZ];...
            [detectorCounterClockwiseXY, negZ]];            
    else % must be 1D in z
        delta = posZ - negZ;
        
        deltaForPosZ = delta .* (partialPixelSteps(1)) ./ partialPixelResolution;
        deltaForNegZ = delta .* (partialPixelSteps(1)-1) ./ partialPixelResolution;
        
        detectorPosZ = negZ + deltaForPosZ;
        detectorNegZ = negZ + deltaForNegZ;
        
        detectorCoords = [...
            [clockwiseXY, detectorPosZ];...
            [clockwiseXY, detectorNegZ];...
            [counterClockwiseXY, detectorPosZ];...
            [counterClockwiseXY, detectorNegZ]];
    end
    
    detectorPoint = centreOfQuadrangle(detectorCoords);
    
elseif numDims == 2 % 2D
    
else
    error('Undefined behaviour');
end

end

