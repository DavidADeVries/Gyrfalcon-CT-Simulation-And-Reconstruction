function folders = getFolders(path)
% folders = getFolders(path)

entries = dir(path);

folders = {};

for i=1:length(entries)
    entry = entries(i);
    
    if entry.isdir && ~strcmp(entry.name, '.') && ~strcmp(entry.name, '..')
        folders = [folders, {entry.name}];
    end
end



end

