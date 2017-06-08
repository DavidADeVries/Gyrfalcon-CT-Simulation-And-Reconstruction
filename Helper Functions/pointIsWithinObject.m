function bool = pointIsWithinObject(pointCoords, objectCoords)
%bool = pointIsWithinObject(pointCoords, objectCoords)
% only works for quadrangles for now

clockwisePosZ           = objectCoords(1,:);
clockwiseNegZ           = objectCoords(2,:);
counterClockwisePosZ    = objectCoords(3,:);

x1 = clockwisePosZ(1);
x2 = counterClockwisePosZ(1);

y1 = clockwisePosZ(2);
y2 = counterClockwisePosZ(2);

z1 = clockwisePosZ(3);
z2 = clockwiseNegZ(3);

xWithin = valueWithinRange(pointCoords(1), [x1,x2]);
yWithin = valueWithinRange(pointCoords(2), [y1,y2]);
zWithin = valueWithinRange(pointCoords(3), [z1,z2]);

bool = xWithin && yWithin && zWithin;

end

