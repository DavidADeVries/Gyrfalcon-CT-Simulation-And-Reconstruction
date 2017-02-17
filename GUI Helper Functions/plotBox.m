function [ handles ] = plotBox(xVals, yVals, zVals, axesHandle, lineColour)
%[ handles ] = plotBox(xVals, yVals, zVals, axesHandle, lineColour)

handles = {};

for i=1:2
    yVal = yVals(i);
    
    for j=1:2
        zVal = zVals(j);
        
        handle = line(xVals, [yVal yVal], [zVal zVal], 'Parent', axesHandle, 'Color', lineColour);
        
        handles = [handles, {handle}];
    end
end

for i=1:2
    xVal = xVals(i);
    
    for j=1:2
        zVal = zVals(j);
        
        handle = line([xVal xVal], yVals, [zVal zVal], 'Parent', axesHandle, 'Color', lineColour);
        
        handles = [handles, {handle}];
    end
end

for i=1:2
    xVal = xVals(i);
    
    for j=1:2
        yVal = yVals(j);
        
        handle = line([xVal xVal], [yVal yVal], zVals, 'Parent', axesHandle, 'Color', lineColour);
        
        handles = [handles, {handle}];
    end
end
        


end

