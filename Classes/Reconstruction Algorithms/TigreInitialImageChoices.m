classdef TigreInitialImageChoices
    % TigreInitialImageChoices
    
    properties
        displayString
        tigreString
    end
    
    enumeration
        none ('None', 'none')
        fdk ('FDK Solution', 'FDK')
        multipleResolution ('Multiple Resolution', 'multigrid')
    end
        
    methods
        function obj = TigreInitialImageChoices(displayString, tigreString)
            obj.displayString = displayString;
            obj.tigreString = tigreString;
        end        
    end
    
end

