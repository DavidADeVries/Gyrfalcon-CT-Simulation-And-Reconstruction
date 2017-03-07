function bool = gyrfalconObjectsEqual(object1, object2)
% bool = gyrfalconObjectsEqual(object1, object2)

if isempty(object1) && isempty(object2)
    bool = true;
elseif ~isempty(object1) && ~isempty(object2)
    if object1.saveInSeparateFile && object2.saveInSeparateFile
        if strcmp(object1.getPath(), object2.getPath());
            
            data1 = load(object1.getPath());
            object1 = data1.object;
            
            data2 = load(object2.getPath());
            object2 = data2.object;
            
            bool = object1.equal(object2);
        else
            bool = false;
        end
    elseif ~object1.saveInSeparateFile && ~object2.saveInSeparateFile
        bool = object1.equal(object2);
    else
        bool = false;
    end
else
    bool = false;
end


end

