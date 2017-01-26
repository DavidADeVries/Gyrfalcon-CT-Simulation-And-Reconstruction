function dataSet = generate3DPhantomSphere(dim)
%dataSet = generate3DPhantomSphere(dim)

radius = dim/2;

dataSet = zeros(dim,dim,dim);

for i=1:dim %through slices
    height = round(abs(radius-i));
    
    radiusForSlice = round(sqrt(radius^2 - height^2));
    
    dimForSlice = radiusForSlice * 2;
    
    sliceData = phantom('Modified Shepp-Logan',dimForSlice);
    
    dataSetIndex = ceil((dim - dimForSlice + 1)/2);
    
    dataSet(...
        dataSetIndex:dataSetIndex+dimForSlice-1,...
        dataSetIndex:dataSetIndex+dimForSlice-1,...
        i) = sliceData ;
    
    
end


end

