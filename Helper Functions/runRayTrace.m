function [handles,rawDetectorValue] = runRayTrace(axesHandle,pointSourceCoords, sourceEndBoxCoords, pointDetectorCoords, phantomData, voxelDimsInM, phantomLocationInM, beamCharacterization)
%function rawDetectorValue = runRayTrace(pointSourceCoords, sourceEndBoxCoords, pointDetectorCoords, phantomData, voxelDimsInM, phantomLocationInM, beamCharacterization)
% run a ray trave from the source point to detector point as long as the
% detector point is within the source end box.
% the beam described by the beam characterization passes through the
% phantom data, being attenuated as expected.

plotCoords = [pointSourceCoords', pointDetectorCoords'];

handle = line(plotCoords(1,:),plotCoords(2,:),plotCoords(3,:),'Color','m','Parent',axesHandle);
handles = {handle};

if pointIsWithinObject(pointDetectorCoords, sourceEndBoxCoords)
    % describe line in 3 space
    [deltas, point] = createLineEquation(pointSourceCoords, pointDetectorCoords);
        
    linePhantomIntersectionPoints = findLinePhantomIntersections(...
        deltas,...
        point,...
        pointSourceCoords,...
        phantomLocationInM,...
        voxelDimsInM,...
        phantomData);
        
    %these arrays will hold mu(x) values and x values
    %first values are those that will be traversed first by the beam
    dims = size(linePhantomIntersectionPoints);
    numIntersections = dims(1);
    
    for i=1:numIntersections
        point = linePhantomIntersectionPoints(i,:);
        
        handle = plot3(point(1),point(2),point(3),'*','Color','w','Parent',axesHandle);
        
        handles = [handles,{handle}];
    end
    
    if numIntersections <= 1 % no absorption
        rawDetectorValue = beamCharacterization.intensity;
    else
        absorptionVals = zeros(numIntersections-1,1);
        absorptionValsDistance = zeros(numIntersections-1,1);
        
        for i=1:numIntersections-1
            startPoint = linePhantomIntersectionPoints(i,:);
            endPoint = linePhantomIntersectionPoints(i+1,:);
            
            absorptionVals(i) = phantomAbsorptionValue(startPoint, endPoint,phantomData, voxelDimsInM, phantomLocationInM);
            absorptionValsDistance(i) = norm(endPoint-startPoint);
        end
        
        rawDetectorValue = beamCharacterization.modelAbsorption(absorptionVals, absorptionValsDistance);
    end
else
    rawDetectorValue = 0; %no rays hit it
end

end

