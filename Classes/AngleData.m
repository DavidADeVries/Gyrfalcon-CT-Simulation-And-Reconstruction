classdef AngleData
    % AngleData
    % Holds data for an angle from a simulation run        
    %
    % *PositionData
    % for each angle, there are multiple potential source positions, held
    % in a cell array each holding a PositionData class data type
    %
    % *Angle
    % the angle (in degrees) at which the angle data was collected at
   
    
    properties
        positionData
        angle
    end
    
    methods
        function data = AngleData(positionData, angle)
            data.positionData = positionData;
            data.angle = angle;
        end
    end
    
end

