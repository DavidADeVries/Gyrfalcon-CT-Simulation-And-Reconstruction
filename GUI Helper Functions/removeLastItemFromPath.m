function trimmedPath = removeLastItemFromPath(path)
%lastItem = removeLastItemFromPath(path)

indices = strfind(path, Constants.Slash);

if isempty(indices)
    trimmedPath = path;
else
    trimmedPath = path(1:indices(end)-1);
end

end

