%% PATHS
basePath = 'E:';
writePath = 'C:\Users\David\OneDrive\Master''s Year 1\Research\Progress Meeting - Mar 23\Images';

%% RAW SCANNER IMAGES

frameDims = [1024,768];
frameWindow = [0, 2^16];

% read in frames
noCathRefFrame =    readOptCtFrameBmp(makePath(basePath, 'CATH 002 No Catheter\reference\CATH 002 No Catheter_REF_0001.bmp'), frameDims);
noCathDataFrame =   readOptCtFrameBmp(makePath(basePath, 'CATH 002 No Catheter\data\CATH 002 No Catheter_DATA_0001.bmp'), frameDims);

withCathRefFrame =  readOptCtFrameBmp(makePath(basePath, 'CATH 002 With Catheter\reference\CATH 002 With Catheter_REF_0001.bmp'), frameDims);
withCathDataFrame = readOptCtFrameBmp(makePath(basePath, 'CATH 002 With Catheter\data\CATH 002 With Catheter_DATA_0001.bmp'), frameDims);

floodFieldFrame =   readOptCtFrameBmp(makePath(basePath, 'CATH 002 Flood Field\reference\CATH 002 Flood Field_REF_0001.bmp'), frameDims);

% write frames
writeGrayscaleImage(noCathRefFrame, frameWindow, makePath(writePath, 'No Catheter Ref Scanner Frame.png'));
writeGrayscaleImage(noCathDataFrame, frameWindow, makePath(writePath, 'No Catheter Data Scanner Frame.png'));

writeGrayscaleImage(withCathRefFrame, frameWindow, makePath(writePath, 'With Catheter Ref Scanner Frame.png'));
writeGrayscaleImage(withCathDataFrame, frameWindow, makePath(writePath, 'With Catheter Data Scanner Frame.png'));

writeGrayscaleImage(floodFieldFrame, frameWindow, makePath(writePath, 'Flood Field Scanner Frame.png'));

% write delta attenuation files
withCathDataRefFrame = log(withCathRefFrame./withCathDataFrame);
withCathRefFloodFrame = log(floodFieldFrame./withCathRefFrame);
withCathDataFloodFrame = log(floodFieldFrame./withCathDataFrame);

writeGrayscaleImage(withCathDataRefFrame, [0,max(max(withCathDataRefFrame))], makePath(writePath, 'With Catheter Attenuation Frame.png'));
writeGrayscaleImage(withCathRefFloodFrame, [0,max(max(withCathRefFloodFrame))], makePath(writePath, 'With Catheter Ref Attenuation Frame.png'));
writeGrayscaleImage(withCathDataFloodFrame, [0,max(max(withCathDataFloodFrame))], makePath(writePath, 'With Catheter Data Attenuation Frame.png'));



%% FDK Recons

slice = 70;
plane = 128;

% load recons
noCathRecon = loadVistaReconForAnalysis(makePath(basePath, 'CATH 002 No Catheter\CATH 002 No Catheter_HR.vff'));
withCathRecon = loadVistaReconForAnalysis(makePath(basePath, 'CATH 002 With Catheter\CATH 002 With Catheter_HR.vff'));

noCathRefRecon= loadVistaReconForAnalysis(makePath(basePath, 'CATH 002 No Catheter Ref\CATH 002 No Catheter Ref_HR.vff'));
noCathDataRecon = loadVistaReconForAnalysis(makePath(basePath, 'CATH 002 No Catheter Data\CATH 002 No Catheter Data_HR.vff'));

withCathRefRecon = loadVistaReconForAnalysis(makePath(basePath, 'CATH 002 With Catheter Ref\CATH 002 With Catheter Ref_HR.vff'));
withCathDataRecon = loadVistaReconForAnalysis(makePath(basePath, 'CATH 002 With Catheter Data\CATH 002 With Catheter Data_HR.vff'));

%% FDK RECONS (FULL DATA SETS)
% extract slices
noCathSlice = getSlice(noCathRecon, slice);
withCathSlice = getSlice(withCathRecon, slice);

noCathPlane = getPlane(noCathRecon, plane);
withCathPlane = getPlane(withCathRecon, plane);

sliceWindow = getMaxImageWindow(noCathSlice);
planeWindow = getMaxImageWindow(noCathPlane);

% write images
writeGrayscaleImage(noCathSlice, sliceWindow, makePath(writePath, 'FDK No Cath Slice.png'));
writeGrayscaleImage(withCathSlice, sliceWindow, makePath(writePath, 'FDK With Cath Slice.png'));

writeGrayscaleImage(noCathPlane, planeWindow, makePath(writePath, 'FDK No Cath Plane.png'));
writeGrayscaleImage(withCathPlane, planeWindow, makePath(writePath, 'FDK With Cath Plane.png'));

%% FDK RECONS (FLOOD FIELD DATA SETS)
% extract slices
noCathRefSlice = noCathRefRecon(:,:,slice);
noCathDataSlice = noCathDataRecon(:,:,slice);

withCathRefSlice = withCathRefRecon(:,:,slice);
withCathDataSlice = withCathDataRecon(:,:,slice);

sliceWindow = getMaxImageWindow(noCathDataSlice);

% write images
writeGrayscaleImage(noCathRefSlice, sliceWindow, makePath(writePath, 'FDK No Cath Ref Slice.png'));
writeGrayscaleImage(noCathDataSlice, sliceWindow, makePath(writePath, 'FDK No Cath Data Slice.png'));

writeGrayscaleImage(withCathRefSlice, sliceWindow, makePath(writePath, 'FDK With Cath Ref Slice.png'));
writeGrayscaleImage(withCathDataSlice, sliceWindow, makePath(writePath, 'FDK With Cath Data Slice.png'));

%% ALGEBRARC RECONS (FULL DATA SETS)

% load data
algWithCathRecon =          loadGyrfalconReconForAnalysis(makePath(basePath, 'Progress Data\With Cath Recon 14 (CBCT OS-ASD-POCS)\Slices\Slice 1.mat'));
algWithCathRayRejectRecon = loadGyrfalconReconForAnalysis(makePath(basePath, 'Progress Data\With Cath Recon 2 (CBCT OS-ASD-POCS)\Slices\Slice 1.mat'));
algNoCathRecon =            loadGyrfalconReconForAnalysis(makePath(basePath, 'Progress Data\No Cath Recon 13 (CBCT OS-ASD-POCS)\Slices\Slice 1.mat'));
algWithCathRefRecon =       loadGyrfalconReconForAnalysis(makePath(basePath, 'Progress Data\With Cath Ref Recon 13 (CBCT OS-ASD-POCS)\Slices\Slice 1.mat'));
algWithCathDataRecon =      loadGyrfalconReconForAnalysis(makePath(basePath, 'Progress Data\With Cath Data Recon 13 (CBCT OS-ASD-POCS)\Slices\Slice 1.mat'));

% get slices
algWithCathSlice =          getSlice(algWithCathRecon, slice);
algWithCathRayRejectSlice = getSlice(algWithCathRayRejectRecon, slice);
algNoCathSlice =            getSlice(algNoCathRecon, slice);
algWithCathRefSlice =       getSlice(algWithCathRefRecon, slice);
algWithCathDataSlice =      getSlice(algWithCathDataRecon, slice);

algWithCathPlane =          getPlane(algWithCathRecon, plane);
algWithCathRayRejectPlane = getPlane(algWithCathRayRejectRecon, plane);
algNoCathPlane =            getPlane(algNoCathRecon, plane);
algWithCathRefPlane =       getPlane(algWithCathRefRecon, plane);
algWithCathDataPlane =      getPlane(algWithCathDataRecon, plane);

% write images
sliceWindow = getMaxImageWindow(noCathSlice);
planeWindow = getMaxImageWindow(noCathPlane);

writeGrayscaleImage(algWithCathSlice, sliceWindow, makePath(writePath, 'ALG With Cath Slice.png'));
writeGrayscaleImage(algWithCathRayRejectSlice, sliceWindow, makePath(writePath, 'ALG RR With Cath Slice.png'));
writeGrayscaleImage(algNoCathSlice, sliceWindow, makePath(writePath, 'ALG No Cath Slice.png'));

writeGrayscaleImage(algWithCathPlane, planeWindow, makePath(writePath, 'ALG With Cath Plane.png'));
writeGrayscaleImage(algWithCathRayRejectPlane, planeWindow, makePath(writePath, 'ALG RR With Cath Plane.png'));
writeGrayscaleImage(algNoCathPlane, sliceWindow, makePath(writePath, 'ALG No Cath Plane.png'));

sliceWindow = getMaxImageWindow(noCathDataSlice);

writeGrayscaleImage(algWithCathRefSlice, sliceWindow, makePath(writePath, 'ALG With Cath Ref Slice.png'));
writeGrayscaleImage(algWithCathDataSlice, sliceWindow, makePath(writePath, 'ALG With Cath Data Slice.png'));

%% LINE PROFILES (NO CATHETER)

numPoints = 256;

profileData = {noCathSlice, algNoCathSlice};
profileLabels = {'w/o Catheter (FDK Recon)', 'w/o Catheter (Alg. Recon)'};
lineColours = {'k', 'r'};
lineWidths = {1, 0.5};

xLabel = 'Voxel Position $[0.5mm/vx]$';
yLabel = '$\Delta \mu [cm^{-1}]$';
yLimits = [-0.03 0.25];

% profile across middle

profX = [1 256];
profY = [128 128];

savePath = makePath(writePath, 'Line Profile - No Cath - Horizontal - FDK vs Alg.png');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);

% profile from top-left to bottom right
profX = [1 256];
profY = [1 256];

savePath = makePath(writePath, 'Line Profile - No Cath - Diagonal - FDK vs Alg.png');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);


%% LINE PROFILES (CATHETER)

% **************************************
% ** FDK No Cath / FDK / ALG / ALG RR **
% **************************************

numPoints = 256;

profileData = {noCathSlice, withCathSlice, algWithCathSlice, algWithCathRayRejectSlice};
profileLabels = {'w/o Catheter (FDK Recon)', 'w/ Catheter (FDK Recon)', 'w/ Catheter (Alg. Recon)', 'w/ Catheter (Alg. Recon w/ Ray Rejection'};
lineColours = {'k', 'r', 'b', 'g'};
lineWidths = {1, 0.5, 0.5, 0.5};

xLabel = 'Voxel Position $[0.5mm/vx]$';
yLabel = '$\Delta \mu [cm^{-1}]$';
yLimits = [-0.03 0.35];

% profile across middle
profX = [1 256];
profY = [128 128];

savePath = makePath(writePath, 'Line Profile - Horizontal - FDK vs Alg vs Alg RR.png');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);

% profile from top-left to bottom right
profX = [1 256];
profY = [1 256];

savePath = makePath(writePath, 'Line Profile - Diagonal - FDK vs Alg vs Alg RR.png');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);

% ********************************
% ** FDK No Cath / ALG / ALG RR **
% ********************************

numPoints = 256;

profileData = {noCathSlice, algWithCathSlice, algWithCathRayRejectSlice};
profileLabels = {'w/o Catheter (FDK Recon)', 'w/ Catheter (Alg. Recon)', 'w/ Catheter (Alg. Recon w/ Ray Rejection'};
lineColours = {'k', 'b', 'g'};
lineWidths = {1, 0.5, 0.5};

xLabel = 'Voxel Position $[0.5mm/vx]$';
yLabel = '$\Delta \mu [cm^{-1}]$';
yLimits = [-0.03 0.25];

% profile across middle
profX = [1 256];
profY = [128 128];

savePath = makePath(writePath, 'Line Profile - Horizontal - Alg vs Alg RR.png');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);

% profile from top-left to bottom right
profX = [1 256];
profY = [1 256];

savePath = makePath(writePath, 'Line Profile - Diagonal - Alg vs Alg RR.png');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);

% ********************************
% ** ALG No Cath / ALG / ALG RR **
% ********************************

numPoints = 256;

profileData = {algNoCathSlice, algWithCathSlice, algWithCathRayRejectSlice};
profileLabels = {'w/o Catheter (Alg. Recon)', 'w/ Catheter (Alg. Recon)', 'w/ Catheter (Alg. Recon w/ Ray Rejection'};
lineColours = {'k', 'b', 'g'};
lineWidths = {1, 0.5, 0.5};

xLabel = 'Voxel Position $[0.5mm/vx]$';
yLabel = '$\Delta \mu [cm^{-1}]$';
yLimits = [-0.03 0.25];

% profile across middle
profX = [1 256];
profY = [128 128];

savePath = makePath(writePath, 'Line Profile - Horizontal - Alg vs Alg vs Alg RR.png');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);

% profile from top-left to bottom right
profX = [1 256];
profY = [1 256];

savePath = makePath(writePath, 'Line Profile - Diagonal - Alg vs Alg vs Alg RR.png');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);


%% Gamma Analysis (WITH CATHETER)
window = [0 2];
voxelSize = [0.5 0.5]; %mm

referenceData = noCathSlice;

% *************
% **2mm at 2%**
% *************
percent = 2;
dta = 2; % mm

% alg. recon
targetData = algWithCathSlice;
savePath = makePath(writePath, 'Gamma 2x2 - ALG.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);

% alg. recon w/ ray rejection
targetData = algWithCathRayRejectSlice;
savePath = makePath(writePath, 'Gamma 2x2 - ALG RR.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);

% FDK
targetData = withCathSlice;
savePath = makePath(writePath, 'Gamma 2x2 - FDK.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);

% *************
% **1mm at 1%**
% *************
percent = 1;
dta = 1; % mm

% alg. recon
targetData = algWithCathSlice;
savePath = makePath(writePath, 'Gamma 1x1 - ALG.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);

% alg. recon w/ ray rejection
targetData = algWithCathRayRejectSlice;
savePath = makePath(writePath, 'Gamma 1x1 - ALG RR.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);

% FDK
targetData = withCathSlice;
savePath = makePath(writePath, 'Gamma 1x1 - FDK.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);


%% Gamma Analysis (CATHETER VS. NO CATH ALG.)
window = [0 2];
voxelSize = [0.5 0.5]; %mm

referenceData = algNoCathSlice;

% *************
% **2mm at 2%**
% *************
percent = 2;
dta = 2; % mm

% alg. recon
targetData = algWithCathSlice;
savePath = makePath(writePath, 'Gamma 2x2 - ALG No Cath vs. ALG.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);

% alg. recon w/ ray rejection
targetData = algWithCathRayRejectSlice;
savePath = makePath(writePath, 'Gamma 2x2 - ALG No Cath vs. ALG RR.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);

% *************
% **1mm at 1%**
% *************
percent = 1;
dta = 1; % mm

% alg. recon
targetData = algWithCathSlice;
savePath = makePath(writePath, 'Gamma 1x1 - ALG No Cath vs. ALG.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);

% alg. recon w/ ray rejection
targetData = algWithCathRayRejectSlice;
savePath = makePath(writePath, 'Gamma 1x1 - ALG No Cath vs. ALG RR.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);


%% Gamma Analysis (NO CATHETER FDK vs. NO CATHETER ALG)
window = [0 2];
voxelSize = [0.5 0.5]; %mm

referenceData = noCathSlice;

% *************
% **2mm at 2%**
% *************
percent = 2;
dta = 2; % mm

% alg. recon
targetData = algNoCathSlice;
savePath = makePath(writePath, 'Gamma 2x2 - ALG No Cath.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);


% *************
% **1mm at 1%**
% *************
percent = 1;
dta = 1; % mm

% alg. recon
targetData = algNoCathSlice;
savePath = makePath(writePath, 'Gamma 1x1 - ALG No Cath.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);


%% DATA & REF ALGEBRAIC RECON

algDiffRecon = algWithCathDataRecon - algWithCathRefRecon;

algDiffSlice = getSlice(algDiffRecon, slice);
algDiffPlane = getPlane(algDiffRecon, plane);

% write images
sliceWindow = getMaxWindow(noCathSlice);
planeWindow = getMaxWindow(noCathPlane);

writeGrayscaleImage(algDiffSlice, sliceWindow, makePath(writePath, 'ALG Diff With Cath Slice.png'));
writeGrayscaleImage(algDiffPlane, planeWindow, makePath(writePath, 'ALG Diff With Cath Plane.png'));


%% LINE PROFILES (DATA & REF)

% *****************************
% ** Compared to FDK No Cath **
% *****************************

numPoints = 256;

profileData = {noCathSlice, algDiffSlice, algWithCathSlice, algWithCathRayRejectSlice};
profileLabels = {'w/o Catheter (FDK Recon)', 'w/ Catheter (Alg. Recon w/ Data & Ref)', 'w/ Catheter (Alg. Recon)', 'w/ Catheter (Alg. Recon w/ Ray Rejection'};
lineColours = {'k', 'r', 'b', 'g'};
lineWidths = {1, 0.5, 0.5, 0.5};

xLabel = 'Voxel Position $[0.5mm/vx]$';
yLabel = '$\Delta \mu [cm^{-1}]$';
yLimits = [-0.03 0.25];

% profile across middle
profX = [1 256];
profY = [128 128];

savePath = makePath(writePath, 'Line Profile - Horizontal - FDK vs Alg Diff vs Alg vs Alg RR.png');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);

% profile from top-left to bottom right
profX = [1 256];
profY = [1 256];

savePath = makePath(writePath, 'Line Profile - Diagonal - FDK vs Alg Diff vs Alg vs Alg RR.png');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);


% ***********************************
% ** Compared to Algebraic No Cath **
% ***********************************

numPoints = 256;

profileData = {algNoCathSlice, algDiffSlice, algWithCathSlice, algWithCathRayRejectSlice};
profileLabels = {'w/o Catheter (Alg. Recon)', 'w/ Catheter (Alg. Recon w/ Data & Ref)', 'w/ Catheter (Alg. Recon)', 'w/ Catheter (Alg. Recon w/ Ray Rejection'};
lineColours = {'k', 'r', 'b', 'g'};
lineWidths = {1, 0.5, 0.5, 0.5};

xLabel = 'Voxel Position $[0.5mm/vx]$';
yLabel = '$\Delta \mu [cm^{-1}]$';
yLimits = [-0.03 0.25];

% profile across middle
profX = [1 256];
profY = [128 128];

savePath = makePath(writePath, 'Line Profile - Horizontal - Alg No Cath vs Alg Diff vs Alg vs Alg RR.png');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);

% profile from top-left to bottom right
profX = [1 256];
profY = [1 256];

savePath = makePath(writePath, 'Line Profile - Diagonal - Alg No Cath vs Alg Diff vs Alg vs Alg RR.png');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);


%% Gamma Analysis (CATHETER VS. NO CATH ALG.)
window = [0 2];
voxelSize = [0.5 0.5]; %mm

referenceData = algNoCathSlice;

% *************
% **2mm at 2%**
% *************
percent = 2;
dta = 2; % mm

% alg. recon
targetData = algDiffSlice;
savePath = makePath(writePath, 'Gamma 2x2 - ALG No Cath vs. ALG Diff.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);


% *************
% **1mm at 1%**
% *************
percent = 1;
dta = 1; % mm

% alg. recon
targetData = algDiffSlice;
savePath = makePath(writePath, 'Gamma 1x1 - ALG No Cath vs. ALG Diff.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);


%% Gamma Analysis (CATHETER VS. NO CATH FDK)
window = [0 2];
voxelSize = [0.5 0.5]; %mm

referenceData = noCathSlice;

% *************
% **2mm at 2%**
% *************
percent = 2;
dta = 2; % mm

% alg. recon
targetData = algDiffSlice;
savePath = makePath(writePath, 'Gamma 2x2 - FDK No Cath vs. ALG Diff.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);


% *************
% **1mm at 1%**
% *************
percent = 1;
dta = 1; % mm

% alg. recon
targetData = algDiffSlice;
savePath = makePath(writePath, 'Gamma 1x1 - FDK No Cath vs. ALG Diff.png');

createGammaFigure(savePath, referenceData, targetData, voxelSize, percent, dta, window);
