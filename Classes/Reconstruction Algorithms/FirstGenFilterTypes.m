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
    
    methods(Static)
        function [] = setDropDown(handle)
            [rawItemData,~] = enumeration('FirstGenFilterTypes');
            
            numItems = length(rawItemData);
            
            items = cell(1, numItems);
            itemsData = cell(1, numItems);
            
            for i=1:numItems
                items{i} = rawItemData(i).displayString;
                itemsData{i} = rawItemData(i);
            end
            
            handle.Items = items;
            handle.ItemsData = itemsData;
        end
    end
    
    methods
        function obj = FirstGenFilterTypes(displayString)
            obj.displayString = displayString;
        end
        
    end
    
end

