% output params
writePath = 'E:\Thesis Results\External Beam Trials.xls';
sheetName = 'RR OSC-TV # Iters';

% general params
catheterMaskRadius = 5;

% Set-up base for the analysis
base = AnalysisRun;

base.catheterCoordsFile = 'F:\Thesis Recon Data\Gel 4-2\Catheter Coords.mat';

base.usedCatheterReject = false;

base.controlPath = 'F:\Thesis Recon Data\Gel 4-1\Gel 4-1_HR.vff';

% Control Analysis
control = base;
control.gelName = 'Gel 4-1';
control.reconAlgorithm = 'FDK';       
control.readPath = 'F:\Thesis Recon Data\Gel 4-1\Gel 4-1_HR.vff';

% FDK Comparison
fdkComp = base;
fdkComp.gelName = 'Gel 4-2';
fdkComp.reconAlgorithm = 'FDK';       
fdkComp.readPath = 'F:\Thesis Recon Data\Gel 4-2\Gel 4-2_HR.vff';

% FDK FF Comparison
fdkFFComp = base;
fdkFFComp.gelName = 'Gel 4-2';
fdkFFComp.reconAlgorithm = 'FDK';       
fdkFFComp.readPath = 'F:\Thesis Recon Data\Gel 4-2 (FF-R)\Gel 4-2 (FF-R)_HR.vff';
fdkFFComp.usedFloodFields = true; 

% OSC-TV Base
osctvBase = base;
osctvBase.gelName = 'Gel 4-2';
osctvBase.reconAlgorithm = 'OSC-TV';

% OSC-TV (STANDARD)
osctv205_41 =  osctvBase;
osctv205_41.readPath = 'E:\Data Files\Git Repos\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2)';
osctv205_41.usedFloodFields = false;
osctv205_41.cValues = {'0.01'};

osctv205_41.reconNumberStart = 151; 

osctv205_41.numIterationsValues = {'10', '15', '20', '25', '30', '35', '40'};
osctv205_41.numSubsetsValues = {'[205 41]'};

osctv205_13 = osctv205_41;
osctv205_13.reconNumberStart = 158; 

osctv205_13.numIterationsValues = {'10', '15', '20', '25', '30', '35', '40'};
osctv205_13.numSubsetsValues = {'[205 13]'};

% OSC-TV (FF)

osctvFF205_41 =  osctvBase;
osctvFF205_41.readPath = 'E:\Data Files\Git Repos\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2 FF-R)';
osctvFF205_41.usedFloodFields = true;
osctvFF205_41.cValues = {'0.005'};  

osctvFF205_41.reconNumberStart = 151; 

osctvFF205_41.numIterationsValues = {'10', '15', '20', '25', '30', '35', '40'};
osctvFF205_41.numSubsetsValues = {'[205 41]'};

osctvFF205_13 = osctvFF205_41;
osctvFF205_13.reconNumberStart = 158; 

osctvFF205_13.numIterationsValues = {'10', '15', '20', '25', '30', '35', '40'};
osctvFF205_13.numSubsetsValues = {'[205 13]'};

  
% *********
% ** RUN **
% *********

crunchParameterOptimizationMetrics(...
    {control, fdkComp, fdkFFComp,...
    osctv205_13, osctv205_41,...
    osctvFF205_13, osctvFF205_41},...
    catheterMaskRadius,...
    writePath, sheetName);
