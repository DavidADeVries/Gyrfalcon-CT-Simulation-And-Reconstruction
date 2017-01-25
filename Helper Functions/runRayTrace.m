function [rawDetectorValue] = runRayTrace(axesHandle,pointSourceCoords, sourceEndBoxCoords, pointDetectorCoords, phantomData, voxelDimsInM, phantomLocationInM, beamCharacterization, displayDetectorRayTrace)
%function rawDetectorValue = runRayTrace(pointSourceCoords, sourceEndBoxCoords, pointDetectorCoords, phantomData, voxelDimsInM, phantomLocationInM, beamCharacterization, displayDetectorRayTrace)
% run a ray trave from the source point to detector point as long as the
% detector point is within the source end box.
% the beam described by the beam characterization passes through the
% phantom data, being attenuated as expected.

linePhantomIntersectionPoints = [];

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

% display ray trace if needed
if displayDetectorRayTrace
    % plot ray    
    lineCoords = [pointSourceCoords', pointDetectorCoords'];
    
    handle = line(...
        lineCoords(1,:), lineCoords(2,:), lineCoords(3,:),...
        'Color', Constants.Ray_Trace_Colour,...
        'Parent', axesHandle);
    
    handles = {handle};
    
    % plot any intersection points, if any exist
    if ~isempty(linePhantomIntersectionPoints)
        scatterHandle = scatter3(...
            linePhantomIntersectionPoints(:,1),...
            linePhantomIntersectionPoints(:,2),...
            linePhantomIntersectionPoints(:,3),...
            'MarkerFaceColor', Constants.Ray_Trace_Point_Colour,...
            'MarkerEdgeColor', Constants.Ray_Trace_Point_Colour,...
            'Marker', '*',...
            'Parent', axesHandle);
            
        handles = [handles, {scatterHandle}];
    end
    
    pause(0.000001);
    deleteHandles(handles);
end

end
