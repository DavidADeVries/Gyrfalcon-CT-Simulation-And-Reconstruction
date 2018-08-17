% output params
writePath = 'E:\Thesis Results\External Beam Trials (Redo).xls';
sheetName = 'All OSC-TV All Trials';

% general params
catheterMaskRadius = 5;

% Set-up base for FDK analysis
fdkBase = AnalysisRun;
fdkBase.usedCatheterReject = false;
fdkBase.reconAlgorithm = 'FDK';

% Set-up base for OSC-TV
osctv_Base = AnalysisRun;
osctv_Base.usedCatheterReject = false;
osctv_Base.usedFloodFields = false;
osctv_Base.reconAlgorithm = 'OSC-TV';
osctv_Base.numIterationsValues = {'15'};
osctv_Base.numSubsetsValues = {'[41..205]'};
osctv_Base.cValues = {'0.05'};

osctv_FF_Base = AnalysisRun;
osctv_FF_Base.usedCatheterReject = false;
osctv_FF_Base.usedFloodFields = true;
osctv_FF_Base.reconAlgorithm = 'OSC-TV';
osctv_FF_Base.numIterationsValues = {'25'};
osctv_FF_Base.numSubsetsValues = {'[41..205]'};
osctv_FF_Base.cValues = {'0.01'};

osctv_RR_Base = AnalysisRun;
osctv_RR_Base.usedCatheterReject = true;
osctv_RR_Base.usedFloodFields = false;
osctv_RR_Base.reconAlgorithm = 'OSC-TV';
osctv_RR_Base.numIterationsValues = {'25'};
osctv_RR_Base.numSubsetsValues = {'[41..205]'};
osctv_RR_Base.cValues = {'0.05'};

osctv_FF_RR_Base = AnalysisRun;
osctv_FF_RR_Base.usedCatheterReject = true;
osctv_FF_RR_Base.usedFloodFields = true;
osctv_FF_RR_Base.reconAlgorithm = 'OSC-TV';
osctv_FF_RR_Base.numIterationsValues = {'25'};
osctv_FF_RR_Base.numSubsetsValues = {'[41..205]'};
osctv_FF_RR_Base.cValues = {'0.01'};


% ** Gel 2-1/2-2 (500MU) **
controlPath = 'E:\Thesis Recon Data\Gel 2-1\Gel 2-1_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 2-2\Catheter Coords.mat';
gelName = 'Gel 2-2';

gel2_2Control = fdkBase;
gel2_2Control.gelName = 'Gel 2-1';
gel2_2Control.readPath = 'E:\Thesis Recon Data\Gel 2-1\Gel 2-1_HR.vff';
gel2_2Control.controlPath = controlPath;
gel2_2Control.catheterCoordsFile = catheterCoordsFile;

gel2_2Fdk = fdkBase;
gel2_2Fdk.gelName = gelName;
gel2_2Fdk.readPath = 'E:\Thesis Recon Data\Gel 2-2\Gel 2-2_HR.vff';
gel2_2Fdk.controlPath = controlPath;
gel2_2Fdk.catheterCoordsFile = catheterCoordsFile;

gel2_2Osctv = osctv_Base;
gel2_2Osctv.gelName = gelName;
gel2_2Osctv.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-2)\';
gel2_2Osctv.controlPath = controlPath;
gel2_2Osctv.catheterCoordsFile = catheterCoordsFile;
gel2_2Osctv.reconNumberStart = 1;

gel2_2Osctv_FF = osctv_FF_Base;
gel2_2Osctv_FF.gelName = gelName;
gel2_2Osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-2 FF-R)\';
gel2_2Osctv_FF.controlPath = controlPath;
gel2_2Osctv_FF.catheterCoordsFile = catheterCoordsFile;
gel2_2Osctv_FF.reconNumberStart = 1;

gel2_2Osctv_RR = osctv_RR_Base;
gel2_2Osctv_RR.gelName = gelName;
gel2_2Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-2)\';
gel2_2Osctv_RR.controlPath = controlPath;
gel2_2Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel2_2Osctv_RR.reconNumberStart = 2;

gel2_2Osctv_FF_RR = osctv_FF_RR_Base;
gel2_2Osctv_FF_RR.gelName = gelName;
gel2_2Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-2 FF-R)\';
gel2_2Osctv_FF_RR.controlPath = controlPath;
gel2_2Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel2_2Osctv_FF_RR.reconNumberStart = 2;


% ** Gel 2-3/2-4 (1500MU) **
controlPath = 'E:\Thesis Recon Data\Gel 2-3\Gel 2-3_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 2-4\Catheter Coords.mat';
gelName = 'Gel 2-4';

gel2_4Control = fdkBase;
gel2_4Control.gelName = 'Gel 2-3';
gel2_4Control.readPath = 'E:\Thesis Recon Data\Gel 2-3\Gel 2-3_HR.vff';
gel2_4Control.controlPath = controlPath;
gel2_4Control.catheterCoordsFile = catheterCoordsFile;

gel2_4Fdk = fdkBase;
gel2_4Fdk.gelName = gelName;
gel2_4Fdk.readPath = 'E:\Thesis Recon Data\Gel 2-4\Gel 2-4_HR.vff';
gel2_4Fdk.controlPath = controlPath;
gel2_4Fdk.catheterCoordsFile = catheterCoordsFile;

gel2_4Osctv = osctv_Base;
gel2_4Osctv.gelName = gelName;
gel2_4Osctv.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-4)\';
gel2_4Osctv.controlPath = controlPath;
gel2_4Osctv.catheterCoordsFile = catheterCoordsFile;
gel2_4Osctv.reconNumberStart = 1;

gel2_4Osctv_FF = osctv_FF_Base;
gel2_4Osctv_FF.gelName = gelName;
gel2_4Osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-4 FF-R)\';
gel2_4Osctv_FF.controlPath = controlPath;
gel2_4Osctv_FF.catheterCoordsFile = catheterCoordsFile;
gel2_4Osctv_FF.reconNumberStart = 1;

gel2_4Osctv_RR = osctv_RR_Base;
gel2_4Osctv_RR.gelName = gelName;
gel2_4Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-4)\';
gel2_4Osctv_RR.controlPath = controlPath;
gel2_4Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel2_4Osctv_RR.reconNumberStart = 2;

gel2_4Osctv_FF_RR = osctv_FF_RR_Base;
gel2_4Osctv_FF_RR.gelName = gelName;
gel2_4Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-4 FF-R)\';
gel2_4Osctv_FF_RR.controlPath = controlPath;
gel2_4Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel2_4Osctv_FF_RR.reconNumberStart = 2;


% ** Gel 4-1/4-2 (2000MU) **
controlPath = 'E:\Thesis Recon Data\Gel 4-1\Gel 4-1_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 4-2\Catheter Coords.mat';
gelName = 'Gel 4-2';

gel4_2Control = fdkBase;
gel4_2Control.gelName = 'Gel 4-1';
gel4_2Control.readPath = 'E:\Thesis Recon Data\Gel 4-1\Gel 4-1_HR.vff';
gel4_2Control.controlPath = controlPath;
gel4_2Control.catheterCoordsFile = catheterCoordsFile;

gel4_2Fdk = fdkBase;
gel4_2Fdk.gelName = gelName;
gel4_2Fdk.readPath = 'E:\Thesis Recon Data\Gel 4-2\Gel 4-2_HR.vff';
gel4_2Fdk.controlPath = controlPath;
gel4_2Fdk.catheterCoordsFile = catheterCoordsFile;

gel4_2Osctv = osctv_Base;
gel4_2Osctv.gelName = gelName;
gel4_2Osctv.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2)\';
gel4_2Osctv.controlPath = controlPath;
gel4_2Osctv.catheterCoordsFile = catheterCoordsFile;
gel4_2Osctv.reconNumberStart = 23;

gel4_2Osctv_FF = osctv_FF_Base;
gel4_2Osctv_FF.gelName = gelName;
gel4_2Osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2 FF-R)\';
gel4_2Osctv_FF.controlPath = controlPath;
gel4_2Osctv_FF.catheterCoordsFile = catheterCoordsFile;
gel4_2Osctv_FF.reconNumberStart = 25;

gel4_2Osctv_RR = osctv_RR_Base;
gel4_2Osctv_RR.gelName = gelName;
gel4_2Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2)\';
gel4_2Osctv_RR.controlPath = controlPath;
gel4_2Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel4_2Osctv_RR.reconNumberStart = 50;

gel4_2Osctv_FF_RR = osctv_FF_RR_Base;
gel4_2Osctv_FF_RR.gelName = gelName;
gel4_2Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2 FF-R)\';
gel4_2Osctv_FF_RR.controlPath = controlPath;
gel4_2Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel4_2Osctv_FF_RR.reconNumberStart = 50;


% ** Gel 4-3/4-4 (2500MU) **
controlPath = 'E:\Thesis Recon Data\Gel 4-3\Gel 4-3_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 4-4\Catheter Coords.mat';
gelName = 'Gel 4-4';

gel4_4Control = fdkBase;
gel4_4Control.gelName = 'Gel 4-3';
gel4_4Control.readPath = 'E:\Thesis Recon Data\Gel 4-3\Gel 4-3_HR.vff';
gel4_4Control.controlPath = controlPath;
gel4_4Control.catheterCoordsFile = catheterCoordsFile;

gel4_4Fdk = fdkBase;
gel4_4Fdk.gelName = gelName;
gel4_4Fdk.readPath = 'E:\Thesis Recon Data\Gel 4-4\Gel 4-4_HR.vff';
gel4_4Fdk.controlPath = controlPath;
gel4_4Fdk.catheterCoordsFile = catheterCoordsFile;

gel4_4Osctv = osctv_Base;
gel4_4Osctv.gelName = gelName;
gel4_4Osctv.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-4)\';
gel4_4Osctv.controlPath = controlPath;
gel4_4Osctv.catheterCoordsFile = catheterCoordsFile;
gel4_4Osctv.reconNumberStart = 1;

gel4_4Osctv_FF = osctv_FF_Base;
gel4_4Osctv_FF.gelName = gelName;
gel4_4Osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-4 FF-R)\';
gel4_4Osctv_FF.controlPath = controlPath;
gel4_4Osctv_FF.catheterCoordsFile = catheterCoordsFile;
gel4_4Osctv_FF.reconNumberStart = 1;

gel4_4Osctv_RR = osctv_RR_Base;
gel4_4Osctv_RR.gelName = gelName;
gel4_4Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-4)\';
gel4_4Osctv_RR.controlPath = controlPath;
gel4_4Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel4_4Osctv_RR.reconNumberStart = 2;

gel4_4Osctv_FF_RR = osctv_FF_RR_Base;
gel4_4Osctv_FF_RR.gelName = gelName;
gel4_4Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-4 FF-R)\';
gel4_4Osctv_FF_RR.controlPath = controlPath;
gel4_4Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel4_4Osctv_FF_RR.reconNumberStart = 2;


% ** Gel 5-1/5-2 (Offset Cathteter) **
controlPath = 'E:\Thesis Recon Data\Gel 5-1\Gel 5-1_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 5-2\Catheter Coords.mat';
gelName = 'Gel 5-2';

gel5_2Control = fdkBase;
gel5_2Control.gelName = 'Gel 5-1';
gel5_2Control.readPath = 'E:\Thesis Recon Data\Gel 5-1\Gel 5-1_HR.vff';
gel5_2Control.controlPath = controlPath;
gel5_2Control.catheterCoordsFile = catheterCoordsFile;

gel5_2Fdk = fdkBase;
gel5_2Fdk.gelName = gelName;
gel5_2Fdk.readPath = 'E:\Thesis Recon Data\Gel 5-2\Gel 5-2_HR.vff';
gel5_2Fdk.controlPath = controlPath;
gel5_2Fdk.catheterCoordsFile = catheterCoordsFile;

gel5_2Osctv = osctv_Base;
gel5_2Osctv.gelName = gelName;
gel5_2Osctv.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-2)\';
gel5_2Osctv.controlPath = controlPath;
gel5_2Osctv.catheterCoordsFile = catheterCoordsFile;
gel5_2Osctv.reconNumberStart = 1;

gel5_2Osctv_FF = osctv_FF_Base;
gel5_2Osctv_FF.gelName = gelName;
gel5_2Osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-2 FF-R)\';
gel5_2Osctv_FF.controlPath = controlPath;
gel5_2Osctv_FF.catheterCoordsFile = catheterCoordsFile;
gel5_2Osctv_FF.reconNumberStart = 1;

gel5_2Osctv_RR = osctv_RR_Base;
gel5_2Osctv_RR.gelName = gelName;
gel5_2Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-2)\';
gel5_2Osctv_RR.controlPath = controlPath;
gel5_2Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel5_2Osctv_RR.reconNumberStart = 2;

gel5_2Osctv_FF_RR = osctv_FF_RR_Base;
gel5_2Osctv_FF_RR.gelName = gelName;
gel5_2Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-2 FF-R)\';
gel5_2Osctv_FF_RR.controlPath = controlPath;
gel5_2Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel5_2Osctv_FF_RR.reconNumberStart = 2;


% ** Gel 5-1/5-3 (3 Cathteters) **
controlPath = 'E:\Thesis Recon Data\Gel 5-1\Gel 5-1_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 5-3\Catheter Coords.mat';
gelName = 'Gel 5-3';

gel5_3Control = fdkBase;
gel5_3Control.gelName = 'Gel 5-1';
gel5_3Control.readPath = 'E:\Thesis Recon Data\Gel 5-1\Gel 5-1_HR.vff';
gel5_3Control.controlPath = controlPath;
gel5_3Control.catheterCoordsFile = catheterCoordsFile;

gel5_3Fdk = fdkBase;
gel5_3Fdk.gelName = gelName;
gel5_3Fdk.readPath = 'E:\Thesis Recon Data\Gel 5-3\Gel 5-3_HR.vff';
gel5_3Fdk.controlPath = controlPath;
gel5_3Fdk.catheterCoordsFile = catheterCoordsFile;

gel5_3Osctv = osctv_Base;
gel5_3Osctv.gelName = gelName;
gel5_3Osctv.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-3)\';
gel5_3Osctv.controlPath = controlPath;
gel5_3Osctv.catheterCoordsFile = catheterCoordsFile;
gel5_3Osctv.reconNumberStart = 1;

gel5_3Osctv_FF = osctv_FF_Base;
gel5_3Osctv_FF.gelName = gelName;
gel5_3Osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-3 FF-R)\';
gel5_3Osctv_FF.controlPath = controlPath;
gel5_3Osctv_FF.catheterCoordsFile = catheterCoordsFile;
gel5_3Osctv_FF.reconNumberStart = 1;

gel5_3Osctv_RR = osctv_RR_Base;
gel5_3Osctv_RR.gelName = gelName;
gel5_3Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-3)\';
gel5_3Osctv_RR.controlPath = controlPath;
gel5_3Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel5_3Osctv_RR.reconNumberStart = 2;

gel5_3Osctv_FF_RR = osctv_FF_RR_Base;
gel5_3Osctv_FF_RR.gelName = gelName;
gel5_3Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-3 FF-R)\';
gel5_3Osctv_FF_RR.controlPath = controlPath;
gel5_3Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel5_3Osctv_FF_RR.reconNumberStart = 2;


% ** Gel 5-1/5-4 (5 Cathteters) **
controlPath = 'E:\Thesis Recon Data\Gel 5-1\Gel 5-1_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 5-4\Catheter Coords.mat';
gelName = 'Gel 5-4';

gel5_4Control = fdkBase;
gel5_4Control.gelName = 'Gel 5-1';
gel5_4Control.readPath = 'E:\Thesis Recon Data\Gel 5-1\Gel 5-1_HR.vff';
gel5_4Control.controlPath = controlPath;
gel5_4Control.catheterCoordsFile = catheterCoordsFile;

gel5_4Fdk = fdkBase;
gel5_4Fdk.gelName = gelName;
gel5_4Fdk.readPath = 'E:\Thesis Recon Data\Gel 5-4\Gel 5-4_HR.vff';
gel5_4Fdk.controlPath = controlPath;
gel5_4Fdk.catheterCoordsFile = catheterCoordsFile;

gel5_4Osctv = osctv_Base;
gel5_4Osctv.gelName = gelName;
gel5_4Osctv.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-4)\';
gel5_4Osctv.controlPath = controlPath;
gel5_4Osctv.catheterCoordsFile = catheterCoordsFile;
gel5_4Osctv.reconNumberStart = 1;

gel5_4Osctv_FF = osctv_FF_Base;
gel5_4Osctv_FF.gelName = gelName;
gel5_4Osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-4 FF-R)\';
gel5_4Osctv_FF.controlPath = controlPath;
gel5_4Osctv_FF.catheterCoordsFile = catheterCoordsFile;
gel5_4Osctv_FF.reconNumberStart = 1;

gel5_4Osctv_RR = osctv_RR_Base;
gel5_4Osctv_RR.gelName = gelName;
gel5_4Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-4)\';
gel5_4Osctv_RR.controlPath = controlPath;
gel5_4Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel5_4Osctv_RR.reconNumberStart = 2;

gel5_4Osctv_FF_RR = osctv_FF_RR_Base;
gel5_4Osctv_FF_RR.gelName = gelName;
gel5_4Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-4 FF-R)\';
gel5_4Osctv_FF_RR.controlPath = controlPath;
gel5_4Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel5_4Osctv_FF_RR.reconNumberStart = 2;

  
% *********
% ** RUN **
% *********

crunchParameterOptimizationMetrics(...
    {...
    gel2_2Control, gel2_2Fdk, gel2_2Osctv, gel2_2Osctv_FF, gel2_2Osctv_RR, gel2_2Osctv_FF_RR,...
    gel2_4Control, gel2_4Fdk, gel2_4Osctv, gel2_4Osctv_FF, gel2_4Osctv_RR, gel2_4Osctv_FF_RR,...    
    gel4_2Control, gel4_2Fdk, gel4_2Osctv, gel4_2Osctv_FF, gel4_2Osctv_RR, gel4_2Osctv_FF_RR,...  
    gel4_4Control, gel4_4Fdk, gel4_4Osctv, gel4_4Osctv_FF, gel4_4Osctv_RR, gel4_4Osctv_FF_RR,...
    gel5_2Control, gel5_2Fdk, gel5_2Osctv, gel5_2Osctv_FF, gel5_2Osctv_RR, gel5_2Osctv_FF_RR,...
    gel5_3Control, gel5_3Fdk, gel5_3Osctv, gel5_3Osctv_FF, gel5_3Osctv_RR, gel5_3Osctv_FF_RR,...
    gel5_4Control, gel5_4Fdk, gel5_4Osctv, gel5_4Osctv_FF, gel5_4Osctv_RR, gel5_4Osctv_FF_RR...
    },...
    catheterMaskRadius,...
    writePath, sheetName);
