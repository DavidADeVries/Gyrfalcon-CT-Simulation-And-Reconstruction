function rotatedCoords = rotateCoords(coords, rotationVector)
% rotatedCoords = rotateCoords(coords, rotationVector)
% rotation of 2D or 3D coords
% rotationVector gives rotation angle about [xAxis, yAxis] or [xAxis,
% yAxis, zAxis] in degrees

origLength = length(coords);

if origLength == 2
    coords = [coords, 0]; %add in z=0, and then we'll remove it later
end

if length(coords) == 3
    xMat = rotx(rotationVector(1));
    yMat = roty(rotationVector(2));
    zMat = rotz(rotationVector(3));
    
    coordColVector = coords';
    
    rotatedCoordColVector = zMat * yMat * xMat * coordColVector;
    
    rotatedCoords = rotatedCoordColVector';
else
    error('Length cannot be less than 1 or more than 3');
end

if origLength == 2
    rotatedCoords = rotatedCoords(1:2);
end

end

function rotMat = rotx(angle)
    rotMat = ...
    [1 0 0;
    0 cosd(angle) -sind(angle);
    0 sind(angle) cosd(angle)];    
end

function rotMat = roty(angle)
    rotMat = ...
        [cosd(angle) 0 sind(angle);
        0 1 0;
        -sind(angle) 0 cosd(angle)];
end

function rotMat = rotz(angle)
    rotMat = ...
        [cosd(angle) -sind(angle) 0;
        sind(angle) cosd(angle) 0;
        0 0 1];
end