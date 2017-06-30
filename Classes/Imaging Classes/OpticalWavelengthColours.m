classdef OpticalWavelengthColoursForVistaScanner
    % OpticalWavelengthColoursForVistaScanner
    
    properties
        displayString
        wavelengthInNm % in nm
    end
    
    enumeration
        red('Red', 650);
        amber('Amber', 585);
    end
    
    methods(Static)
    end
    
    methods
        function obj = OpticalWavelengthColours(displayString, wavelengthInNm)
            obj.displayString = displayString;
            obj.wavelengthInNm = wavelengthInNm;
        end        
    end
    
end

