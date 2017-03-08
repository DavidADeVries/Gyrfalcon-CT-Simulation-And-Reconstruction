function handles = getPhantomPlotCoords(phantomDataInHU, phantomDimsInM, phantomLocationInM, axesHandle)
            
dims = size(phantomDataInHU);

numX = dims(2);
numY = dims(1);
numZ = dims(3);

xStart = phantomLocationInM(1);
xEnd = xStart + numX*phantomDimsInM(1);
xMiddle = mean([xStart xEnd]);

yzSliceValues = [xStart, xMiddle, xEnd];
yzSliceIndices = [1 round((numX-1)/2) numX];

yEnd = phantomLocationInM(2);
yStart = yEnd - numY*phantomDimsInM(2);
yMiddle = mean([yStart yEnd]);

xzSliceValues = [yStart, yMiddle, yEnd];
xzSliceIndices = [1 round((numY-1)/2) numY];

zEnd = phantomLocationInM(3);
zStart = zEnd - numZ*phantomDimsInM(3);
zMiddle = mean([zStart zEnd]);

xySliceValues = [zStart, zMiddle, zEnd];
xySliceIndices = [numZ round((numZ-1)/2) 1];

% calc xy slices
numXYSlices = length(xySliceValues);
xySlicesData = cell(numXYSlices,1);
xySlicesZCoords = cell(numXYSlices,1);

minXY = inf;
maxXY = -inf;

for i=1:numXYSlices
    xySlicesData{i} = squeeze(phantomDataInHU(:,:,xySliceIndices(i)));
    
    dims = size(xySlicesData{i});
    xySlicesZCoords{i} = xySliceValues(i) * ones(dims + 1);
    
    minXY = min([minXY allMin(xySlicesData{i})]);
    maxXY = max([maxXY allMax(xySlicesData{i})]);
end

% calc xz slices
numXZSlices = length(xzSliceValues);
xzSlicesData = cell(numXZSlices,1);
xzSlicesYCoords = cell(numXZSlices,1);

minXZ = inf;
maxXZ = -inf;

for i=1:numXZSlices
    xzSlicesData{i} = imrotate(squeeze(phantomDataInHU(xzSliceIndices(i),:,:)),90);
    
    dims = size(xzSlicesData{i});
    xzSlicesYCoords{i} = xzSliceValues(i) * ones(dims + 1);
    
    minXZ = min([minXZ allMin(xzSlicesData{i})]);
    maxXZ = max([maxXZ allMax(xzSlicesData{i})]);
end

% calc yz slices
numYZSlices = length(yzSliceValues);
yzSlicesData = cell(numYZSlices,1);
yzSlicesXCoords = cell(numYZSlices,1);

minYZ = inf;
maxYZ = -inf;

for i=1:numYZSlices
    yzSlicesData{i} = imrotate(squeeze(phantomDataInHU(:,yzSliceIndices(i),:)),90);
    
    dims = size(yzSlicesData{i});
    yzSlicesXCoords{i} = yzSliceValues(i) * ones(dims + 1);
    
    minYZ = min([minYZ allMin(yzSlicesData{i})]);
    maxYZ = max([maxYZ allMax(yzSlicesData{i})]);
end

% apply contrast
lowHU = min([minXY, minXZ, minYZ]);
highHU = max([maxXY, maxXZ, maxYZ]);

window = [lowHU, highHU];
grayscaleMax = 1;


for i=1:numXYSlices
    xySlicesData{i} = applyContrastToMaximizeGrayscale(xySlicesData{i}, window, grayscaleMax);
end

for i=1:numXZSlices
    xzSlicesData{i} = applyContrastToMaximizeGrayscale(xzSlicesData{i}, window, grayscaleMax);
end

for i=1:numYZSlices
    yzSlicesData{i} = applyContrastToMaximizeGrayscale(yzSlicesData{i}, window, grayscaleMax);
end

% prep coords
[xySliceXCoords, xySliceYCoords] = meshgrid(xStart:phantomDimsInM(1):xEnd, yStart:phantomDimsInM(2):yEnd);

[xzSliceXCoords, xzSliceZCoords] = meshgrid(xStart:phantomDimsInM(1):xEnd, zStart:phantomDimsInM(3):zEnd);

[yzSliceYCoords, yzSliceZCoords] = meshgrid(yStart:phantomDimsInM(2):yEnd, zStart:phantomDimsInM(3):zEnd);


hold(axesHandle,'on');


xyHandles = plotSlices(xySliceXCoords, xySliceYCoords, xySlicesZCoords, axesHandle, xySlicesData);

xzHandles = plotSlices(xzSliceXCoords, xzSlicesYCoords, xzSliceZCoords, axesHandle, xzSlicesData);

yzHandles = plotSlices(yzSlicesXCoords, yzSliceYCoords, yzSliceZCoords, axesHandle, yzSlicesData);


boxHandles = plotBox([xStart xEnd], [yStart yEnd], [zStart zEnd], axesHandle, 'w');


handles = [xyHandles, xzHandles, yzHandles, boxHandles];


end


function [zValues, sliceIndices] = calcXYSliceValues(zStart, zEnd, numZ)
    sliceSpacing = Constants.Phantom_Plot_Z_Slices_Spacing;
    
    numSlices = (zEnd - zStart) / sliceSpacing;
    
    if numSlices > numZ || numSlices < 3
        numSlices = numZ + 1;        
    end
    
    xForOdd = floor((numSlices - 1)/2);
    
    numSlices = 2*xForOdd + 1;
        
    zValues = linspace(zStart, zEnd, numSlices);
    
    toIndexCalc1 = zValues - zStart;
    
    toIndexCalc2 = toIndexCalc1 / (zEnd - zStart);
    
    toIndexCalc3 = (-toIndexCalc2 + 1) * (numZ - 1);
    
    toIndexCalc4 = toIndexCalc3 + 1;
    
    sliceIndices = round(toIndexCalc4);
end
