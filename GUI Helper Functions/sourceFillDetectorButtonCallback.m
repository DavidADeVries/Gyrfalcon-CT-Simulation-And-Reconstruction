function []  = sourceFillDetectorButtonCallback(hObject, eventdata, handles)
%[]  = sourceFillDetectorButtonCallback(hObject, eventdata, handles)

simulation = Simulation;

simulation = simulation.createFromGUI(handles);

detector = simulation.detector;

slicePosition = 0;
angle = 0;
perAngleXY = 0;
perAngleZ = 0;

dist = detector.getDistanceBetweenOriginAndDetectorCentrePointInM();
sourceDist = simulation.source.getDistanceBetweenOriginAndSourceCentrePointInM();

newLocationInM = [dist,0,0]; %along x-axis, at z=0, will make the math easier

detector = detector.setLocationInM(newLocationInM);

[xCoords, yCoords, zCoords] = ...
    getAllDetectorCoords(detector, slicePosition, angle, perAngleXY, perAngleZ);

cornerCoord = abs([xCoords(1,1),yCoords(1,1),zCoords(1,1)]);

cornerCoord(1) = cornerCoord(1) + sourceDist; %account for source distance

singleDimensions = detector.singleDetectorDimensions;

xyIsAngular = singleDimensions(1).units.isAngular;
zIsAngular = singleDimensions(2).units.isAngular;

if xyIsAngular && zIsAngular
    dims = size(yCoords);
    numZ = dims(1);
    
    row = round(numZ/2);
    
    angCornerCoord = abs([xCoords(row,1),yCoords(row,1),zCoords(1,1)]);
    angCornerCoord(1) = angCornerCoord(1) + sourceDist;
    
    xyHalfAngle = atand(angCornerCoord(2)/angCornerCoord(1));
else
    xyHalfAngle = atand(cornerCoord(2)/cornerCoord(1));
end

zHalfAngle = asind(cornerCoord(3)/norm(cornerCoord));

setDoubleForHandle(handles.sourceBeamAngleXYEdit, 2*xyHalfAngle);
setDoubleForHandle(handles.sourceBeamAngleZEdit, 2*zHalfAngle);

end

