% output params
writePath = 'E:\Thesis Results\External Beam Trials.xls';
sheetName = 'Stand. OSC-TV # Iters';

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
osctvBase.reconNumberStart = 51;  
osctvBase.numIterationsValues = {'10', '15', '20', '25', '30'};
osctvBase.numSubsetsValues = {'[205 41]'};

% OSC-TV No Flood Field
osctvNoFF = osctvBase;
osctvNoFF.readPath = 'E:\Data Files\Git Repos\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2)\';
osctvNoFF.cValues = {'0.01'};
osctvNoFF.usedFloodFields = false;  

% OSC-TV No Flood Field
osctvFF = osctvBase;     
osctvFF.readPath = 'E:\Data Files\Git Repos\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2 FF-R)\';
osctvFF.cValues = {'0.005'};
osctvFF.usedFloodFields = true;

  
% *********
% ** RUN **
% *********

crunchParameterOptimizationMetrics(...
    {control, fdkComp, fdkFFComp,...
    osctvNoFF, osctvFF},...
    catheterMaskRadius,...
    writePath, sheetName);
