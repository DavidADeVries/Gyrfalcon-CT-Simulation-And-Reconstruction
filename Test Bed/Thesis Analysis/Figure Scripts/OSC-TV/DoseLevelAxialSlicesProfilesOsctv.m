usedFloodFields = false;

%gel500MU_osctv = loadGyrfalconReconForFigures('E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-2)\', 1, usedFloodFields);

gel1500MU_osctv = loadGyrfalconReconForFigures('E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-4)\', 1, usedFloodFields);

gel1500MU_control = loadOpticalCtVistaRecon('E:\Thesis Recon Data\Gel 2-3\Gel 2-3_HR.vff');
gel1500MU_fdk = loadOpticalCtVistaRecon('E:\Thesis Recon Data\Gel 2-4\Gel 2-4_HR.vff');

%gel2000MU_osctv = loadGyrfalconReconForFigures('E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2)\', 54, usedFloodFields);

%gel2500MU_osctv = loadGyrfalconReconForFigures('E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-4)\', 1, usedFloodFields);

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


imageHeightInCm = 2.5;

unitConversion = 1/100; % m-1 to cm-1


profile1_X = [44 216];
profile1_Y = [67 186];

profile2_X = [59 228];
profile2_Y = [47 164];

% profile1_X = [1 256];
% profile1_Y = [128 128];
% 
% profile2_X = [128 128];
% profile2_Y = [1 256];


lineColours = {...
    [1 0 0],...
    [0 0 1],...
    [0 0 0]};

lineStyles = {...
    '-',...
    '-',...
    '--'};

lineWidths = {1, 1, 1};

legendLabels = {...
    'FDK',...
    'OSC-TV',...    
    'Control'};

voxelDimInMM = 0.5;

lineProfilePlotDimsInCm = [7.5,7.5];
lineProfileXAxis = 'Position $[mm]$';
lineProfileYAxis = '$\Delta\mu$ $[cm^{-1}]$';

noShift = [0 0];


%% Write images

root = 'E:\Thesis Figures\Results\OSC-TV\Profiles\';

writeSliceImagesFromFigure(...
    [root, '1500MU Catheter.png'],...
    gel1500MU_osctv(:,:,slice),...
    unitConversion, threshold1500MU,...
    imageHeightInCm, ticks1500MU, colourbarLabel,...
    {profile1_X, profile2_X}, {profile1_Y, profile2_Y}, {[1 0 0],[1 0 0]}, {'-','-'}, {2,2});

yLims = [-0.025, 0.145];

takeAndPlotLineProfiles(...
    [root, '1500MU Catheter Profiles 1.png'],...
    {gel1500MU_fdk, gel1500MU_osctv, gel1500MU_control},...
    {noShift, noShift, [-1,-1]},...
    unitConversion, slice,...
    profile1_X, profile1_Y, voxelDimInMM,...
    lineProfilePlotDimsInCm, yLims,...
    lineProfileXAxis, lineProfileYAxis,...
    lineStyles, lineColours, lineWidths, legendLabels);

yLims = [-0.01, 0.11];

takeAndPlotLineProfiles(...
    [root, '1500MU Catheter Profiles 2.png'],...
    {gel1500MU_fdk, gel1500MU_osctv, gel1500MU_control},...
    {noShift, noShift, [-1,-1]},...
    unitConversion, slice,...
    profile2_X, profile2_Y, voxelDimInMM,...
    lineProfilePlotDimsInCm, yLims,...
    lineProfileXAxis, lineProfileYAxis,...
    lineStyles, lineColours, lineWidths, legendLabels);



