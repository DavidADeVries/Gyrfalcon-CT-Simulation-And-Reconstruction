usedFloodFields = false;

gel500MU_osctv = loadGyrfalconReconForFigures('E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-2)\', 1, usedFloodFields);

gel1500MU_osctv = loadGyrfalconReconForFigures('E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-4)\', 51, usedFloodFields);

gel2000MU_osctv = loadGyrfalconReconForFigures('E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2)\', 54, usedFloodFields);

gel2500MU_osctv = loadGyrfalconReconForFigures('E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-4)\', 1, usedFloodFields);

% analysis params
slice = 128;

threshold500MU = [0, 2.9];
threshold1500MU = [0, 9.7];
threshold2000MU = [0, 13.4];
threshold2500MU = [0, 16.5];

ticks500MU = [];%[0:0.5:2.5, 2.9];
ticks1500MU = [];%[0:2:8, 9.7];
ticks2000MU = [];%[0:3:12, 13.4];
ticks2500MU = [];%[0:4:16, 16.5];

colourbarLabel = '$\Delta\mu$ $[cm^{-1}]$';


imageHeightInCm = 2.2;

unitConversion = 1/100; % m-1 to cm-1

lineColours = {...
    };

lineStyles = {...
   };

lineWidths = {};

legendLabels = {...
    };

voxelDimInMM = 0.5;

lineProfilePlotDimsInCm = [7,7];
lineProfileXAxis = 'Position $[mm]$';
lineProfileYAxis = '$\Delta\mu$ $[cm^{-1}]$';

noShift = [0 0];


%% Write images

root = 'E:\Thesis Figures\Results\OSC-TV\Dose Level Axial Slices\';

writeSliceImagesFromFigure(...
    [root, '500MU Catheter.png'],...
    gel500MU_osctv(:,:,slice),...
    unitConversion, threshold500MU,...
    imageHeightInCm, ticks500MU, colourbarLabel,...
    {}, {}, {}, {}, {});

writeSliceImagesFromFigure(...
    [root, '1500MU Catheter.png'],...
    gel1500MU_osctv(:,:,slice),...
    unitConversion, threshold1500MU,...
    imageHeightInCm, ticks1500MU, colourbarLabel,...
    {}, {}, {}, {}, {});


writeSliceImagesFromFigure(...
    [root, '2000MU Catheter.png'],...
    gel2000MU_osctv(:,:,slice),...
    unitConversion, threshold2000MU,...
    imageHeightInCm, ticks2000MU, colourbarLabel,...
    {}, {}, {}, {}, {});


writeSliceImagesFromFigure(...
    [root, '2500MU Catheter.png'],...
    gel2500MU_osctv(:,:,slice),...
    unitConversion, threshold2500MU,...
    imageHeightInCm, ticks2500MU, colourbarLabel,...
    {}, {}, {}, {}, {});

