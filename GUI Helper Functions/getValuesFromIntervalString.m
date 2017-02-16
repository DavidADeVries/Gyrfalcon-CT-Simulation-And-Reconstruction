function values = getValuesFromIntervalString(string)
% values = getValuesFromIntervalString(string)
% from a string, values are extracted, which can be in two formats:
% 1) 24,60,34,23
%   need to break up the commas
% 2) 0:10:350
%   need to break up the colons

comma = ',';
colon = ':';

commaIndices = strfind(string, comma);
colonIndices = strfind(string, colon);

if ~isempty(commaIndices) && isempty(colonIndices) % comma separated values
    split = strsplit(string, comma);
    
    values = [];
    
    for i=1:length(split)
        substring = split{i};
        cleanedSubstring = strtrim(substring);
        
        if ~isempty(cleanedSubstring)
            values = [values, str2double(cleanedSubstring)];
        end
    end
elseif isempty(commaIndices) && ~isempty(colonIndices)
    split = strsplit(string, colon);
    
    len = length(split);
    
    if len == 2 || len == 3
        if len == 3
            interval = str2double(strtrim(split{2}));
        else
            interval = 1;
        end
        
        begin = str2double(strtrim(split{1}));
        final = str2double(strtrim(split{len}));
        
        values = begin:interval:final;
    else
        error('Interval range must contain 2 or 3 values');
    end
    
else
    values = str2double(strtrim(string));
end

end

