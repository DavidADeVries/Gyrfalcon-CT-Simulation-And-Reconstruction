function bool = matricesEqual(mat1, mat2)
%bool = matricesEqual(mat1, mat2)

dims1 = size(mat1);
dims2 = size(mat2);

if length(dims1) == length(dims2) && all(dims1 == dims2)
    comp = mat1 == mat2;
    
    for i=1:length(dims1)
        comp = all(comp);
    end
    
    bool = comp;
else
    bool = false;
end


end

