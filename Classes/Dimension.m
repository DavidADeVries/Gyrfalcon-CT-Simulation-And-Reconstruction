classdef Dimension
    % Dimension
    % This class is a general purpose class to store the dimensions of
    % something, specifically being able store units as well
    
    properties
        value
        units
    end
    
    methods
        function dimension = Dimension(value, units)
            dimension.value = value;
            dimension.units = units;
        end

        function bool = equal(dim1, dim2)
            b1 = dim1.value == dim2.value;
            b2 = dim1.units == dim2.units;

            bool = b1 && b2;
        end
                
        function dimLength = getLengthInM(dimension, varargin)
            %will give length of dimensions in m, for angular dimensions,
            % the arclength will be given, with respect to the rotation origin (second parameter)
            % and rotation origin units (third parameter)
            
            if dimension.units.isAngular
                radius = varargin{1};
                radiusUnits = varargin{2};
                
                radius = Dimension(radius, radiusUnits);
                radiusInM = radius.getLengthInM();
                
                switch dimension.units
                    case Units.radian
                        dimLength = sqrt((1-cos(dimension.value))*2*radiusInM^2);
                    case Units.degree
                        dimLength = sqrt((1-cosd(dimension.value))*2*radiusInM^2);
                    otherwise
                        error('Invalid unit!');
                end
            else
                switch dimension.units
                    case Units.mm
                        dimLength = dimension.value * Constants.mm_to_m;
                    case Units.m
                        dimLength = dimension.value;
                    otherwise
                        error('Invalid unit!');
                end
            end
        end
        
        function dimension = setValueFromLengthInM(dimension, lengthInM, varargin)
            %will give length of dimensions in m, for angular dimensions,
            % the arclength will be given, with respect to the rotation origin (second parameter)
            % and rotation origin units (third parameter)
            
            if dimension.units.isAngular
                radius = varargin{1};
                radiusUnits = varargin{2};
                
                radius = Dimension(radius, radiusUnits);
                radiusInM = radius.getLengthInM();
                
                switch dimension.units
                    case Units.radian
                        value = acos(1-((lengthInM^2)/(2*radiusInM^2)));
                    case Units.degree
                        value = acosd(1-((lengthInM^2)/(2*radiusInM^2)));
                    otherwise
                        error('Invalid unit!');
                end
            else
                value = dimension.units.convertFromM(lengthInM);                
            end
            
            dimension.value = value;
        end
        
        function angle = getAngleInDegrees(dimension)
            if dimension.units.isAngular
                switch dimension.units
                    case Units.degree
                        angle = dimension.value;
                    case Units.radian
                        angle = dimension.value * Constants.rad_to_deg;
                    otherwise
                        error('Invalid unit!');
                end
            else
                error('Unit not angular');
            end
        end
        
        function value = getValueInSIUnits(dimension)
            if dimension.units.isAngular
                value = dimension.getAngleInDegrees();
            else
                value = dimension.getLengthInM();
            end
        end
        
    end
    
end

