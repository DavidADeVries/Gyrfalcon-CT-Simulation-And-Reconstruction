classdef TigreFilterTypes
    % TigreFilterTypes
    % types of filter for TIGRE reconstructions
    
    properties
        displayString
        tigreString
    end
    
    enumeration     
        ramLakFilter ('Ram-Lak Filter', 'ram-lak')
        
        sheppLoganFilter ('Shepp-Logan Filter', 'shepp-logan')
        
        cosineFilter ('Cosine Filter', 'cosine')
        
        hammingWindowFilter ('Hamming Window Filter', 'hamming')
        
        hannWindowFilter ('Hann Window Filter', 'hann')
        
    end
    
    methods
        function obj = TigreFilterTypes(displayString, tigreString)
            obj.displayString = displayString;
            obj.tigreString = tigreString;
        end
        
    end
    
end

