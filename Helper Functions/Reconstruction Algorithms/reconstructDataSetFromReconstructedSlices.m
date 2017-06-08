function reconDataSet = reconstructDataSetFromReconstructedSlices(reconSlices, sliceCentreLocationsInM, dataSetLocationInM, dataSetVoxelDimsInM, dataSetDims, reconSliceLocationInM, reconSliceVoxelDimsInM, reconSliceDims, interpolationType)
% reconDataSet = reconstructDataSetFromReconstructedSlices(reconSlices, sliceLocationsInM, dataSetLocationInM, dataSetVoxelDimsInM, dataSetDims, reconSliceLocationInM, reconSliceVoxelDimsInM, reconSliceDims, interpolationType)

% these are the coords of the centre of the reconDataSet voxels
% we will use these points as the coords to interpolate to from the given
% recon slices
[xVoxelPoints, yVoxelPoints, zVoxelPoints] = getVoxelCentreCoordinates(dataSetLocationInM, dataSetVoxelDimsInM, dataSetDims);

[xDataSetPoint, yDataSetPoint, zDataSetPoint] = meshgrid(xVoxelPoints, yVoxelPoints, zVoxelPoints);

% know need coords for the slice data

[xSlicePoints, ySlicePoints, ~] = getVoxelCentreAndEndEdgeCoordinates(reconSliceLocationInM, reconSliceVoxelDimsInM, reconSliceDims);

% slice locations give the centre of the recon'ed slice
% most slices are 2D (aka no z height, and so they're only at that centre
% slice value)
% But...for the sake of completeness, if we had thick slices (aka like in
% helical scanners) or cone beam imaging, we want to be apply to combine
% multiple slices, and so this would give the shifts, so that from the
% centre z coord, the z coords of all the voxels in the thick slice could
% be found

sliceDelZ = reconSliceVoxelDimsInM(3); %should be 0 for 2D slices
sliceNumZ = reconSliceDims(3); % should be 1 for 2D slices

delZDiv2 = sliceDelZ / 2;

endPoint = (sliceNumZ / 2)*sliceDelZ - delZDiv2;

zSliceShiftsFromCentre = endPoint:-sliceDelZ:-endPoint;

% compile all the slice data and accompanying z vals

numSlices = length(reconSlices);

zSlicePoints = zeros(1, numSlices * sliceNumZ);
sliceData = zeros(reconSliceDims(2), reconSliceDims(1), numSlices * sliceNumZ);

if numSlices < 1
    reconDataSet = NaN .* ones(dataSetDims); % no recon possible
else
    for i=1:numSlices
        reconSliceData = reconSlices{i};
        
        zVals = sliceCentreLocationsInM(i) + zSliceShiftsFromCentre;
        
        zSlicePoints((i-1)*sliceNumZ + 1 : i*sliceNumZ) = zVals;
        sliceData(:,:,(i-1)*sliceNumZ + 1 : i*sliceNumZ) = reconSliceData;
    end
    
    % some "thick" slices may overlap, so we need to sort this!
    [sortedZVals, sortedI] = sort(zSlicePoints,'descend');
    
    sortedSliceData = sliceData(:,:,sortedI);
    
    % if any z-val is represented multiply times, we should fix that
    prevVal = NaN;
    numDuplicates = 1;
    sliceSum = zeros(reconSliceDims(2), reconSliceDims(1)); % we'll average the slice values here!    
    
    endVal = length(sortedZVals);
    
    i = 1;
    
    while i <= endVal
        curVal = sortedZVals(i);
        
        valsEqual = equalWithinBound(prevVal, curVal);
        
        if valsEqual
            numDuplicates = numDuplicates + 1;
            sliceSum = sliceSum + sortedSliceData(:,:,i);
            
            % clear out the duplicated values
            sortedZVals(i) = [];
            sortedSliceData(:,:,i) = []; % don't worry, we've got the sum of slices to average stored!
            
            endVal = endVal - 1; %the length of the z vals just became 1 shorter
            
            % no need to increment i, since we just cleared out the values
            % at i
        elseif ~valsEqual && numDuplicates > 1
            sortedSliceData(:,:,i-1) = sliceSum ./ numDuplicates; %take the average
            numDuplicates = 1; %reset
            
            % continue checking along
            prevVal = curVal;
            sliceSum = sortedSliceData(:,:,i);
            i = i + 1;
        else % no duplicates, just checking along            
            prevVal = curVal;
            sliceSum = sortedSliceData(:,:,i);
            i = i + 1;
        end
        
    end
    
    % buffer out points of grid, such that the edge points are not the
    % centre of the outermost voxels, but the edge of those voxels
    
    zSlicePoints = [sortedZVals(1) + sliceDelZ/2, sortedZVals, sortedZVals(end) - sliceDelZ/2];
    
    [knownX, knownY, knownZ] = meshgrid(xSlicePoints, ySlicePoints, zSlicePoints);
        
    bufferedSlices = padarray(sortedSliceData, [1, 1, 1], 'replicate');
    
    knownVals = bufferedSlices;
    
    valForPointsBeyondRange = NaN;
    
    reconDataSet = interp3(...
        knownX, knownY, knownZ, knownVals,...
        xDataSetPoint, yDataSetPoint, zDataSetPoint,...
        interpolationType.getMatlabString(), valForPointsBeyondRange);
end


end

