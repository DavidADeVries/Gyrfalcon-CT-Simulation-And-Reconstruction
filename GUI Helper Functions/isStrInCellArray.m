function  bool = isStrInCellArray(cellArray, string)
% bool = isStrInCellArray(cellArray, string)

bool = false;

for i=1:length(cellArray)
    if strcmp(cellArray{i}, string)
        bool = true;
        break;
    end
end

end

