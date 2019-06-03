classdef TigreOrderStrategies
    % TigreOrderStrategies
    
    properties
        displayString
        tigreString
    end
    
    enumeration
        ordered ('Ordered', 'ordered')
        random ('Random', 'random')
        angularDistance ('Angular Distance', 'angularDistance')
    end
        
    methods
        function obj = TigreOrderStrategies(displayString, tigreString)
            obj.displayString = displayString;
            obj.tigreString = tigreString;
        end        
    end
    
end

