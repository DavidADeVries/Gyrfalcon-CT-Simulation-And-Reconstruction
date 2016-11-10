function [] = setSelectionForPopupMenu(handle, enumString, selection)
% [] = setSelectionForPopupMenu(handle, enumString, selection)
% for the popupmenu handle given, it is set to be selected to 'selection'

selections = enumeration(enumString);

for i=1:length(selections)
    if selections(i) == selection
        value = i;
        break;
    end
end

set(handle, 'Value', value);

end

