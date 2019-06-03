% output params
writePath = 'E:\Thesis Results\External Beam Trials (Redo).xls';
sheetName = 'OSC-TV_FF Param. Opt.';

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
osctvBase.usedCatheterReject = false;
osctvBase.reconNumberStart = 1;  
osctvBase.numIterationsValues = {'10'};
osctvBase.numSubsetsValues = {'[3 51]', '[6 103]', '[13 205]', '[41 205]'};
osctvBase.cValues = {'0.001', '0.005', '0.01', '0.05', '0.1'};

% OSC-TV No Flood Field
osctv_FF = osctvBase;
osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2 FF-R)\';
osctv_FF.usedFloodFields = true;  


  
% *********
% ** RUN **
% *********

crunchParameterOptimizationMetrics(...
    {control, fdkComp, fdkFFComp,...
    osctv_FF},...
    catheterMaskRadius,...
    writePath, sheetName);
