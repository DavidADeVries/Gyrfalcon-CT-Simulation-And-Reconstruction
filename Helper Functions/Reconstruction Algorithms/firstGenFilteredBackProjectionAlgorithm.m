function [reconDataSet, sinograms, videosFrames] = firstGenFilteredBackProjectionAlgorithm(...
    firstGenProjectionData, photonBeam,...
    scanAngles, sourceStartingLocationInM, reconSliceDimensions, reconSliceVoxelDimsInM, reconSliceLocationInM, detectorWidthInM,...
    filterType, applyRampFilter, applyBandlimiting, interpolationType)
% function [reconDataSet, sinograms, videosFrames] = firstGenFilteredBackProjectionAlgorithm(firstGenProjectionData, scanAngles, sourceStartingLocationInM, phantomSliceDimensions, phantomVoxelDimensionsInM, phantomLocationInM, detectorWidthInM, filterType, applyRampFilter, applyBandlimiting, interpolationType)

% the projection data we have is the final intensity value measured by the
% detector pixel (I'). This is modelled using linear attenuation:
% I' = I * exp(-sum(mu * x))
% However, FBP works upon the Radon transform which is defined by:
% R = sum(mu * x)
% The solution is clear. We get the original intensity, I, from the
% photonBeam used, and use logarithms to get back to sum(mu * x)
% sum(mu * x) = - ln(I'/I)
% NOTE: ln is reallog in MATLAB

originalIntensity = photonBeam.rawIntensity();

numSlices = length(firstGenProjectionData);

radonProjectionData = cell(size(firstGenProjectionData));

for i=1:numSlices
    sliceData = firstGenProjectionData{i};
    
    radonProjectionData{i} = - reallog(sliceData ./ originalIntensity);
end    
    

% set angles to match Kak and Slaney convention
[startingAngle,~] = cart2pol(sourceStartingLocationInM(1), sourceStartingLocationInM(2));

thetas = startingAngle + (360 - scanAngles);

% output variables set
reconDataSet = cell(1, numSlices);
sinograms = cell(1, numSlices);
videosFrames = cell(1, numSlices);

dims = size(firstGenProjectionData{1});

numAngles = dims(2); %num cols
numDetectors = dims(1); %num rows

for i=1:numSlices
    projectionData = radonProjectionData{i}; %each column contains on angle of projection data (aka sinogram!)
    
    %filter projection data
    for j=1:numAngles
        projectValues = projectionData(:,j);
        
        filteredProjectionData = filterProjectionValuesRedo(projectValues, filterType, applyRampFilter, applyBandlimiting, detectorWidthInM);
        
        projectionData(:,j) = filteredProjectionData';
    end
    
    centreOfDetectorsPlusEdgeInM = calcCentreOfDetectorsPlusEdge(numDetectors, detectorWidthInM);
    
    tDiscrete = centreOfDetectorsPlusEdgeInM;
        
    interpsOfProjections = cell(1, numAngles);
    
    for j=1:numAngles
        % create piecewise 'interp' function for easy evaluation
        projData = [projectionData(1,j) projectionData(:,j)' projectionData(end,j)]; %specific edge of detector values
               
        zeroBeyondBounds = true;
        interpForAngle = interpolationType.createInterpForKnownVals(tDiscrete, projData, zeroBeyondBounds);
        
        interpsOfProjections{j} = interpForAngle;
    end
    
    sliceRecon = zeros(reconSliceDimensions);
    frames = zeros([reconSliceDimensions numAngles]);
    
    xIndices = 1:1:reconSliceDimensions(1);
    yIndices = 1:1:reconSliceDimensions(2);  

    % create grid of all x,y index combinations
    [xxIndices, yyIndices] = meshgrid(xIndices, yIndices);
    
    % find coresponding (x,y) values relative to (0,0)
    % phantomLocation gives top left corner in xy plane
    xxVals = reconSliceLocationInM(1) + ((xxIndices-1) * reconSliceVoxelDimsInM(1)) + reconSliceVoxelDimsInM(1)/2;
    yyVals = reconSliceLocationInM(2) - ((yyIndices-1) * reconSliceVoxelDimsInM(2)) - reconSliceVoxelDimsInM(2)/2;
             
    figure(2);

    for k = 1:numAngles
        ang = thetas(k);
        projValuesInterp = interpsOfProjections{k};
        
        t = xxVals.*cosd(ang) + yyVals.*sind(ang);
                
        projValueAtT = ppval(projValuesInterp, t);
        
        sliceRecon = sliceRecon + projValueAtT;
        
        imshow(sliceRecon,[],'InitialMagnification','fit');
        drawnow;

        frames(:,:,k) = sliceRecon;
    end
    
    sliceRecon = sliceRecon .* (pi/numAngles);
    
    % set outputs
    reconDataSet{i} = sliceRecon;
    sinograms{i} = projectionData;
    videosFrames{i} = frames;
end

end

% specifics the centre of detector and the edge
function centreOfDetectorsPlusEdgeInM = calcCentreOfDetectorsPlusEdge(numDetectors, detectorWidthInM)
    
    bound = ((numDetectors - 1) / 2) * detectorWidthInM;
    
    centreOfDetectorsInM = -bound:detectorWidthInM:bound;
    
    edge = (numDetectors / 2) * detectorWidthInM;
    
    centreOfDetectorsPlusEdgeInM = [-edge centreOfDetectorsInM edge];
end