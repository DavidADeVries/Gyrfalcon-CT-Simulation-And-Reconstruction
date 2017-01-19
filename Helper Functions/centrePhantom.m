function location = centrePhantom(data, dimensions)
% location = centrePhantom(dimensions)
% based on the phantom data and voxel dimensions of the phantom given,
% either a 2D or 3D vector is given that if the top left corner is there,
% the centre of the phantom would at the origin\

dataDims = size(data);

dataDim1 = dataDims(1);
dataDim2 = dataDims(2);

dataDims(1) = dataDim2; %switch up so its in x,y,z format
dataDims(2) = dataDim1;

numDataDims = length(dataDims);

location = zeros(1, 3);

for i=1:numDataDims % go through 2 or 3 dimensions
    voxelDim = dimensions(i);
    numVoxel = dataDims(i);
    
    sideLength = numVoxel * voxelDim * Constants.mm_to_m;
    
    if i == 1 % need negative coord (-x)
        coord = -(sideLength / 2);
    else % need positive coord, since for TOP left corner, need +y, +z
        coord = (sideLength / 2);
    end
    
    location(i) = coord;
end


end

