function trimmed = removeFileExtension(string)
%trimmed = removeFileExtension(string)

if ~isempty(string)
indices = strfind(string,'.');

dotIndex = indices(length(indices)); %get last index of .

trimmed = string(1:dotIndex-1);
else
    trimmed = '';
end


end

