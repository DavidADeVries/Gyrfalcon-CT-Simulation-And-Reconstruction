function [] = setPopupMenu(handle, enumString, defaultSelection)
% [] = setPopupMenu(handle, enumString, defaultSelection)
% set popup menu selections and default selection

enumChoices = enumeration(enumString);

len = length(enumChoices);

choices = cell(len,1);

for i=1:len
    enum = enumChoices(i);
    
    choices{i} = enum.displayString;
    
    if defaultSelection == enum
        value = i;
    end
end

set(handle, 'String', choices, 'Value', value);

end

