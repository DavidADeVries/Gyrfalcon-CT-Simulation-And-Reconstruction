function sliceData = phantomInHU(phantomType, dimForPhantom, dimForSlice)
% sliceData = phantomInHU(phantomType, dimForPhantom, dimForSlice)

rawData = phantom(phantomType, dimForPhantom);

airValueInHU = -1000;
boneValueInHU = 3000;

range = boneValueInHU - airValueInHU;

dataInHU = (rawData * range) + airValueInHU;

sliceData = airValueInHU * ones(dimForSlice,dimForSlice);

index = floor((dimForSlice - dimForPhantom) / 2) + 1;

sliceData(index:index+dimForPhantom-1,index:index+dimForPhantom-1) = dataInHU;

end

