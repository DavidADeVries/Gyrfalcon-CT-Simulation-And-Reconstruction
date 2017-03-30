function [reconDataSet, sinograms, videosFrames] = firstGenFilteredBackProjectionAlgorithm(firstGenProjectionData, scanAngles, phantomSliceDimensions, phantomVoxelDimensionsInM, phantomLocationInM, detectorWidthInM, filterType, applyRampFilter, applyBandlimiting, interpolationType)
% function [reconDataSet, sinograms, videosFrames] = firstGenFilteredBackProjectionAlgorithm(firstGenProjectionData, filterType, applyRampFilter, applyBandlimiting, interpolationType)

numSlices = length(firstGenProjectionData);

reconDataSet = cell(1, numSlices);
sinograms = cell(1, numSlices);
videosFrames = cell(1, numSlices);

dims = size(numSlices{1});

numAngles = dims(2); %num cols
numDetectors = dims(1); %num rows

for i=1:numSlices
    projectionData = firstGenProjectionData{i}; %each column contains on angle of projection data (aka sinogram!)
    
    % filter projection data
    for j=1:numAngles
        projectValues = projectionData(:,j)';
        
        filteredProjectionData = filterProjectionValuesRedo(projectValues, filterType, applyRampFilter, applyBandlimiting, detectorWidthInM);
        
        projectionData(:,j) = filteredProjectionData';
    end
    
    centreOfDetectorsPlusEdgeInM = calcCentreOfDetectorsPlusEdge(numDetectors, detectorWidthInM);
    
    tDiscrete = centreOfDetectorsInM;
    
    interpsOfProjections = cell(1, numAngles);
    
    for j=1:numAngles
        % create piecewise 'interp' function for easy evaluation
        projData = projectionData(:,j)';
        projData = [0, projData, 0]; %specific "0" signal outside of detector
        
        interpForAngle = interpolationType.createInterpForKnownVals(tDiscrete, projData);
        
        interpsOfProjections{j} = interpForAngle;
    end
    
    sliceRecon = zeros(phantomSliceDimensions);
    
    
    % YOU'RE HERE!
    
    xIndices = 1:1:phantomSliceDimensions(1);
    yIndices = 1:1:phantomSliceDimensions(2);   
    
    for k = 1:numAngles
        ang = scanAngles(k);
        projValuesInterp = interpsOfProjections{j};
        
        % create grid of all x,y index combinations
        [xxIndices, yyIndices] = meshgrid(xIndices,yIndices);
        
        % find coresponding (x,y) values relative to (0,0)
        % phantomLocation gives top left corner in xy plane
        xxVals = phantomLocationInM(1) + (xxIndices * phantomVoxelDimensionsInM(1)) + phantomVoxelDimensionsInM(1)/2;
        yyVals = phantomLocationInM(2) - (yyIndices * phantomVoxelDimensionsInM(2)) - phantomVoxelDimensionsInM(2)/2;
        
        t = xxVals.*cosd(ang) + yyVals.*sind(ang);
        
        i = t + 1 + ((projLength-1)/2);
        iLow = floor(i);
        iHigh = ceil(i);
        
        iX = x + 1 + ((phantSize-1)/2);
        iY = y + 1 + ((phantSize-1)/2);
        
        validCoord = ...
            iLow < projLength & iHigh < projLength &...
            iLow > 0 & iHigh > 0 & iX > 0 &...
            iX <= phantSize & iY > 0 & iY <= phantSize;
        
        iLow(~validCoord) = 1;
        iHigh(~validCoord) = 1;
        iX(~validCoord) = 1;
        iY(~validCoord) = 1;
        
        lowHighEq = iLow == iHigh;
        
        dims = size(validCoord);
        len = dims(1)*dims(2);
        
        lowVals = reshape(projValues(reshape(iLow,1,len)),dims(1),dims(2));
        highVals = reshape(projValues(reshape(iHigh,1,len)),dims(1),dims(2));
        yVals = reshape(projValues(reshape(iX,1,len)),dims(1),dims(2));
        xVals = reshape(projValues(reshape(iY,1,len)),dims(1),dims(2));
        
        % get vals not requiring interpolation
        eqVals = iHigh == iLow;
        
        reconTemp1 = sliceRecon + ((validCoord & eqVals) .* lowVals);
        
        % get vals requiring interpolation
        riseVals = highVals - lowVals;
        runVals = iHigh - iLow;
        
        reconTemp2 = sliceRecon + (~eqVals & validCoord) .* (lowVals + (i - iLow).*(riseVals./runVals));
        
        sliceRecon(validCoord & eqVals) = reconTemp1(validCoord & eqVals);
        sliceRecon(validCoord & ~eqVals) = reconTemp2(validCoord & ~eqVals);
        
    end
    
    sliceRecon = sliceRecon .* (pi/K);
    
end

% specifics the centre of detector and the edge
function centreOfDetectorsPlusEdgeInM = calcCentreOfDetectorsPlusEdge(numDetectors, detectorWidthInM)
    
    bound = ((numDetectors - 1) / 2) * detectorWidthInM;
    
    centreOfDetectorsInM = -bound:detectorWidthInM:bound;
    
    edge = (numDetectors / 2) * detectorWidthInM;
    
    centterOfDetectorsPlusEdgeInM
end