usedFloodFields = false;

gel1Cath_osctv = loadGyrfalconReconForFigures('E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2)\', 57, usedFloodFields);

gel1CathOffset_osctv = loadGyrfalconReconForFigures('E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-2)\', 1, usedFloodFields);

gel3Cath_osctv = loadGyrfalconReconForFigures('E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-3)\', 1, usedFloodFields);

gel5Cath_osctv = loadGyrfalconReconForFigures('E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-4)\', 1, usedFloodFields);

% analysis params
slice = 128;


threshold = [0, 13.4];

ticks = [];

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

root = 'E:\Thesis Figures\Results\OSC-TV\Num Catheters Axial Slices\';

writeSliceImagesFromFigure(...
    [root, '1 Cath.png'],...
    gel1Cath_osctv(:,:,slice),...
    unitConversion, threshold,...
    imageHeightInCm, ticks, colourbarLabel,...
    {}, {}, {}, {}, {});

writeSliceImagesFromFigure(...
    [root, '1 Cath Offset.png'],...
    gel1CathOffset_osctv(:,:,slice),...
    unitConversion, threshold,...
    imageHeightInCm, ticks, colourbarLabel,...
    {}, {}, {}, {}, {});

writeSliceImagesFromFigure(...
    [root, '3 Cath.png'],...
    gel3Cath_osctv(:,:,slice),...
    unitConversion, threshold,...
    imageHeightInCm, ticks, colourbarLabel,...
    {}, {}, {}, {}, {});

writeSliceImagesFromFigure(...
    [root, '5 Cath.png'],...
    gel5Cath_osctv(:,:,slice),...
    unitConversion, threshold,...
    imageHeightInCm, ticks, colourbarLabel,...
    {}, {}, {}, {}, {});

