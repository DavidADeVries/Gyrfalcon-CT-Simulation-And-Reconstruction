% output params
writePath = 'E:\Thesis Results\External Beam Trials.xls';
sheetName = 'OSC-TV All Trials';

% general params
catheterMaskRadius = 5;

% Set-up base for FDK analysis
fdkBase = AnalysisRun;
fdkBase.usedCatheterReject = false;
fdkBase.reconAlgorithm = 'FDK';

% Set-up base for OSC-TV
osctvBase = AnalysisRun;
osctvBase.usedCatheterReject = false;
osctvBase.reconAlgorithm = 'OSC-TV';
osctvBase.numIterationsValues = {'40'};
osctvBase.numSubsetsValues = {'[205 41]'};

osctvBase.usedFloodFields = false;
osctvBase.cValues = {'0.01'};

osctvBaseFF = osctvBase;
osctvBaseFF.usedFloodFields = true;
osctvBaseFF.cValues = {'0.005'};


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

gel500MU_Osctv = osctvBase;
gel500MU_Osctv.gelName = gelName;
gel500MU_Osctv.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-2)\';
gel500MU_Osctv.controlPath = controlPath;
gel500MU_Osctv.catheterCoordsFile = catheterCoordsFile;
gel500MU_Osctv.reconNumberStart = 1;

gel500MU_Osctv_FF = osctvBaseFF;
gel500MU_Osctv_FF.gelName = gelName;
gel500MU_Osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-2 FF-R)\';
gel500MU_Osctv_FF.controlPath = controlPath;
gel500MU_Osctv_FF.catheterCoordsFile = catheterCoordsFile;
gel500MU_Osctv_FF.reconNumberStart = 1;

gel500MU_Osctv_RR = osctvBase;
gel500MU_Osctv_RR.gelName = gelName;
gel500MU_Osctv_RR.usedCatheterReject = false;
gel500MU_Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-2)\';
gel500MU_Osctv_RR.controlPath = controlPath;
gel500MU_Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel500MU_Osctv_RR.reconNumberStart = 2;

gel500MU_Osctv_FF_RR = osctvBaseFF;
gel500MU_Osctv_FF_RR.gelName = gelName;
gel500MU_Osctv_FF_RR.usedCatheterReject = false;
gel500MU_Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-2 FF-R)\';
gel500MU_Osctv_FF_RR.controlPath = controlPath;
gel500MU_Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel500MU_Osctv_FF_RR.reconNumberStart = 2;


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

gel2_4OsctvNoFF = osctvBase;
gel2_4OsctvNoFF.gelName = gelName;
gel2_4OsctvNoFF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-4)\';
gel2_4OsctvNoFF.controlPath = controlPath;
gel2_4OsctvNoFF.catheterCoordsFile = catheterCoordsFile;
gel2_4OsctvNoFF.reconNumberStart = 51;

gel2_4OsctvFF = osctvBaseFF;
gel2_4OsctvFF.gelName = gelName;
gel2_4OsctvFF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-4 FF-R)\';
gel2_4OsctvFF.controlPath = controlPath;
gel2_4OsctvFF.catheterCoordsFile = catheterCoordsFile;
gel2_4OsctvFF.reconNumberStart = 51;


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

gel4_2OsctvNoFF = osctvBase;
gel4_2OsctvNoFF.gelName = gelName;
gel4_2OsctvNoFF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2)\';
gel4_2OsctvNoFF.controlPath = controlPath;
gel4_2OsctvNoFF.catheterCoordsFile = catheterCoordsFile;
gel4_2OsctvNoFF.reconNumberStart = 57;

gel4_2OsctvFF = osctvBaseFF;
gel4_2OsctvFF.gelName = gelName;
gel4_2OsctvFF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2 FF-R)\';
gel4_2OsctvFF.controlPath = controlPath;
gel4_2OsctvFF.catheterCoordsFile = catheterCoordsFile;
gel4_2OsctvFF.reconNumberStart = 57;


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

gel4_4OsctvNoFF = osctvBase;
gel4_4OsctvNoFF.gelName = gelName;
gel4_4OsctvNoFF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-4)\';
gel4_4OsctvNoFF.controlPath = controlPath;
gel4_4OsctvNoFF.catheterCoordsFile = catheterCoordsFile;
gel4_4OsctvNoFF.reconNumberStart = 1;

gel4_4OsctvFF = osctvBaseFF;
gel4_4OsctvFF.gelName = gelName;
gel4_4OsctvFF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-4 FF-R)\';
gel4_4OsctvFF.controlPath = controlPath;
gel4_4OsctvFF.catheterCoordsFile = catheterCoordsFile;
gel4_4OsctvFF.reconNumberStart = 1;


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

gel5_2OsctvNoFF = osctvBase;
gel5_2OsctvNoFF.gelName = gelName;
gel5_2OsctvNoFF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-2)\';
gel5_2OsctvNoFF.controlPath = controlPath;
gel5_2OsctvNoFF.catheterCoordsFile = catheterCoordsFile;
gel5_2OsctvNoFF.reconNumberStart = 1;

gel5_2OsctvFF = osctvBaseFF;
gel5_2OsctvFF.gelName = gelName;
gel5_2OsctvFF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-2 FF-R)\';
gel5_2OsctvFF.controlPath = controlPath;
gel5_2OsctvFF.catheterCoordsFile = catheterCoordsFile;
gel5_2OsctvFF.reconNumberStart = 1;


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

gel5_3OsctvNoFF = osctvBase;
gel5_3OsctvNoFF.gelName = gelName;
gel5_3OsctvNoFF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-3)\';
gel5_3OsctvNoFF.controlPath = controlPath;
gel5_3OsctvNoFF.catheterCoordsFile = catheterCoordsFile;
gel5_3OsctvNoFF.reconNumberStart = 1;

gel5_3OsctvFF = osctvBaseFF;
gel5_3OsctvFF.gelName = gelName;
gel5_3OsctvFF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-3 FF-R)\';
gel5_3OsctvFF.controlPath = controlPath;
gel5_3OsctvFF.catheterCoordsFile = catheterCoordsFile;
gel5_3OsctvFF.reconNumberStart = 1;


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

gel5_4OsctvNoFF = osctvBase;
gel5_4OsctvNoFF.gelName = gelName;
gel5_4OsctvNoFF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-4)\';
gel5_4OsctvNoFF.controlPath = controlPath;
gel5_4OsctvNoFF.catheterCoordsFile = catheterCoordsFile;
gel5_4OsctvNoFF.reconNumberStart = 1;

gel5_4OsctvFF = osctvBaseFF;
gel5_4OsctvFF.gelName = gelName;
gel5_4OsctvFF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-4 FF-R)\';
gel5_4OsctvFF.controlPath = controlPath;
gel5_4OsctvFF.catheterCoordsFile = catheterCoordsFile;
gel5_4OsctvFF.reconNumberStart = 1;

  
% *********
% ** RUN **
% *********

crunchParameterOptimizationMetrics(...
    {...
    gel2_2Control, gel2_2Fdk, gel500MU_Osctv, gel500MU_Osctv_FF,...
    gel2_4Control, gel2_4Fdk, gel2_4OsctvNoFF, gel2_4OsctvFF,...    
    gel4_2Control, gel4_2Fdk, gel4_2OsctvNoFF, gel4_2OsctvFF,...  
    gel4_4Control, gel4_4Fdk, gel4_4OsctvNoFF, gel4_4OsctvFF,...
    gel5_2Control, gel5_2Fdk, gel5_2OsctvNoFF, gel5_2OsctvFF,...
    gel5_3Control, gel5_3Fdk, gel5_3OsctvNoFF, gel5_3OsctvFF,...
    gel5_4Control, gel5_4Fdk, gel5_4OsctvNoFF, gel5_4OsctvFF,...
    },...
    catheterMaskRadius,...
    writePath, sheetName);
