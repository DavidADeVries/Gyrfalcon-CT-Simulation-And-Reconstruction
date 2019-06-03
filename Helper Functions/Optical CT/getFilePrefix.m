function prefix = getFilePrefix(path)
%prefix = getFilePrefix(path)

allFilesAndFolders = dir(path);

numEntries = length(allFilesAndFolders);

prefix = '';

for i=1:numEntries
    entry = allFilesAndFolders(i);
    
    if ~entry.isdir
        indices = strfind(entry.name, '_');
        
        prefix = entry.name(1:indices(end));
        break;
    end
end

end

