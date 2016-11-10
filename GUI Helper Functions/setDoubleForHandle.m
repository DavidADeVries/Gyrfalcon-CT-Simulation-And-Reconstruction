function [] = setDoubleForHandle(handle, value)
% [] = setDoubleForHandle(handles, value)
% takes numerical value and sets it in the 'String' field

string = num2str(value);

setString(handle, string);


end

