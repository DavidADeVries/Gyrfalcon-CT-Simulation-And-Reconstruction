% output params
writePath = 'E:\Thesis Results\External Beam Trials.xls';
sheetName = 'RR OSC-TV Param. Opt.';

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
osctvBase.reconNumberStart = 126;  
osctvBase.numIterationsValues = {'15'};
osctvBase.numSubsetsValues = { '[26 2]', '[51 3]', '[103 6]', '[205 13]', '[205 41]'};
osctvBase.cValues = {'0.001', '0.005', '0.01', '0.05', '0.1'};

% OSC-TV No Flood Field
osctvNoFF = osctvBase;
osctvNoFF.readPath = 'E:\Data Files\Git Repos\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2)\';
osctvNoFF.usedFloodFields = false;  

% OSC-TV No Flood Field
osctvFF = osctvBase;     
osctvFF.readPath = 'E:\Data Files\Git Repos\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2 FF-R)\';
osctvFF.usedFloodFields = true;

  
% *********
% ** RUN **
% *********

crunchParameterOptimizationMetrics(...
    {control, fdkComp, fdkFFComp,...
    osctvNoFF, osctvFF},...
    catheterMaskRadius,...
    writePath, sheetName);
