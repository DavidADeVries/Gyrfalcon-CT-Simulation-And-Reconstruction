classdef InterpolationTypes3D
    % InterpolationTypes3D
    % types of interpolation for values for 3D interpolation
    
    properties
        displayString
        matlabTypeString
    end
    
    enumeration        
        nearestNeighbour (...
            'Nearest Neighbour (No Interpolation)',...
            'nearest')
        
        linear (...
            'Linear',...
            'linear')
        
        cubic (...
            'Cubic',...
            'cubic')
        
        spline (...
            'Spline',...
            'spline') 
    end
    
    methods        
        function obj = InterpolationTypes3D(displayString, matlabString)
            obj.displayString = displayString;
            obj.matlabTypeString = matlabString;
        end
        
        function string = getMatlabString(interType)
            string = interType.matlabTypeString;
        end
    end
    
end


