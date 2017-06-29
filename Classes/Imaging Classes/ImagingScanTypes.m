classdef ImagingScanTypes
    % ImagingScanTypes
    
    properties
        displayString
        imagingScanObject
    end
    
    enumeration
        opticalCT ('Optical CT', OpticalCTImagingScan)
        xrayCT ('X-Ray CT (Not Yet Available', 
    end
    
    methods(Static)
    end
    
    methods
        function obj = OpticalWavelengthColours(displayString, symbol, wavelengthInNm)
            obj.displayString = displayString;
            obj.symbol = symbol;
            obj.wavelengthInNm = wavelengthInNm;
        end        
    end
    
end

