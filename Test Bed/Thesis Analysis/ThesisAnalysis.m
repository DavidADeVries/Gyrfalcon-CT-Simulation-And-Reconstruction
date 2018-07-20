% output params
writePath = 'F:\Analysis Test Values\Results New.xls';
sheetName = 'Parameter Optimization';

% general params
catheterMaskRadius = 5;

% Set-up base for the analysis
base = AnalysisRun;

base.catheterCoordsFile = 'F:\Analysis Test Values\Catheter Coords.mat';

base.usedCatheterReject = false;

% Control Analysis
control = base;
control.gelName = 'Gel 4-1';
control.reconAlgorithm = 'FDK';       
control.readPath = 'F:\Analysis Test Values\Gel 4-1_HR.vff';

% FDK Comparison
fdkComp = base;
fdkComp.gelName = 'Gel 4-2';
fdkComp.reconAlgorithm = 'FDK';       
fdkComp.readPath = 'F:\Analysis Test Values\Gel 4-2_HR.vff';

% OSC-TV No Flood Field
osctvNoFF = base;
osctvNoFF.gelName = 'Gel 4-2';
osctvNoFF.reconAlgorithm = 'OSC-TV';       
osctvNoFF.readPath = 'F:\Analysis Test Values\';
osctvNoFF.usedFloodFields = false;
osctvNoFF.reconNumberStart = 48;    
osctvNoFF.numIterationsValues = {'1'};
osctvNoFF.numSubsetsValues = {'[2,3]'};
osctvNoFF.cValues = {'1'};

% OSC-TV No Flood Field
osctvFF = base;
osctvFF.gelName = 'Gel 4-2';
osctvFF.reconAlgorithm = 'OSC-TV';       
osctvFF.readPath = 'F:\Analysis Test Values\';
osctvFF.usedFloodFields = true;
osctvFF.reconNumberStart = 48;    
osctvFF.numIterationsValues = {'1'};
osctvFF.numSubsetsValues = {'[2,3]'};
osctvFF.cValues = {'1'};
  
%
% ** RUN **
%

crunchParameterOptimizationMetrics(...
    {control, fdkComp, osctvNoFF, osctvFF},...
    catheterMaskRadius,...
    writePath, sheetName);