function [xCoords, yCoords, zCoords] = getAllDetectorCoords(detector, slicePosition, angle, perAngleXY, perAngleZ)
%[xCoords, yCoords, zCoords] = getAllDetectorCoords(detector, slicePosition, angle, perAngleXY, perAngleZ)

curvatureRadiusInM = detector.getAngularDetectorRadiusInM();

perAngleXY = - perAngleXY; %need to do opposite of what source did

locationInM = detector.locationUnits.convertToM(detector.location);

if isempty(slicePosition) % set z to slicePosition
    slicePosition = 0;
end

if ~detector.movesWithPerAngleTranslation
    perAngleXY = 0;
    perAngleZ = 0;
end

if isempty(angle)
    angle = 0;
end


[theta,radius] = cart2pol(locationInM(1), locationInM(2));
theta = theta * Constants.rad_to_deg;

theta = theta - angle; %minus angle because our angles are clockwise

singleDimensions = detector.singleDetectorDimensions;
wholeDimensions = detector.wholeDetectorDimensions;


% prepping angles and length
xyIsAngular = singleDimensions(1).units.isAngular;
zIsAngular = singleDimensions(2).units.isAngular;

numXYDetectors = wholeDimensions(1);
numZDetectors = wholeDimensions(2);

if xyIsAngular
    xyDimension = singleDimensions(1).getAngleInDegrees();
else
    xyDimension = singleDimensions(1).getLengthInM();
end

if zIsAngular
    zDimension = singleDimensions(2).getAngleInDegrees();
else
    zDimension = singleDimensions(2).getLengthInM();
end

xyHalfWidth = (numXYDetectors * xyDimension) / 2;
zHalfWidth = (numZDetectors * zDimension) / 2;


xyVals = linspace(-xyHalfWidth, xyHalfWidth, numXYDetectors+1);
zVals = linspace(-zHalfWidth, zHalfWidth, numZDetectors+1);

xCoords = zeros(length(zVals), length(xyVals));
yCoords = zeros(length(zVals), length(xyVals));
zCoords = zeros(length(zVals), length(xyVals));

z = slicePosition + perAngleZ;

for i=1:length(xyVals)
    xyVal = xyVals(i);  
    
    for j=1:length(zVals)        
        zVal = zVals(j);
        
        %will build detector parallel to y-axis, then rotate to where it needs
        %to be
        
        if xyIsAngular
            if zIsAngular
                zScale = cosd(zVal);
                xyScale = 1;
            else
                zScale = 1;
                xyScale = cosd(zVal);
            end
            
            x = curvatureRadiusInM * cosd(xyVal) * zScale;
            y = curvatureRadiusInM * sind(xyVal) * zScale + perAngleXY;
            
            % need to shift y if curvature radius is not the
            % detector-isocentre distance
            x = x + (norm(locationInM) - curvatureRadiusInM);
        else
            x = radius;
            y = xyVal + perAngleXY;
            
            if zIsAngular                
                xyScale = cosd(zVal);
            else                
                xyScale = 1;
            end
        end            
        
        plotX = x*xyScale;
        plotY = y;
        
        if zIsAngular
            plotZ = z + curvatureRadiusInM * sind(zVal);
        else
            plotZ = z + zVal;
        end
        
        rotated = rotateCoords([plotX,plotY],[0,0,theta]);
        
        xCoords(j,i) = rotated(1);
        yCoords(j,i) = rotated(2);
        zCoords(j,i) = plotZ;
    end
end

end

