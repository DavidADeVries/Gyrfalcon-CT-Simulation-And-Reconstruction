

numPoints = 256;

% profileData = {sing_cent_tps, sing_centre_fdk, sing_cent_alg};
profileData = {two_tps, two_alg};

profileLabels = {'(a)', '(b)'};
lineColours = {'k', 'b'};
lineWidths = {1, 1};

xLabel = 'Position $[mm]$';
yLabel = 'Dose $[Gy]$';
yLimits = [-5 250];

% profile across middle

profX = [1 256];
profY = [131 131];

savePath = makePath('');

createProfileFigure2(savePath, x, profileData, profileLabels, lineColours, lineWidths, xLabel, yLabel, yLimits);

% profile from top-left to bottom right
profX = [1 256];
profY = [1 256];

savePath = makePath(writePath, 'Line Profile - No Cath - Diagonal - FDK vs Alg.png');

createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, profX, profY, numPoints, xLabel, yLabel, yLimits);



