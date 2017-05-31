function rawDetectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords, phantomLocationInM, phantomDims, voxelDimsInM, phantomData, startingIntensity)
% rawDetectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords, phantomLocationInM, phantomDims, voxelDimsInM, phantomData, startingIntensity)

bounds1 = [phantomLocationInM(1), phantomLocationInM(2:3) - voxelDimsInM(2:3).*phantomDims(2:3)];
bounds2 = [phantomLocationInM(1)+voxelDimsInM(1)*phantomDims(1), phantomLocationInM(2:3)];

[deltas, point] = createLineEquation(pointSourceCoords, pointDetectorCoords);

invDeltas = 1 ./ deltas;

tMinsTemp = (bounds1 - point) .* invDeltas;
tMaxsTemp = (bounds2 - point) .* invDeltas;

tMins = tMinsTemp;
tMaxs = tMaxsTemp;

negDeltas = deltas < 0;

tMins(negDeltas) = tMaxsTemp(negDeltas);
tMaxs(negDeltas) = tMinsTemp(negDeltas);

tMin = -Inf;
tMax = Inf;

if deltas(1) ~= 0
    if tMins(1) > tMin
        tMin = tMins(1);
    end
    if tMaxs(1) < tMax
        tMax = tMaxs(1);
    end
end

if deltas(2) ~= 0
    if tMins(2) > tMin
        tMin = tMins(2);
    end
    if tMaxs(2) < tMax
        tMax = tMaxs(2);
    end
end

if deltas(3) ~= 0
    if tMins(3) > tMin
        tMin = tMins(3);
    end
    if tMaxs(3) < tMax
        tMax = tMaxs(3);
    end
end

if tMax < tMin
    rawDetectorValue = startingIntensity;
else % run through the voxels
    startingPoint = point + tMin .* deltas;
    endPoint = point + tMax .* deltas;
    
    % have starting point and end point, now will find which voxels and with
    % what distances across each voxel the ray travels
    
    startingPoint = startingPoint - phantomLocationInM; %shift so corner is at origin
    endingPoint = endPoint - phantomLocationInM;
    
    deltas = endingPoint - startingPoint;
    invDeltas = 1 ./ deltas;
    deltaSigns = -1*(deltas < 0) + (deltas > 0);
    
    isDelta0 = deltas==0;
    deltaSigns(isDelta0) = 0;
    
    currentPoint = startingPoint;
    
    radonSum = 0;
    
    isDeltaNeg = deltas < 0;
    
    lastLattices = getLattices(startingPoint, voxelDimsInM, isDeltaNeg);
    endingLattices = getLattices(endingPoint, voxelDimsInM, isDeltaNeg);
        
    % useful conversion to go from the lastLattice points to the index
    latticeToIndex = isDeltaNeg;
    latticeToIndex(1) = ~latticeToIndex(1);
    
    % useful add/sub to get next lattice point
    nextPointFactors = -1 * deltaSigns;
    nextPointFactors(1) = deltaSigns(1);
    
    
    while ~all(lastLattices == endingLattices)%any(abs(currentPoint - endingPoint) > Constants.Round_Off_Error_Bound)
        currentIndices = lastLattices + latticeToIndex;
        
        attenuation = phantomData(currentIndices(2), currentIndices(1), currentIndices(3));
        
        nextLattices = lastLattices + nextPointFactors;
        
        nextPoints = [1, -1, -1] .* ((nextLattices)) .* voxelDimsInM; % finds next intersection point with part of the voxel grids for x,y,z
                
        tValsNeeded = (nextPoints - currentPoint) .* invDeltas; % finds the t needed to reach these
        tValsNeeded(isDelta0) = Inf;
        tValsNeeded = round(tValsNeeded, Constants.Round_Off_Level);
        
        onLattice = [false false false];
        
        if tValsNeeded(1) <= tValsNeeded(2) && tValsNeeded(1) <= tValsNeeded(3) % choose the lowest t
            t = tValsNeeded(1);
            lastLattices(1) = nextLattices(1);
            onLattice(1) = true;
        end
        
        if tValsNeeded(2) <= tValsNeeded(1) && tValsNeeded(2) <= tValsNeeded(3)
            t = tValsNeeded(2);
            lastLattices(2) = nextLattices(2);
            onLattice(2) = true;
        end
        
        if tValsNeeded(3) <= tValsNeeded(1) && tValsNeeded(3) <= tValsNeeded(2)
            t = tValsNeeded(3);
            lastLattices(3) = nextLattices(3);
            onLattice(3) = true;
        end
        
        shift = t.*deltas;
        
        currentPoint = currentPoint + shift; 
        onLatticePoints = [1, -1, -1] .* lastLattices .* voxelDimsInM;
        currentPoint(onLattice) = onLatticePoints(onLattice); % reduces compounding rounding errors as much as possible
        
        radonSum = radonSum + norm(shift) .* attenuation;
    end
    
    rawDetectorValue = startingIntensity.*exp(-radonSum);
end

end

% ** HELPER FUNCTIONS **

function lattices = getLattices(point, voxelDimsInM, isDeltaNeg)

    unroundedVals = point ./ voxelDimsInM;
    
    unroundedVals = [1 -1 -1].*unroundedVals;
        
    unroundedVals(voxelDimsInM == 0) = 1; % needs to be 1, since no change occurs, needs index to be 1
    
    % first need to kill off any rounding errors
    unroundedVals = round(unroundedVals, Constants.Round_Off_Level);
    
    % no round to get lattice/index values
    floorVals = floor(unroundedVals);
    ceilVals = ceil(unroundedVals);
    
    
    selectCeiling = ~isDeltaNeg;
    selectCeiling(1) = ~selectCeiling(1);
    
    lattices =  selectCeiling.* ceilVals + ~selectCeiling .* floorVals;
end