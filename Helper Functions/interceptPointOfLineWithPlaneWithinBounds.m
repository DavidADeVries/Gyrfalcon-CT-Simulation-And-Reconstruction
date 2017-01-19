function interceptPoint = interceptPointOfLineWithPlaneWithinBounds(linePoint, lineDeltas, planeVal, planeDim, planeBounds)
% interceptPoint = interceptPointOfLineWithPlane(linePoint, lineDeltas, planeVal, planeDim, planeBounds)
% using a linePoint and lineDeltas, the interception point of these line
% with a plane is calculated

if lineDeltas(planeDim) == 0
    % Divide by 0 error, can''t find intersection of line with plane it is parallel to');
    interceptPoint = [];
else
    tValue = (planeVal - linePoint(planeDim)) ./ lineDeltas(planeDim);

    interceptPoint = linePoint + tValue .* lineDeltas;
    
    if ~pointWithinBounds(interceptPoint, planeBounds)
        interceptPoint = [];
    end

end

end

function bool = pointWithinBounds(point, bounds)
    ndims = length(point);
    
    bool = true;
    
    for i=1:ndims
        if point(i) <= bounds(i,1) || point(i) >= bounds(i,1)
            % out of bounds
            bool = false;
        end
    end
end