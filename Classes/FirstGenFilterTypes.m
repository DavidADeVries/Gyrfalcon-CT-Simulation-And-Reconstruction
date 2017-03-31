classdef FirstGenFilterTypes
    % FirstGenFilterTypes
    % types of filter for first generation reconstruction
    
    properties
        displayString
    end
    
    enumeration        
        sheppLoganFilter ('Shepp-Logan Filter (Sinc)')
        
        cosineFilter ('Cosine Filter')
        
        hammingWindowFilter ('Hamming Window Filter')
        
        hannWindowFilter ('Hann Window Filter')
        
        none ('None')
    end
    
    methods
        function obj = FirstGenFilterTypes(displayString)
            obj.displayString = displayString;
        end
        
    end
    
end

