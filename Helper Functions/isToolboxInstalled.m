function bool = isToolboxInstalled(toolboxString)
% bool = isToolboxInstalled(toolboxString)

toolboxes = ver;

bool = false;

for i=1:length(toolboxes)
    entry = toolboxes(i);
    
    if strcmp(entry.Name, toolboxString)
        bool = true;
        break;
    end
end



end

