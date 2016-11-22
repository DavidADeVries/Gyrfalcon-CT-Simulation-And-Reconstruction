function [] = deleteHandles(plotHandles)
% [] = deleteHandles(plotHandles)
% deletes the cell array of handles given

for i=1:length(plotHandles)
    handle = plotHandles{i};
    
    delete(handle);
end


end

