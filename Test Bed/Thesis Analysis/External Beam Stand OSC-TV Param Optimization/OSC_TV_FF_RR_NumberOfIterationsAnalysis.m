% output params
writePath = 'E:\Thesis Results\External Beam Trials (Redo).xls';
sheetName = 'OSC-TV_FF_RR # Iters';

% general params
catheterMaskRadius = 5;

% Set-up base for the analysis
base = AnalysisRun;

base.catheterCoordsFile = 'E:\Thesis Recon Data\Gel 4-2\Catheter Coords.mat';

base.usedCatheterReject = false;

base.controlPath = 'E:\Thesis Recon Data\Gel 4-1\Gel 4-1_HR.vff';

% Control Analysis
control = base;
control.gelName = 'Gel 4-1';
control.reconAlgorithm = 'FDK';       
control.readPath = 'E:\Thesis Recon Data\Gel 4-1\Gel 4-1_HR.vff';

% FDK Comparison
fdkComp = base;
fdkComp.gelName = 'Gel 4-2';
fdkComp.reconAlgorithm = 'FDK';       
fdkComp.readPath = 'E:\Thesis Recon Data\Gel 4-2\Gel 4-2_HR.vff';

% FDK FF Comparison
fdkFFComp = base;
fdkFFComp.gelName = 'Gel 4-2';
fdkFFComp.reconAlgorithm = 'FDK';       
fdkFFComp.readPath = 'E:\Thesis Recon Data\Gel 4-2 (FF-R)\Gel 4-2 (FF-R)_HR.vff';
fdkFFComp.usedFloodFields = true; 

% OSC-TV Base
osctvBase = base;
osctvBase.gelName = 'Gel 4-2';
osctvBase.reconAlgorithm = 'OSC-TV';

% OSC-TV (STANDARD)
osctv205_41 =  osctvBase;
osctv205_41.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2 FF-R)';
osctv205_41.usedFloodFields = true;
osctv205_41.usedCatheterReject = true;

osctv205_41.reconNumberStart = 46; 

osctv205_41.numIterationsValues = {'5', '10', '15', '20', '25'};
osctv205_41.numSubsetsValues = {'[41 205]'};
osctv205_41.cValues = {'0.01'};
  
% *********
% ** RUN **
% *********

crunchParameterOptimizationMetrics(...
    {control, fdkComp, fdkFFComp,...
    osctv205_41},...
    catheterMaskRadius,...
    writePath, sheetName);
