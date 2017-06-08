function maxVal = allMax(data)
%maxVal = allMax(data)

dims = size(data);

maxVal = data;

for i=1:length(dims)
    maxVal = max(maxVal);
end


end

