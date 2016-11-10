function selection = getSelectionFromPopupMenu(handle, enumString)
%selection = getSelectionFromPopupMenu(handle, enumString)
% for a popup menu set-up from a enumeration, now get the choice back out
% of it

allSelections = enumeration(enumString);

choiceValue = get(handle, 'Value');

selection = allSelections(choiceValue);


end

