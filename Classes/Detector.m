classdef Detector
    % Detector
    % This class contains all the data pertaining to an x-ray detector for the CT
    % simulator.
    %
    % FIELDS:
    % *location:
    % the location where the centre of the detector will begin for a
    % simulated scan. The detector is assumed to be symmetrical around its
    % centre
    % units are in m
    %
    % *wholeDetectorDimensions:
    % the number of detectors that make up the whole detector, and in each
    % direction
    % [# in width, # in depth]
    %
    % *singleDetectorDimensions:
    % the dimensions of a single detector that will make up the whole
    % detector
    % units are in mm or degrees
    %
    % *detectorMovesWithSource:
    % boolean field that determines whether the detector moves with the
    % radiation source or not
    
    
    
    properties
        location
        locationUnits = Units.m
        
        wholeDetectorDimensions
        singleDetectorDimensions
        
        movesWithScanAngle
        movesWithPerAngleTranslation
        
        savePath
        saveFileName
    end
    
    methods
        function detector = Detector(location, wholeDetectorDimensions, singleDetectorDimensions, detectorMovesWithScanAngle, detectorMovesWithPerAngleTranslation)
            if nargin > 0
                % validate detector parameters and fill in blanks if needed
                
                % validate location
                locationNumDims = length(location);
                
                if locationNumDims < 2 || locationNumDims > 3
                    error('Location of detector not given in 2 or 3 space');
                elseif locationNumDims == 2
                    % tack on z = 0 for completeness
                    
                    location = [location, 0];
                end
                
                % validate wholeDetectorDimensions
                wholeDetectorNumDims = length(wholeDetectorDimensions);
                
                if wholeDetectorNumDims < 1 || wholeDetectorNumDims > 2
                    error('Whole detector dimensions not given in 1 or 2 space');
                elseif wholeDetectorNumDims == 1
                    % take on depth = 1 for completeness
                    
                    wholeDetectorDimensions = [wholeDetectorDimensions, 1];
                end
                
                % singleDetectorDimensions
                singleDetectorNumDims = length(singleDetectorDimensions);
                
                if singleDetectorNumDims < 1 || singleDetectorNumDims > 2
                    error('Single dectector dimensions not given in 1 or 2 space');
                elseif singleDetectorNumDims == 1
                    % make depth measurement as 0, planar
                    
                    value = 0;
                    isPlanar = true;
                    
                    singleDetectorDimensions = [singleDetectorDimensions, Dimension(value, isPlanar)];
                end
                
                % if we get here, we're good to go, so lets assign the fields
                detector.location = location;
                detector.wholeDetectorDimensions = wholeDetectorDimensions;
                detector.singleDetectorDimensions = singleDetectorDimensions;
                detector.movesWithScanAngle = detectorMovesWithScanAngle;
                detector.movesWithPerAngleTranslation = detectorMovesWithPerAngleTranslation;
            end
        end
        
        function locationInM = getLocationInM(detector)
            units = detector.locationUnits;
            location = detector.location;
            
            locationInM = units.convertToM(location);            
        end
        
        function detector = setLocationInM(detector, newLocationInM)
            toUnits = detector.locationUnits;
            
            newLocationInToUnits = toUnits.convertFromM(newLocationInM);
            
            detector.location = newLocationInToUnits;
        end
        
        function dist = getDistanceBetweenOriginAndDetectorCentrePointInM(detector)
            locationInM = detector.getLocationInM();
            
            dist = norm(locationInM(1:2));
        end
        
        function position = getDetectorPosition(detector, slicePosition, scanAngle)
            location = detector.getLocationInM();
            
            z = slicePosition;
            
            if detector.movesWithScanAngle
                [theta, radius] = cart2pol(location(1), location(2));
                theta = theta * Constants.rad_to_deg;
                
                detectorAngle = theta - scanAngle; %minus because we define scanAngle to be clockwise, but Matlab is counter-clockwise
                
                [x,y] = pol2cart(detectorAngle * Constants.deg_to_rad, radius);
            else
                x = location(1);
                y = location(2);
            end
            
            position = [x,y,z];
        end
        
        function plotHandles = plot(detector, axesHandle, slicePosition, angle, perAngleXY, perAngleZ)
            hold(axesHandle,'on');
            
            [xPlotVals, yPlotVals, zPlotVals] = getAllDetectorCoords(detector, slicePosition, angle, perAngleXY, perAngleZ);
            
            edgeColour = Constants.Detector_Colour;
            
            handle = mesh(xPlotVals,yPlotVals,zPlotVals,...
                'EdgeColor', edgeColour,...
                'FaceColor', 'none',...
                'Parent', axesHandle);
            
            plotHandles = {handle};                
                
            if detector.movesWithScanAngle
                % draw circle outlining the movement of the
                % detector
                dims = size(zPlotVals);
                
                numZ = dims(1);
                numXY = dims(2);
                
                halfXY = round(numXY/2);
                
                x = xPlotVals(1,halfXY);
                y = yPlotVals(1,halfXY);
                
                highZ = zPlotVals(numZ,halfXY);
                lowZ = zPlotVals(1,halfXY);
                
                circRadius = norm([x y]);
                                
                edgeColour = Constants.Detector_Colour;
                lineStyle = '--';
                lineWidth = [];
                faceColour = [];                
                
                if highZ == lowZ
                    handle = circleOrArcPatch(0, 0, highZ,...
                        circRadius, 0, 360,...
                        edgeColour, faceColour, lineStyle, lineWidth, axesHandle);
                    
                    handles = {handle};
                else
                    handle1 = circleOrArcPatch(...
                        0, 0, lowZ,...
                        circRadius, 0, 360,...
                        edgeColour, faceColour, lineStyle, lineWidth, axesHandle);
                    handle2 = circleOrArcPatch(...
                        0, 0, highZ,...
                        circRadius, 0, 360,...
                        edgeColour, faceColour, lineStyle, lineWidth, axesHandle);
                    
                    handles = {handle1, handle2};
                end
                
                % add to plot handles
                plotHandles = [plotHandles, handles];
            end
        end
        
        function handles = setGUI(detector, handles)
            x = detector.location(1);
            y = detector.location(2);
            z = detector.location(3);
            
            setDoubleForHandle(handles.detectorStartingLocationXEdit, x);
            setDoubleForHandle(handles.detectorStartingLocationYEdit, y);
            setDoubleForHandle(handles.detectorStartingLocationZEdit, z);
            
            xy = detector.wholeDetectorDimensions(1);
            z = detector.wholeDetectorDimensions(2);
            
            setDoubleForHandle(handles.detectorWholeDetectorDimensionsXYEdit, xy);
            setDoubleForHandle(handles.detectorWholeDetectorDimensionsZEdit, z);
            
            xy = detector.singleDetectorDimensions(1).value;
            z = detector.singleDetectorDimensions(2).value;
            
            xyUnits = detector.singleDetectorDimensions(1).units;
            zUnits = detector.singleDetectorDimensions(2).units;
            
            setDoubleForHandle(handles.detectorSingleDetectorDimensionsXYEdit, xy);
            setDoubleForHandle(handles.detectorSingleDetectorDimensionsZEdit, z);
            
            setSelectionForPopupMenu(handles.detectorSingleDetectorDimensionsXYUnitsPopupMenu, 'Units', xyUnits);
            setSelectionForPopupMenu(handles.detectorSingleDetectorDimensionsZUnitsPopupMenu, 'Units', zUnits);
            
            set(handles.detectorMovesWithScanAngleCheckbox, 'Value', detector.movesWithScanAngle);
            set(handles.detectorMovesWithPerAngleTranslationCheckbox, 'Value', detector.movesWithPerAngleTranslation);
            
            if isempty(detector.saveFileName)
                setString(handles.detectorFileNameText, 'Not Saved');
            else
                setString(handles.detectorFileNameText, detector.saveFileName);
            end
            
            % set hidden handles
            handles.detectorSavePath = detector.savePath;
            handles.detectorSaveFileName = detector.saveFileName;
        end
        
        function detector = createFromGUI(detector, handles)
            x = getDoubleFromHandle(handles.detectorStartingLocationXEdit);
            y = getDoubleFromHandle(handles.detectorStartingLocationYEdit);
            z = getDoubleFromHandle(handles.detectorStartingLocationZEdit);
            
            detector.location = [x,y,z];
            
            xy = getDoubleFromHandle(handles.detectorWholeDetectorDimensionsXYEdit);
            z = getDoubleFromHandle(handles.detectorWholeDetectorDimensionsZEdit);
            
            detector.wholeDetectorDimensions = [xy, z];
            
            xy = getDoubleFromHandle(handles.detectorSingleDetectorDimensionsXYEdit);
            z = getDoubleFromHandle(handles.detectorSingleDetectorDimensionsZEdit);
            
            xyUnits = getSelectionFromPopupMenu(handles.detectorSingleDetectorDimensionsXYUnitsPopupMenu, 'Units');
            zUnits = getSelectionFromPopupMenu(handles.detectorSingleDetectorDimensionsZUnitsPopupMenu, 'Units');
            
            xyDimension = Dimension(xy, xyUnits);
            zDimension = Dimension(z, zUnits);
            
            detector.singleDetectorDimensions = [xyDimension, zDimension];
            
            detector.movesWithScanAngle = get(handles.detectorMovesWithScanAngleCheckbox, 'Value');
            detector.movesWithPerAngleTranslation = get(handles.detectorMovesWithPerAngleTranslationCheckbox, 'Value');
            
            detector.savePath = handles.detectorSavePath;
            detector.saveFileName = handles.detectorSaveFileName;
        end
        
        function [clockwisePosZ, clockwiseNegZ, counterClockwisePosZ, counterClockwiseNegZ] = getDetectorCoords(detector, detectorPosition, xyDetector, zDetector, perAngleShiftsUsed)
            % [clockwisePosZ, clockwiseNegZ, counterClockwisePosZ, counterClockwiseNegZ] = getDetectorCoords(detector, detectorPosition, xyDetector, zDetector)
            % this gives the 4 coordinates of the detector in question with the most
            % clockwise coordinates first, and then the more counter-clockwise
            % coordinates
            
            [theta, psi, radius] = cart2sph(detectorPosition(1), detectorPosition(2), 0); % set z to zero, and then shift it down later
            theta = theta * Constants.rad_to_deg;
            psi = psi * Constants.rad_to_deg;
            
            totalNumXYDetectors = detector.wholeDetectorDimensions(1);
            totalNumZDetectors = detector.wholeDetectorDimensions(2);
            
            midXYDetector = (totalNumXYDetectors + 1) / 2;
            midZDetector = (totalNumZDetectors + 1) / 2;
            
            xyStep = (xyDetector - midXYDetector);
            zStep = (zDetector - midZDetector);
            
            clockwiseStep = xyStep + 0.5;
            counterClockwiseStep = xyStep - 0.5;
            
            positiveZStep = zStep + 0.5;
            negativeZStep = zStep - 0.5;
            
            clockwiseShift = clockwiseStep * detector.singleDetectorDimensions(1).getValueInSIUnits();
            counterClockwiseShift = counterClockwiseStep * detector.singleDetectorDimensions(1).getValueInSIUnits();
            
            positiveZShift = positiveZStep * detector.singleDetectorDimensions(2).getValueInSIUnits();
            negativeZShift = negativeZStep * detector.singleDetectorDimensions(2).getValueInSIUnits();
            
            xyIsAngular = detector.singleDetectorDimensions(1).units.isAngular;
            zIsAngular = detector.singleDetectorDimensions(2).units.isAngular;
            
            clockwisePosZ = zeros(1,3);
            clockwiseNegZ = zeros(1,3);
            counterClockwisePosZ = zeros(1,3);
            counterClockwiseNegZ = zeros(1,3);
            
            if zIsAngular
                if xyIsAngular
                    posZVal = detectorPosition(3) + radius * sind(positiveZShift);
                    negZVal = detectorPosition(3) + radius * sind(negativeZShift);
                else
                    posZShift = radius * sind(positiveZShift);
                    negZShift = radius * sind(negativeZShift);
                                                                                
                    posZVal = detectorPosition(3) + posZShift;
                    negZVal = detectorPosition(3) + negZShift;
                end
            else
                posZVal = detectorPosition(3) + positiveZShift;
                negZVal = detectorPosition(3) + negativeZShift;
            end
            
            clockwisePosZ(3) = posZVal;
            counterClockwisePosZ(3) = posZVal;
            
            clockwiseNegZ(3) = negZVal;
            counterClockwiseNegZ(3) = negZVal;
                
            
            if xyIsAngular
                clockwiseAngle = theta - clockwiseShift; %remember, minus because we do angles as positive is clockwise!
                counterClockwiseAngle = theta - counterClockwiseShift;
                    
                if zIsAngular
                    clockwisePosZAngle = findAngleForPerpendicularArc(clockwiseShift, positiveZShift, radius);
                    clockwisePosZAngle = clockwisePosZAngle * Constants.deg_to_rad;
                    
                    [x,y,z] = sph2cart(clockwiseAngle * Constants.deg_to_rad, clockwisePosZAngle, radius);
                    
                    z = z + detectorPosition(3); %need to add the z back in
                    
                    clockwisePosZ(1:3) = [x,y,z];
                    
                    
                    clockwiseNegZAngle = findAngleForPerpendicularArc(clockwiseShift, negativeZShift, radius);
                    clockwiseNegZAngle = clockwiseNegZAngle * Constants.deg_to_rad;
                    
                    [x,y,z] = sph2cart(clockwiseAngle * Constants.deg_to_rad, clockwiseNegZAngle, radius);
                    
                    z = z + detectorPosition(3); %need to add the z back in
                    
                    clockwiseNegZ(1:3) = [x,y,z];
                    
                    
                    counterClockwisePosZAngle = findAngleForPerpendicularArc(counterClockwiseShift, positiveZShift, radius);
                    counterClockwisePosZAngle = counterClockwisePosZAngle * Constants.deg_to_rad;
                    
                    [x,y,z] = sph2cart(counterClockwiseAngle * Constants.deg_to_rad, counterClockwisePosZAngle, radius);
                    
                    z = z + detectorPosition(3); %need to add the z back in
                    
                    counterClockwisePosZ(1:3) = [x,y,z];
                    
                    
                    counterClockwiseNegZAngle = findAngleForPerpendicularArc(counterClockwiseShift, negativeZShift, radius);
                    counterClockwiseNegZAngle = counterClockwiseNegZAngle * Constants.deg_to_rad;
                    
                    [x,y,z] = sph2cart(counterClockwiseAngle * Constants.deg_to_rad, counterClockwiseNegZAngle, radius);
                    
                    z = z + detectorPosition(3); %need to add the z back in
                    
                    counterClockwiseNegZ(1:3) = [x,y,z];
                else
                    [x,y] = pol2cart(clockwiseAngle*Constants.deg_to_rad, radius);
                    
                    clockwiseShiftX = x;
                    clockwiseShiftY = y;
                    
                    [x,y] = pol2cart(counterClockwiseAngle*Constants.deg_to_rad, radius);
                    
                    counterClockwiseShiftX = x;
                    counterClockwiseShiftY = y;
                                        
                    clockwisePosZ(1) = clockwiseShiftX;
                    clockwiseNegZ(1) = clockwiseShiftX;
                    
                    counterClockwisePosZ(1) = counterClockwiseShiftX;
                    counterClockwiseNegZ(1) = counterClockwiseShiftX;
                    
                    clockwisePosZ(2) = clockwiseShiftY;
                    clockwiseNegZ(2) = clockwiseShiftY;
                    
                    counterClockwisePosZ(2) = counterClockwiseShiftY;
                    counterClockwiseNegZ(2) = counterClockwiseShiftY;
                end
            else
                clockwiseShiftX = detectorPosition(1) + clockwiseShift * cosd(theta + 90);
                counterClockwiseShiftX = detectorPosition(1) + counterClockwiseShift * cosd(theta + 90);
                
                clockwiseShiftY = detectorPosition(2) + clockwiseShift * sind(theta + 90);
                counterClockwiseShiftY = detectorPosition(2) + counterClockwiseShift * sind(theta + 90);
                
                if zIsAngular
                    % the xy radius changes due to curvature in the z
                    % direction
                    posZRadius = radius * cosd(positiveZShift);
                    negZRadius = radius * cosd(negativeZShift);
                    
                    % find the x,y if the just the radius was reduced
                    [x, y] = pol2cart(theta * Constants.deg_to_rad, posZRadius);
                    
                    % find the shift needed for x and y to compensate for z
                    % curvature
                    posZ_xShift = x - detectorPosition(1);
                    posZ_yShift = y - detectorPosition(2);
                    
                    % do the same for the lower (negative) z value
                    [x, y] = pol2cart(theta * Constants.deg_to_rad, negZRadius);
                    
                    negZ_xShift = x - detectorPosition(1);
                    negZ_yShift = y - detectorPosition(2);
                    
                    % set points using the found shifts
                    clockwisePosZ(1) = clockwiseShiftX + posZ_xShift;
                    clockwisePosZ(2) = clockwiseShiftY + posZ_yShift;
                    
                    clockwiseNegZ(1) = clockwiseShiftX + negZ_xShift;
                    clockwiseNegZ(2) = clockwiseShiftY + negZ_yShift;
                    
                    counterClockwisePosZ(1) = counterClockwiseShiftX + posZ_xShift;
                    counterClockwisePosZ(2) = counterClockwiseShiftY + posZ_yShift;
                    
                    counterClockwiseNegZ(1) = counterClockwiseShiftX + negZ_xShift;
                    counterClockwiseNegZ(2) = counterClockwiseShiftY + negZ_yShift;
                                        
                else                    
                    clockwisePosZ(1) = clockwiseShiftX;
                    clockwiseNegZ(1) = clockwiseShiftX;
                    
                    counterClockwisePosZ(1) = counterClockwiseShiftX;
                    counterClockwiseNegZ(1) = counterClockwiseShiftX;
                    
                    clockwisePosZ(2) = clockwiseShiftY;
                    clockwiseNegZ(2) = clockwiseShiftY;
                    
                    counterClockwisePosZ(2) = counterClockwiseShiftY;
                    counterClockwiseNegZ(2) = counterClockwiseShiftY;
                end
                
            end
                               
            % account for perAngleShifts
            if detector.movesWithPerAngleTranslation
                %perAngleShiftsUsed = [-1, -1, 1] .* perAngleShiftsUsed; %need to reverse x and y shifts from source
                
                clockwisePosZ = clockwisePosZ + perAngleShiftsUsed;
                clockwiseNegZ = clockwiseNegZ + perAngleShiftsUsed;
                counterClockwisePosZ = counterClockwisePosZ + perAngleShiftsUsed;
                counterClockwiseNegZ = counterClockwiseNegZ + perAngleShiftsUsed;
            end
        end

    end
    
end


function detectorLineHeight = getDetectorLineHeight(detector)
singleDims = detector.singleDetectorDimensions;

len = length(singleDims);

dimensionLengths = zeros(len,1);

for i=1:len
    dim = singleDims(i);
    
    if dim.units.isAngular
        dimensionLengths(i) = dim.getLengthInM(norm(detector.location), detector.locationUnits);
    else
        dimensionLengths(i) = dim.getLengthInM();
    end
end

maxLen = max(dimensionLengths);
scaleFactor = 1;

detectorLineHeight = scaleFactor * maxLen;
end


function angle = findAngleForPerpendicularArc(theta, psi, radius)
% theta is the angle that the perpendicular arc is rotated (aka 0 is
% centre)
% psi is the max angle of the arcs that this arc will be perpendicular to
% radius is the radius of these arcs

% STEP 1: If we project a circle tilted from a plane at psi, it becomes an
% ellipse
% we'll assume that the ellipse is oriented such that the x-axis radius is
% unchanged, and y-axes is changed
% aka circle was titled about x-axis

a = radius; % x axis
b = radius*cosd(psi); % y axis

[x, y] = getEllipseXAndY(a, b, theta);

% STEP 2: If we then look down the x-axis, the titled circle will appear to
% be a straight line (of length radius) at angle psi
% we can then use the y value we just found, and use this as a horizontal
% point in this view. The height of our perpendiular arc can then be found

height = y * tand(psi);

% STEP 3: Then knowing the height and radius, the angle can easily be
% figured out
% Angle MUST be negative!

angle = asind(height / radius);

end


function  [x, y] = getEllipseXAndY(a, b, theta)

theta = theta + 90; %flip into proper axis (x unstretched, y scaled)

if mod(theta, 90) == 0 && mod(theta, 180) ~= 0
    x = 0;
else
    x = (((tand(theta)^2)/(b^2)) + (1/(a^2))) ^ -0.5;
end

y = b * sqrt(1 - ((x^2)/(a^2)));

end