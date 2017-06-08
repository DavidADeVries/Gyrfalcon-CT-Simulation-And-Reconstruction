function minVal = allMin(data)
%minVal = allMin(data)

dims = size(data);

minVal = data;

for i=1:length(dims)
    minVal = min(minVal);
end


end

