function [] = detectorMakeDetectorDimsEqualCallback(hObject, eventdata, handles, changeXY)
%[] = detectorMakeDetectorDimsEqualCallback(hObject, eventdata, handles, changeXY)

simulation = Simulation;

simulation = simulation.createFromGUI(handles);

detector = simulation.detector;

slicePosition = 0;
angle = 0;
perAngleXY = 0;
perAngleZ = 0;

dist = detector.getDistanceBetweenOriginAndDetectorCentrePointInM();

newLocationInM = [dist,0,0]; %along x-axis, at z=0, will make the math easier

detector = detector.setLocationInM(newLocationInM);

[xCoords, yCoords, zCoords] = ...
    getAllDetectorCoords(detector, slicePosition, angle, perAngleXY, perAngleZ);

dims = size(yCoords);

numZ = dims(2);
numXY = dims(1);

widthY = abs(yCoords(1,round(numZ/2)));
widthX = abs(xCoords(1,round(numZ/2)));

heightZ = abs(zCoords(round(numXY/2),1));
heightX = abs(xCoords(round(numXY/2),1));

xyHalfAngle = atand(widthY/(2*widthX));
zHalfAngle = atand(heightZ/(2*heightX));

end

