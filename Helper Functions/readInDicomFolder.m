function dataSet = readInDicomFolder(filename, numSlices)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

baseFile = dicomread([filename,' (1).dcm']);

dims = size(baseFile);

dataSet = zeros(dims(1),dims(2),numSlices);

for i=1:numSlices
    readFile = [filename,' (',num2str(i),').dcm'];
    
    rawData = dicomread(readFile);
    info = dicominfo(readFile);
    
    rescaleSlope = info.RescaleSlope;
    rescaleIntercept = info.RescaleIntercept;
    
    rawData = rescaleSlope*rawData + rescaleIntercept;
    
    dataSet(:,:,i) = double(rawData);

end

