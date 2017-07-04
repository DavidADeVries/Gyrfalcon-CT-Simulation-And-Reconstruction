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
        function [] = setDropDown(handle)
            [rawItemData,~] = enumeration('OpticalWavelengthColoursForVistaScanner');
            
            numItems = length(rawItemData);
            
            items = cell(1, numItems);
            itemsData = cell(1, numItems);
            
            for i=1:numItems
                items{i} = [rawItemData(i).displayString, ' (', num2str(rawItemData(i).wavelengthInNm), 'nm)'];
                itemsData{i} = rawItemData(i);
            end
            
            handle.Items = items;
            handle.ItemsData = itemsData;
        end
    end
    
    methods
        function obj = OpticalWavelengthColoursForVistaScanner(displayString, wavelengthInNm)
            obj.displayString = displayString;
            obj.wavelengthInNm = wavelengthInNm;
        end        
    end
    
end

