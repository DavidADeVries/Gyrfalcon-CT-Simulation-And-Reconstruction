function rawDetectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords, phantomLocationInM, phantomDims, voxelDimsInM, phantomData, startingIntensity)
% rawDetectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords, phantomLocationInM, phantomDims, voxelDimsInM, phantomData, startingIntensity)

rawDetectorValue = [];

bounds1 = [phantomLocationInM(1), phantomLocationInM(2:3) - voxelDimsInM(2:3).*phantomDims(2:3)];
bounds2 = [phantomLocationInM(1)+voxelDimsInM(1)*phantomDims(1), phantomLocationInM(2:3)];

[deltas, point] = createLineEquation(pointSourceCoords, pointDetectorCoords);

tMinsTemp = (bounds1 - point) ./ deltas;
tMaxsTemp = (bounds2 - point) ./ deltas;

tMins = tMinsTemp;
tMaxs = tMaxsTemp;

negDeltas = deltas < 0;

tMins(negDeltas) = tMaxsTemp(negDeltas);
tMaxs(negDeltas) = tMinsTemp(negDeltas);

tMin = tMins(1);
tMax = tMaxs(1);

if (tMin > tMaxs(2)) || (tMins(2) > tMax)
    rawDetectorValue = startingIntensity; %missed
end

if tMins(2) > tMin
    tMin = tMins(2);
end
if tMaxs(2) < tMax
    tMax = tMaxs(2);
end

if (tMin > tMaxs(3)) || (tMins(3) > tMax)
    rawDetectorValue = startingIntensity; %missed
end

if tMins(3) > tMin
    tMin = tMins(3);
end
if tMaxs(3) < tMax
    tMax = tMaxs(3);
end

if isempty(rawDetectorValue)
    startingPoint = point + tMin .* deltas;
    endPoint = point + tMax .* deltas;
    
    % have starting point and end point, now will find which voxels and with
    % what distances across each voxel the ray travels
    
    startingPoint = startingPoint - phantomLocationInM; %shift so corner is at origin
    endingPoint = endPoint - phantomLocationInM;
    
    deltas = endingPoint - startingPoint;
    deltaSigns = deltas ./ abs(deltas);
    
    isDelta0 = deltas==0;
    deltaSigns(isDelta0) = 0;
    
    currentPoint = startingPoint;
    
    radonSum = 0;
    
    unroundedVals = startingPoint ./ voxelDimsInM;
    unroundedVals = [1 -1 -1].*unroundedVals;
    
    % first need to kill off any rounding errors
    unroundedVals = round(unroundedVals, Constants.Round_Off_Level);
    
    % no round to get lattice/index values
    floorVals = floor(unroundedVals);
    ceilVals = ceil(unroundedVals);
    
    isDeltaNeg = deltas < 0;
    
    selectCeiling = ~isDeltaNeg;
    selectCeiling(1) = ~selectCeiling(1);
    
    lastLattices =  selectCeiling.* ceilVals + ~selectCeiling .* floorVals;
    
    % useful conversion to go from the lastLattice points to the index
    latticeToIndex = isDeltaNeg;
    latticeToIndex(1) = ~latticeToIndex(1);
    
    % useful add/sub to get next lattice point
    nextPointFactors = -1 * deltaSigns;
    nextPointFactors(1) = deltaSigns(1);
    
    while any(abs(currentPoint - endingPoint) > Constants.Round_Off_Error_Bound)
        currentIndices = lastLattices + latticeToIndex;
        
        try
        attenuation = phantomData(currentIndices(2), currentIndices(1), currentIndices(3));
        catch e
            disp(e);
        end
        
        nextLattices = lastLattices + nextPointFactors;
        
        nextPoints = [1, -1, -1] .* ((nextLattices)) .* voxelDimsInM; % finds next intersection point with part of the voxel grids for x,y,z
                
        tValsNeeded = (nextPoints - currentPoint) ./ deltas; % finds the t needed to reach these
        tValsNeeded(isDelta0) = Inf;
        
        if tValsNeeded(1) <= tValsNeeded(2) && tValsNeeded(1) <= tValsNeeded(3) % choose the lowest t
            t = tValsNeeded(1);
            lastLattices(1) = nextLattices(1);
        end
        
        if tValsNeeded(2) <= tValsNeeded(1) && tValsNeeded(2) <= tValsNeeded(3)
            t = tValsNeeded(2);
            lastLattices(2) = nextLattices(2);
        end
        
        if tValsNeeded(3) <= tValsNeeded(1) && tValsNeeded(3) <= tValsNeeded(2)
            t = tValsNeeded(3);
            lastLattices(3) = nextLattices(3);
        end
        
        shift = t.*deltas;
        
        currentPoint = currentPoint + shift;
        
        radonSum = radonSum + norm(shift) .* attenuation;
    end
    
    rawDetectorValue = startingIntensity.*exp(-radonSum);
end

end

