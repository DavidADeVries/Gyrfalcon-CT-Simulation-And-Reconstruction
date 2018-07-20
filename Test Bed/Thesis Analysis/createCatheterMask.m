function mask = createCatheterMask(coordReadPath, volumeDims, radius)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

mask = false(volumeDims);

data = load(coordReadPath);
coords = data.coords;

dims = size(coords);

if length(dims) == 2
    numCaths = 1;
else
    numCaths = dims(3);
end

for i=coords(1,3,1):coords(end,3,1)
    slice = false(volumeDims(1:2));
    
    for j=1:numCaths
        cathX = squeeze(coords(:,1,j));
        cathY = squeeze(coords(:,2,j));
        cathZ = squeeze(coords(:,3,j));
        
        x = interp1(cathZ,cathX,i);
        y = interp1(cathZ,cathY,i);
        
        slice = slice | createCircleMask(x , y, radius, volumeDims);
    end
    
    mask(:,:,i) = slice;
end

end

function mask = createCircleMask(x, y, r, dims)
    [xx,yy] = ndgrid((1:dims(1))-y,(1:dims(2))-x);
    
    mask = (xx.^2 + yy.^2) < r^2;
end