function dateTimeString = convertTimestampToString(timestamp)
%dateTimeString = convertTimestampToString(timestamp)

format = 'mmm dd, yyyy HH:MM:SS';

dateTimeString = datestr(timestamp, format);

end

