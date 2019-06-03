

numPoints = 256;

profileData = {fdkNoCath./100, fdkSlice./100, algSlice./100};
profileLabels = {'w/o Catheter (FDK Recon)', 'w/ Catheter (FDK Recon)', 'w/ Catheter (Alg. Recon)'};
lineColours = {'k', 'r', 'b'};
lineWidths = {1, 1, 1};

xLabel = 'Voxel Position $[0.5mm/vx]$';
yLabel = '$\Delta \mu [cm^{-1}]$';
yLimits = [-0.02 0.12];

% profile across middle

profX = [1 256];
profY = [131 131];

savePath = makePath('');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);

% profile from top-left to bottom right
profX = [1 256];
profY = [1 256];

savePath = makePath(writePath, 'Line Profile - No Cath - Diagonal - FDK vs Alg.png');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);



