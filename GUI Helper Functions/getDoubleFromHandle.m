function double = getDoubleFromHandle(handle)
% double = getDoubleFromHandle(handle)
% gets a double value from a handle that has a 'String' element

string = get(handle, 'String');

double = str2double(string);


end

