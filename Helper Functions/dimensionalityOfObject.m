function numDims = dimensionalityOfObject(objectCoords)
% numDims = dimensionalityOfObject(objectCoords)

dims = size(objectCoords);

dimsToCheck = dims(2);

coordsEqual = ones(dimsToCheck,1);

checkValues = objectCoords(1,:);

for i=2:dims(1)
    for j=1:dimsToCheck
        if coordsEqual(j)
            coordsEqual(j) = checkValues(j) == objectCoords(i,j);
        end
    end
end

numDims = dimsToCheck - sum(coordsEqual);


end

