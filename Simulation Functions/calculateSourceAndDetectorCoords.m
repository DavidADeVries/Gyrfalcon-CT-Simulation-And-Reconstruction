function [pointSourceCoords, pointDetectorCoords, pointDetectorWithinSourceBeam] = calculateSourceAndDetectorCoords(indices, sourcePositionInM, detectorPositionInM, slicesInM, anglesInDeg, perAngleStepDimsInM, numPerAngleSteps, detectorDims, detectorPixelDimsWithUnits, angularDetectorRadiusInM, detectorMovesWithScanAngle, detectorMovesWithPerAngleSteps, beamAnglesInDegrees)
%function [pointSourceCoords, pointDetectorCoords, pointDetectorWithinSourceBeam] = calculateSourceAndDetectorCoords(indices, sourcePositionInM, detectorPositionInM, slicesInM, anglesInDeg, perAngleStepDimsInM, numPerAngleSteps, detectorDims, detectorPixelDimsWithUnits, angularDetectorRadiusInM, detectorMovesWithScanAngle, detectorMovesWithPerAngleSteps, beamAnglesInDegrees)
    
    % pre-allocate
    dims = size(indices);
    numCoords = dims(1);

    pointSourceCoords = zeros(numCoords,3);
    pointDetectorCoords = zeros(numCoords,3);

    % set intial positions
    [sourceAngleInRad, sourceRadius] = cart2pol(sourcePositionInM(1), sourcePositionInM(2));
    [detectorAngleInRad, detectorRadius] = cart2pol(detectorPositionInM(1), detectorPositionInM(2));

    sourceAngleInDeg = sourceAngleInRad * Constants.rad_to_deg;
    detectorAngleInDeg = detectorAngleInRad * Constants.rad_to_deg;

    % imagine source and detector centres are along positive x-axis
    % now, will rotate everything back later
    pointSourceCoords(:,1) = sourceRadius;
    pointSourceCoords(:,3) = slicesInM(indices(:,1));

    pointDetectorCoords(:,1) = detectorRadius;
    pointDetectorCoords(:,3) = slicesInM(indices(:,1));

    % SOURCE

    % per angle steps
    pointSourceCoords(:,2) = pointSourceCoords(:,2) + ((indices(:,4)-(numPerAngleSteps(1)+1)/2) * perAngleStepDimsInM(1));
    pointSourceCoords(:,3) = pointSourceCoords(:,3) - ((indices(:,3)-(numPerAngleSteps(2)+1)/2) * perAngleStepDimsInM(2));

    % rotate with the scan angle and bring back from x-axis
    [pointSourceCoords(:,1), pointSourceCoords(:,2)] = rotateCoordsAboutOrigin(pointSourceCoords(:,1),pointSourceCoords(:,2), sourceAngleInDeg - anglesInDeg(indices(:,2)));

    % DETECTOR

    % detector placement (for planar 2D detectors only)
    % gives location of detector centre
    if detectorPixelDimsWithUnits(1).isPlanar
        detectorDimInM = detectorPixelDimsWithUnits(1).getLengthInM();

        pointDetectorCoords(:,2) = pointDetectorCoords(:,2) - ( (indices(:,6)-(detectorDims(1)/2)-0.5) * detectorDimInM );
    else %isAngular
        detectorDimInDeg = detectorPixelDimsWithUnits(1).getAngleInDegrees();

        pointDetectorCoords(:,2) = pointDetectorCoords(:,2) + (angularDetectorRadiusInM * sind( (indices(:,6)-(detectorDims(1)/2)-0.5) * detectorDimInDeg ));
        pointDetectorCoords(:,1) = pointDetectorCoords(:,1) + (angularDetectorRadiusInM * (cosd( (indices(:,6)-(detectorDims(1)/2)-0.5) * detectorDimInDeg )-1));
    end

    if detectorPixelDimsWithUnits(2).isPlanar
        detectorDimInM = detectorPixelDimsWithUnits(2).getLengthInM();

        pointDetectorCoords(:,3) = pointDetectorCoords(:,3) - ( (indices(:,5)-(detectorDims(2)/2)-0.5) * detectorDimInM );
    else
        detectorDimInDeg = detectorPixelDimsWithUnits(2).getAngleInDegrees();

        pointDetectorCoords(:,3) = pointDetectorCoords(:,3) + (angularDetectorRadiusInM * sind( (indices(:,5)-(detectorDims(2)/2)-0.5) * detectorDimInDeg ));
        pointDetectorCoords(:,1) = pointDetectorCoords(:,1) + (angularDetectorRadiusInM * (cosd( (indices(:,5)-(detectorDims(2)/2)-0.5) * detectorDimInDeg )-1));
    end

    % per angle steps
    if detectorMovesWithPerAngleSteps
        % NOTE: indices for xy steps are negated, so that detector
        % matches source movement (which is opposite it)
        pointDetectorCoords(:,2) = pointDetectorCoords(:,2) - ((indices(:,4)-(numPerAngleSteps(1)+1)/2) * perAngleStepDimsInM(1));
        pointDetectorCoords(:,3) = pointDetectorCoords(:,3) - ((indices(:,3)-(numPerAngleSteps(2)+1)/2) * perAngleStepDimsInM(2));
    end

    rotateAngles = detectorAngleInDeg;

    if detectorMovesWithScanAngle
        rotateAngles = rotateAngles - anglesInDeg(indices(:,2));
    end

    [pointDetectorCoords(:,1), pointDetectorCoords(:,2)] = rotateCoordsAboutOrigin(pointDetectorCoords(:,1), pointDetectorCoords(:,2), rotateAngles);

    % ************************************************
    % check if point detectors are within source beams
    % ************************************************
    % move source to origin
    tempDetectorCoords = pointDetectorCoords - pointSourceCoords;

    % check xy
    % angle at with source is pointing
    sourceAngles = mod(sourceAngleInDeg - anglesInDeg(indices(:,2)) + 180, 360); % add 180 since in opposite direction of angle

    anglesToDetector = mod(atan2d(tempDetectorCoords(:,2), tempDetectorCoords(:,1)) + 360, 360); %to be in range 0..360

    upperAngles = sourceAngles + beamAnglesInDegrees(1)/2;
    lowerAngles = sourceAngles - beamAnglesInDegrees(1)/2;

    withinXY = upperAngles >= anglesToDetector & lowerAngles <= anglesToDetector;

    % check z
    xyLength = sqrt(((tempDetectorCoords(:,1)).^2)+((tempDetectorCoords(:,2)).^2));

    anglesToDetector = atand(tempDetectorCoords(:,3) ./ xyLength);

    upperAngle = beamAnglesInDegrees(2)/2;
    lowerAngle = -beamAnglesInDegrees(2)/2;

    withinZ = upperAngle >= anglesToDetector & lowerAngle <= anglesToDetector;

    pointDetectorWithinSourceBeam = withinXY & withinZ;
end

function [x, y] = rotateCoordsAboutOrigin(x, y, anglesInDeg)
    tempX = x;

    x = x .* cosd(anglesInDeg) - y .* sind(anglesInDeg);
    y = y .* cosd(anglesInDeg) + tempX .* sind(anglesInDeg);
end

