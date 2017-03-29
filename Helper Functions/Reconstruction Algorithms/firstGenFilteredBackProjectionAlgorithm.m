function [reconDataSet, sinogram, videoFrames] = firstGenFilteredBackProjectionAlgorithm(firstGenProjectionData, scanAngles, phantomSliceDimensions, phantomVoxelDimensionsInM, detectorWidthInM, filterType, applyRampFilter, applyBandlimiting, interpolationType)
% function [reconDataSet, sinogram, videoFrames] = firstGenFilteredBackProjectionAlgorithm(firstGenProjectionData, filterType, applyRampFilter, applyBandlimiting, interpolationType)

numSlices = length(firstGenProjectionData);

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
    
    centreOfDetectorsInM = calcCentreOfDetectors(numDetectors, detectorWidthInM);
    
    tDiscrete = centreOfDetectorsInM;
    
    interpsOfProjections = cell(1, numAngles);
    
    for j=1:numAngles
        % create piecewise 'interp' function for easy evaluation
        interpForAngle = interpolationType.createInterpForKnownVals(tDiscrete, projectionData(:,j)');
        
        interpsOfProjections{j} = interpForAngle;
    end
    
    sliceRecon = zeros(phantomSliceDimensions);
    
    
    % YOU'RE HERE!
    K = length(theta);
    
    projLength = dims(1);
    iShift = floor(projLength/2);
    
    
    
    d = (-(phantSize-1)/2):1:((phantSize-1)/2);
    
    
    
    for k = 1:K
        ang = theta(k);
        projValues = projectionData(:,k)';
        
        [x,y] = meshgrid(d,-d);
        
        t = x.*cosd(ang) + y.*sind(ang);
        
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

function centreOfDetectorsInM = calcCentreOfDetectors(numDetectors, detectorWidthInM)

end