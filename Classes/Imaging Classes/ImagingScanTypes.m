classdef ImagingScanTypes
    % ImagingScanTypes
    
    properties
        displayString
        imagingScanObject
    end
    
    enumeration
        opticalCT ('Optical CT', OpticalCTImagingScan)
        xrayCT ('X-Ray CT (Not Yet Available)', XrayCTImagingScan);
    end
    
    methods(Static)
        function [] = setDropDown(handle)
            [rawItemData,~] = enumeration('ImagingScanTypes');
            
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
        function obj = ImagingScanTypes(displayString, imagingScanObject)
            obj.displayString = displayString;
            obj.imagingScanObject = imagingScanObject;
        end        
    end
    
end

