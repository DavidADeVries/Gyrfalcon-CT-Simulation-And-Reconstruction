classdef InterpolationTypes
    % InterpolationTypes
    % types of interpolation for values
    
    properties
        displayString
    end
    
    enumeration        
        nearestNeighbour ('Nearest Neighbour (No Interpolation)')
        
        linear ('Linear')
        
        cubic ('Cubic Spline')
        
        pchip ('Shape-Prevsering Cubic Spline') %second derivative not continuous
    end
    
    methods(Static)
        function [] = setDropDown(handle)
            [rawItemData,~] = enumeration('InterpolationTypes');
            
            numItems = length(rawItemData);
            
            items = cell(1, numItems);
            itemsData = cell(1, numItems);
            
            for i=1:numItems
                items{i} = rawItemData(i).displayString;
                itemsData{i} = rawItemData(i);
            end
            
            handle.Items = items;
            handle.ItemsData = itemsData;
        end
    end
    
    methods        
        function obj = InterpolationTypes(displayString)
            obj.displayString = displayString;
        end
        
        % zeroBeyondBounds sets the value for x < xvals(1) and x >
        % xvals(end) to 0
        function interp = createInterpForKnownVals(interType, xvals, yvals, zeroBeyondBounds)
            switch interType
                case InterpolationTypes.nearestNeighbour
                    interp = createNearestNeighbourInterp(xvals, yvals);
                case InterpolationTypes.linear
                    interp = createLinearInterp(xvals, yvals);
                case InterpolationTypes.cubic
                    interp = createCubicSplineInterp(xvals, yvals, zeroBeyondBounds);
                case InterpolationTypes.pchip                    
                    interp = createPCHIPInterp(xvals, yvals, zeroBeyondBounds);
                otherwise
                    error('Invalid Interpolation Type!');
            end
            
            if zeroBeyondBounds
                breaks = interp.breaks;
                coefs = interp.coefs;
                
                breaks = [xvals(1) - 1, breaks, xvals(end) + 1]; % using -1 and +1 is arbitrary, any -/+ value would work
                
                dims = size(coefs);
                numTerms = dims(2);
                
                zeroCoeffs = zeros(1, numTerms);
                
                coefs = [zeroCoeffs; coefs; zeroCoeffs]; % set area beyond to 0
                
                interp.breaks = breaks;
                interp.coefs = coefs;
                interp.pieces = interp.pieces + 2;
            end
            
        end
    end
    
end


function interp = createNearestNeighbourInterp(xvals, yvals)

if length(xvals) >= 2
    midpoints = (xvals(1:end-1) + xvals(2:end)) ./ 2;
    
    breaks = [xvals(1) midpoints xvals(end)];
    
    coeffs = yvals;
else
    breaks = xvals;
    coeffs = yvals;
end

interp = mkpp(breaks, coeffs);
    
end

function interp = createLinearInterp(xvals, yvals)

if length(xvals) >= 2
    slopes = (yvals(2:end)  - yvals(1:end-1)) ./ (xvals(2:end) - xvals(1:end-1));
    interps = yvals(1:end-1);%yvals(2:end) - slopes.*xvals(2:end);
    
    coeffs = [slopes' interps'];
    
    breaks = xvals;
else
    breaks = xvals;
    coeffs = yvals;    
end

interp = mkpp(breaks, coeffs);

end

function interp = createCubicSplineInterp(xvals, yvals, zeroBeyondBounds)

if zeroBeyondBounds
    yvals = [0 yvals 0]; %clamp the end
end

interp = spline(xvals, yvals); %thanks MATLAB!

end

function interp = createPCHIPInterp(xvals, yvals, zeroBeyondBounds)

if zeroBeyondBounds
    yvals = [0 yvals 0]; %clamp the end
end

interp = pchip(xvals, yvals);

end