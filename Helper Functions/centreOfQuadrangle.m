function centreCoords = centreOfQuadrangle(quadrangleCoords)
%centreCoords = centreOfQuadrangle(quadrangleCoords)

dims = size(quadrangleCoords);

centreCoords = zeros(1,dims(2));

for i=1:dims(2)
    dimVals = quadrangleCoords(:,i);
    
    centreCoords(i) = mean(dimVals);
end


end

