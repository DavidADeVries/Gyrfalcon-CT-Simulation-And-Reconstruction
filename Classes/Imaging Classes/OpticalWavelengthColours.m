classdef OpticalWavelengthColours
    % OpticalWavelengthColours
    % contains colours of wavelengths of light
    % just RGB for now
    
    properties
        displayString
        symbol
        wavelengthInNm % in nm
    end
    
    enumeration
        red('red', 'R', 650);
        green('green', 'G', 510);
        blue('blue', 'B', 440);
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
