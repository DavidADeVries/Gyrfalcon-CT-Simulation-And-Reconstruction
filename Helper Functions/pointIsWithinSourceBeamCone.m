function bool = pointIsWithinSourceBeamCone(point, sourceStartBoxCoords, sourceEndBoxCoords)
%bool = pointIsWithinSourceBeamCone(point, sourceStartBoxCoords, sourceEndBoxCoords)

dims = size(point);

if dims(1) == 1
    sourceStartBoxCoords = repmat(sourceStartBoxCoords,4,1);
end

startClockwisePosZ = sourceStartBoxCoords(1,:);
endClockwisePosZ = sourceEndBoxCoords(1,:);

checkPoint = point - startClockwisePosZ;
checkEndPoint = endClockwisePosZ - startClockwisePosZ;

[clockwisePointAngle, posZPointAngle, ~] = cart2sph(checkPoint(1),checkPoint(2),checkPoint(3));
[clockwiseAngle, posZAngle, ~] = cart2sph(checkEndPoint(1),checkEndPoint(2),checkEndPoint(3));

clockwisePointAngle = forceAnglePositiveInRadians(clockwisePointAngle);
clockwiseAngle = forceAnglePositiveInRadians(clockwiseAngle);

isClockwiseWithin = (clockwisePointAngle - clockwiseAngle) <= 0;
isPosZWithin = (posZPointAngle - posZAngle) <= 0;

startCounterClockwiseNegZ = sourceStartBoxCoords(4,:);
endCounterClockwiseNegZ = sourceEndBoxCoords(4,:);

checkPoint = point - startCounterClockwiseNegZ;
checkEndPoint = endCounterClockwiseNegZ - startCounterClockwiseNegZ;

[counterClockwisePointAngle, negZPointAngle, ~] = cart2sph(checkPoint(1),checkPoint(2),checkPoint(3));
[counterClockwiseAngle, negZAngle, ~] = cart2sph(checkEndPoint(1),checkEndPoint(2),checkEndPoint(3));

counterClockwisePointAngle = forceAnglePositiveInRadians(counterClockwisePointAngle);
counterClockwiseAngle = forceAnglePositiveInRadians(counterClockwiseAngle);

isCounterClockwiseWithin = (counterClockwisePointAngle - counterClockwiseAngle) >= 0;
isNegZWithin = (negZPointAngle - negZAngle) >= 0;

bool = isClockwiseWithin && isCounterClockwiseWithin && isPosZWithin && isNegZWithin;

end

