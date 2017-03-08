function bool = dimensionMatricesEqual(mat1, mat2)
%bool = dimensionMatricesEqual(mat1, mat2)

dims1 = size(mat1);
dims2 = size(mat2);

if length(dims1) == length(dims2) && all(dims1 == dims2)
    comp = true;
    
    for i=1:length(dims1)
        comp = comp && equal(mat1(i), mat2(i));
    end
    
    bool = comp;
else
    bool = false;
end


end

