function bool = pointIsWithinSourceBeamCone(point, sourceStartBoxCoords, sourceEndBoxCoords)
%bool = pointIsWithinSourceBeamCone(point, sourceStartBoxCoords, sourceEndBoxCoords)

dims = size(point);

if dims(1) == 1
    sourceStartBoxCoords = repmat(sourceStartBoxCoords,4,1);
end

startClockwisePosZ = sourceStartBoxCoords(1,:);
startCounterClockwiseNegZ = sourceStartBoxCoords(4,:);

endClockwisePosZ = sourceEndBoxCoords(1,:);
endCounterClockwiseNegZ = sourceEndBoxCoords(4,:);

[clockwisePosZLimitDeltas,~] = createLineEquation(startClockwisePosZ, endClockwisePosZ);
[clockwisePosZPointDeltas,~] = createLineEquation(startClockwisePosZ, point);

[counterClockwiseNegZLimitDeltas,~] = createLineEquation(startCounterClockwiseNegZ, endCounterClockwiseNegZ);
[counterClockwiseNegZPointDeltas,~] = createLineEquation(startCounterClockwiseNegZ, point);

clockwisePosZLessThan = clockwisePosZLimitDeltas <= clockwisePosZPointDeltas;
clockwisePosZGreaterThan = clockwisePosZLimitDeltas >= clockwisePosZPointDeltas;

counterClockwiseNegZLessThan = counterClockwiseNegZLimitDeltas <= counterClockwiseNegZPointDeltas;
counterClockwiseNegZGreaterThan = counterClockwiseNegZLimitDeltas >= counterClockwiseNegZPointDeltas;

within1 = clockwisePosZLessThan & counterClockwiseNegZGreaterThan;
within2 = clockwisePosZGreaterThan & counterClockwiseNegZLessThan;

bool = all(within1 | within2);

end

