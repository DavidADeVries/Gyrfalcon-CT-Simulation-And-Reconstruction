classdef FirstGenFilterTypes
    % FirstGenFilterTypes
    % types of filter for first generation reconstruction
    
    properties
        name
    end
    
    enumeration
        rampFilter ('Ramp Filter (Ram-Lak)')
        
        sheppLoganFilter ('Shepp-Logan Filter (Sinc)')
        
        CosineFilter ('Cosine Filter')
        
        HammingWindowFilter ('Hamming Window Filter')
        
        HannWindowFilter ('Hann Window Filter')
        
        none ('None')
    end
    
    methods
        
    end
    
end

