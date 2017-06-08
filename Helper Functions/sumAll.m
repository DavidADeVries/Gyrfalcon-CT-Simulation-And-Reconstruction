function totalSum = sumAll(m)
% totalSum = sumAll(m)

dims = size(m);

nDims = length(dims);

totalSum = m;

for i=1:nDims
    totalSum = sum(totalSum);
end


end

