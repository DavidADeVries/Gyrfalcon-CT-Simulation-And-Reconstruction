function handles = getPhantomPlotCoords(phantomDataInHU, phantomDimsInM, phantomLocationInM, axesHandle)
            
dims = size(phantomDataInHU);

numX = dims(2);
numY = dims(1);
numZ = dims(3);

xStart = phantomLocationInM(1);
xEnd = xStart + numX*phantomDimsInM(1);
xMiddle = mean([xStart xEnd]);

yEnd = phantomLocationInM(2);
yStart = yEnd - numY*phantomDimsInM(2);
yMiddle = mean([yStart yEnd]);

zEnd = phantomLocationInM(3);
zStart = zEnd - numZ*phantomDimsInM(3);
zMiddle = mean([zStart zEnd]);

xySliceData = squeeze(phantomDataInHU(:,:,ceil(numZ/2)));
xzSliceData = squeeze(phantomDataInHU(ceil(numY/2),:,:))';
yzSliceData = squeeze(phantomDataInHU(:,ceil(numX/2),:))';

lowHU = min([allMin(xySliceData), allMin(xzSliceData), allMin(yzSliceData)]);
highHU = max([allMax(xySliceData), allMax(xzSliceData), allMax(yzSliceData)]);

window = [lowHU, highHU];
grayscaleMax = 1;

xySliceData = applyContrastToMaximizeGrayscale(xySliceData, window, grayscaleMax);
xzSliceData = applyContrastToMaximizeGrayscale(xzSliceData, window, grayscaleMax);
yzSliceData = applyContrastToMaximizeGrayscale(yzSliceData, window, grayscaleMax);

[xySliceXCoords, xySliceYCoords] = meshgrid(xStart:phantomDimsInM(1):xEnd, yStart:phantomDimsInM(2):yEnd);
xySliceZCoords = zMiddle * ones(size(xySliceXCoords));

[xzSliceXCoords, xzSliceZCoords] = meshgrid(xStart:phantomDimsInM(1):xEnd, zStart:phantomDimsInM(3):zEnd);
xzSliceYCoords = yMiddle * ones(size(xzSliceXCoords));

[yzSliceYCoords, yzSliceZCoords] = meshgrid(yStart:phantomDimsInM(2):yEnd, zStart:phantomDimsInM(3):zEnd);
yzSliceXCoords = xMiddle * ones(size(yzSliceYCoords));

hold(axesHandle,'on');

xyHandle = surf(...
    xySliceXCoords, xySliceYCoords, xySliceZCoords, ones([size(xySliceData),3]),...
    'Parent', axesHandle, 'EdgeColor', 'none');
alpha(xyHandle, xySliceData);

xzHandle = surf(...
    xzSliceXCoords, xzSliceYCoords, xzSliceZCoords, ones([size(xzSliceData),3]),...
    'Parent', axesHandle, 'EdgeColor', 'none');
alpha(xzHandle, xzSliceData);

yzHandle = surf(...
    yzSliceXCoords, yzSliceYCoords, yzSliceZCoords, ones([size(yzSliceData),3]),...
    'Parent', axesHandle, 'EdgeColor', 'none');
alpha(yzHandle, yzSliceData);

boxHandles = plotBox([xStart xEnd], [yStart yEnd], [zStart zEnd], axesHandle, 'w');

boxHandles2 = plotBox(...
    [xStart xStart+10*phantomDimsInM(1)],...
    [yEnd yEnd-10*phantomDimsInM(2)],...
    [zEnd zEnd-10*phantomDimsInM(2)],...
    axesHandle, 'w');

handles = {};%{xyHandle, xzHandle, yzHandle, boxHandle};


end

