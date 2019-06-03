function [] = setDropDownOptions(dropDownHandle, enumerations, enumerationDisplayStringField)
%[] = setDropDownOptions(dropDownHandle, enumerations, enumerationDisplayStringField)

numEnumerations = length(enumerations);

items = cell(numEnumerations,1);
itemsData = cell(numEnumerations,1);

for i=1:numEnumerations
    items{i} = enumerations(i).(enumerationDisplayStringField);
    itemsData{i} = enumerations(i);
end

dropDownHandle.Items = items;
dropDownHandle.ItemsData = itemsData;

end

