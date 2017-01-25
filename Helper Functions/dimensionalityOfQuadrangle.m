function numDims = dimensionalityOfQuadrangle(objectCoords)
% numDims = dimensionalityOfQuadrangle(objectCoords)
% either 0,1,2,3 dimensions

clockwisePosZ = objectCoords(1,:);
clockwiseNegZ = objectCoords(2,:);
counterClockwisePosZ = objectCoords(3,:);
counterClockwiseNegZ = objectCoords(4,:);

clockwiseDeltaZ = clockwisePosZ(3) - clockwiseNegZ(3);
counterClockwiseDeltaZ = counterClockwisePosZ(3) - counterClockwiseNegZ(3);

posZDeltaXY = norm(clockwisePosZ(1:2) - counterClockwisePosZ(1:2));
negZDeltaXY = norm(clockwiseNegZ(1:2) - counterClockwiseNegZ(1:2));

if clockwiseDeltaZ ~= counterClockwiseDeltaZ || posZDeltaXY ~= negZDeltaXY
    numDims = 3;
elseif posZDeltaXY ~= 0 && clockwiseDeltaZ ~= 0
    numDims = 2;
elseif posZDeltaXY == 0 || clockwiseDeltaZ == 0
    numDims = 1;
else
    numDims = 0;
end
    


end

