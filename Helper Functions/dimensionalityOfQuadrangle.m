function numDims = dimensionalityOfQuadrangle(objectCoords)
% numDims = dimensionalityOfQuadrangle(objectCoords)
% either 0,1,2,3 dimensions

clockwisePosZ = objectCoords(1,:);
clockwiseNegZ = objectCoords(2,:);
counterClockwisePosZ = objectCoords(3,:);
counterClockwiseNegZ = objectCoords(4,:);

clockwiseDeltaZ = clockwisePosZ(3) - clockwiseNegZ(3);
counterClockwiseDeltaZ = counterClockwisePosZ(3) - counterClockwiseNegZ(3);

noZ = clockwiseDeltaZ == 0 && counterClockwiseDeltaZ == 0;

posZDeltaXY = norm(clockwisePosZ(1:2) - counterClockwisePosZ(1:2));
negZDeltaXY = norm(clockwiseNegZ(1:2) - counterClockwiseNegZ(1:2));

noXY = all(posZDeltaXY == [0,0]) && all(negZDeltaXY == [0,0]);

if noZ && noXY
    numDims = 0;
elseif noZ || noXY
    numDims = 1;
else
    numDims = 2;
end
    


end

