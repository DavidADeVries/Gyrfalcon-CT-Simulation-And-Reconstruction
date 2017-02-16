function trimmed = removeFileExtension(string)
%trimmed = removeFileExtension(string)

indices = strfind(string,'.');

dotIndex = indices(length(indices)); %get last index of .

trimmed = string(1:dotIndex-1);


end

