function [] = setMultipleDoublesForHandle(handle, values)
%[] = setMultipleDoublesForHandle(handle, values)
% the handle's 'String' value is set by deconstructing the values

numValues = length(values);

string = '';

if numValues > 2 % can possible be in the interval notation
    interval = values(2) - values(1);
    
    intervalsConsistent = true;
    
    for i=1:numValues-1
        if (values(i+1) - values(i)) ~= interval
            intervalsConsistent = false;
            break;
        end
    end
    
    if intervalsConsistent
        begin = num2str(values(1));
        inter = num2str(interval);
        last = num2str(values(numValues));
        
        colon = ':';
        
        string = [begin, colon, inter, colon, last];
    end
end

if isempty(string) % hasn't been matched up with a pattern yet, so do comma separated
    comma = ',';
    
    for i=1:numValues
        string = [string, num2str(values(i))];
        
        if i ~= numValues
            string = [string, comma];
        end
    end
end

% set string

handle.Value = string;


end

