function intersectionPoints = findLinePhantomIntersections(lineDeltas, linePoint, startPoint, phantomLocation,  phantomVoxelDims, phantomData)
%linePhantomIntersectionPoints = findLinePhantomIntersections(lineDeltas, linePoint, startPoint, phantomLocation,  phantomVoxelDims, phantomData)
    
phantomDims = size(phantomData);

phantX = phantomLocation(1);
phantY = phantomLocation(2);
phantZ = phantomLocation(3);
    
phantDelX = phantomVoxelDims(1);
phantDelY = phantomVoxelDims(2);
phantDelZ = phantomVoxelDims(3);

phantomDeltas = [phantDelX, phantDelY, phantDelZ];

phantNumX = phantomDims(2); %Yup these should be reversed, remember MATLAB does (rows, cols, slice) for size(), so (y,x,z)
phantNumY = phantomDims(1);
phantNumZ = phantomDims(3);

bounds = [...
    phantX, phantX + phantNumX*phantDelX;
    phantY - phantNumY*phantDelY, phantY;
    phantZ - phantNumZ*phantDelZ, phantZ];

% first, find the point where the beam first intersects the phantom

tValue = inf;
intersectionPoint = [];

for i=1:3 % go through three dimensions
    coord = startPoint(i);
    coordBounds = bounds(i,:);
    
    dim = i;
    dimValue = [];
    
    if coord <= coordBounds(1)
        dimValue = coordBounds(1);
    elseif coord >= coordBounds(2)
        dimValue = coordBounds(2);
    end
    
    if ~isempty(dimValue)
        [point, t] = getPointAlongLineFromOneDimWithinBounds(lineDeltas, linePoint, dim, dimValue, bounds);
        
        if ~isempty(point) && t < tValue
            %if intersection point exists and the t value is smaller (aka a
            %closer point to the source)
            intersectionPoint = point;
        end
    end
end

% second, now follow beam through phantom from this first point

if isempty(intersectionPoint) % beam never hits phantom
    intersectionPoints = [];
else
    % find the rest of the intersection points
    lastPoint = intersectionPoint;
    intersectionPoints = intersectionPoint;
    pointCounter = 2;
            
    while ~isempty(lastPoint)
        nextPoint = findNextIntersectionPoint(...
            lastPoint,...
            linePoint, lineDeltas,...
            phantomLocation, phantomDeltas, bounds);
        
        if isempty(nextPoint)
            lastPoint = [];
        else
            intersectionPoints(pointCounter,:) = nextPoint;
            pointCounter = pointCounter + 1;
            lastPoint = nextPoint;
        end
    end
end


end



function bool = pointWithinBounds(point, bounds)
    bool = true;
    
    for i=1:length(point)
        if point(i) < bounds(i,1) || point(i) > bounds(i,2)
            bool = false;
        end
    end
end

function [point, t] = getPointAlongLineFromOneDimWithinBounds(lineDeltas, linePoint, dim, dimValue, bounds)

    lineDelta = lineDeltas(dim);
    
    if lineDelta == 0
        point = [];
        t = [];
    else
        t = (dimValue - linePoint(dim)) / lineDelta;
        
        point = linePoint + t * lineDeltas;
        
        point(dim) = dimValue; %avoids rounding errors
        
        if ~pointWithinBounds(point, bounds)
            point = [];
            t = [];
        end
    end
        
end

function nextPoint = findNextIntersectionPoint(lastPoint, linePoint, lineDeltas, phantomLocation, phantomDeltas, bounds)
    nextPoint = [];
    minT = inf;

    for i=1:3
         delta = lineDeltas(i);
         deltaSign = sign(delta);
         dim = i;
         
         if delta ~= 0
                          
            if mod(roundToNanoM(lastPoint(i) - phantomLocation(i)), phantomDeltas(i)) == 0 %is right on a plane
                                
                dimValue = lastPoint(i) + deltaSign * phantomDeltas(i);
            else
                if dim == 1 % need to swap up sign for x
                    chooseSign = deltaSign * -1;
                    calcSign = 1;
                else
                    chooseSign = deltaSign;
                    calcSign = -1;
                end
                
                unroundedIndex = (lastPoint(i) - phantomLocation(i)) / (calcSign*phantomDeltas(i));
                
                if chooseSign == -1
                    index = ceil(unroundedIndex);
                else
                    index = floor(unroundedIndex);
                end
                
                dimValue = phantomLocation(i) + calcSign * index * phantomDeltas(i);
            end
            
            [point, t] = getPointAlongLineFromOneDimWithinBounds(lineDeltas, linePoint, dim, dimValue, bounds);
            
            if ~isempty(point) && t < minT
                minT = t;
                nextPoint = point;
            end
         end
    end
end


function roundedVal = roundToNanoM(valInM)
   roundOff = 10^8; % within 1nm
   
   roundedVal = round(valInM * roundOff) / roundOff;
end