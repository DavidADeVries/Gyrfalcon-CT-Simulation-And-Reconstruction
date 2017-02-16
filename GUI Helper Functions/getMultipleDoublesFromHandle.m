function values = getMultipleDoublesFromHandle(handle)
%values = getMultipleDoublesFromHandle(handle)
% from a handle, the string is extracted, which can be in two formats:
% 1) 24,60,34,23
%   need to break up the commas
% 2) 0:10:350
%   need to break up the colons

string = get(handle,'String');

values = getValuesFromIntervalString(string);



end

