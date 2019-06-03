function [] = proguide4CathProjectionImages()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 6-4)\Slice 1\Angle 0\Position (1,1) Detector Data.mat';

data = load(readPath);

refImage = imtranslate(data.detectorData_I0,[-10,0]);
refImage = refImage(35:35+700, 160:160+700);

readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 6-4)\Slice 1\Angle -2.64\Position (1,1) Detector Data.mat';

data = load(readPath);

dataImage = data.detectorData_I;
dataImage = dataImage(35:35+700, 160:160+700);

lnImage = log(refImage ./ dataImage);

root = 'E:\Thesis Figures\Results\HDR\ProGuide (4 Cath)\';

unitConversion = 1;
threshold = [0, 2^16];
imageHeightInCm = 4.5;
ticks = [];
colourbarLabel = 'N/A';

writeSliceImagesFromFigure(...
    [root, 'Ref Projection.png'],...
    refImage,...
    unitConversion, threshold,...
    imageHeightInCm, ticks, colourbarLabel,...
    {}, {}, {}, {}, {});

writeSliceImagesFromFigure(...
    [root, 'Data Projection.png'],...
    dataImage,...
    unitConversion, threshold,...
    imageHeightInCm, ticks, colourbarLabel,...
    {}, {}, {}, {}, {});

writeSliceImagesFromFigure(...
    [root, 'Ln Ratio Projection.png'],...
    lnImage,...
    unitConversion, [],...
    imageHeightInCm, ticks, colourbarLabel,...
    {}, {}, {}, {}, {});

end

