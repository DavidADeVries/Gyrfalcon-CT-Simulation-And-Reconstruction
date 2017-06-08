function lastItem = getLastItemFromPath(path)
%lastItem = getLastItemFromPath(path)

indices = strfind(path, Constants.Slash);

if isempty(indices)
    lastItem = path;
else
    lastItem = path(indices(end)+1:end);
end

end

