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

gel500MU_Control = fdkBase;
gel500MU_Control.gelName = 'Gel 2-1';
gel500MU_Control.readPath = 'E:\Thesis Recon Data\Gel 2-1\Gel 2-1_HR.vff';
gel500MU_Control.controlPath = controlPath;
gel500MU_Control.catheterCoordsFile = catheterCoordsFile;

gel500MU_Fdk = fdkBase;
gel500MU_Fdk.gelName = gelName;
gel500MU_Fdk.readPath = 'E:\Thesis Recon Data\Gel 2-2\Gel 2-2_HR.vff';
gel500MU_Fdk.controlPath = controlPath;
gel500MU_Fdk.catheterCoordsFile = catheterCoordsFile;

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
gel500MU_Osctv_RR.usedCatheterReject = true;
gel500MU_Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-2)\';
gel500MU_Osctv_RR.controlPath = controlPath;
gel500MU_Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel500MU_Osctv_RR.reconNumberStart = 2;

gel500MU_Osctv_FF_RR = osctvBaseFF;
gel500MU_Osctv_FF_RR.gelName = gelName;
gel500MU_Osctv_FF_RR.usedCatheterReject = true;
gel500MU_Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-2 FF-R)\';
gel500MU_Osctv_FF_RR.controlPath = controlPath;
gel500MU_Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel500MU_Osctv_FF_RR.reconNumberStart = 2;


% ** Gel 2-3/2-4 (1500MU) **
controlPath = 'E:\Thesis Recon Data\Gel 2-3\Gel 2-3_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 2-4\Catheter Coords.mat';
gelName = 'Gel 2-4';

gel1500MU_Control = fdkBase;
gel1500MU_Control.gelName = 'Gel 2-3';
gel1500MU_Control.readPath = 'E:\Thesis Recon Data\Gel 2-3\Gel 2-3_HR.vff';
gel1500MU_Control.controlPath = controlPath;
gel1500MU_Control.catheterCoordsFile = catheterCoordsFile;

gel1500MU_Fdk = fdkBase;
gel1500MU_Fdk.gelName = gelName;
gel1500MU_Fdk.readPath = 'E:\Thesis Recon Data\Gel 2-4\Gel 2-4_HR.vff';
gel1500MU_Fdk.controlPath = controlPath;
gel1500MU_Fdk.catheterCoordsFile = catheterCoordsFile;

gel1500MU_Osctv = osctvBase;
gel1500MU_Osctv.gelName = gelName;
gel1500MU_Osctv.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-4)\';
gel1500MU_Osctv.controlPath = controlPath;
gel1500MU_Osctv.catheterCoordsFile = catheterCoordsFile;
gel1500MU_Osctv.reconNumberStart = 51;

gel1500MU_Osctv_FF = osctvBaseFF;
gel1500MU_Osctv_FF.gelName = gelName;
gel1500MU_Osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-4 FF-R)\';
gel1500MU_Osctv_FF.controlPath = controlPath;
gel1500MU_Osctv_FF.catheterCoordsFile = catheterCoordsFile;
gel1500MU_Osctv_FF.reconNumberStart = 51;

gel1500MU_Osctv_RR = osctvBase;
gel1500MU_Osctv_RR.gelName = gelName;
gel1500MU_Osctv_RR.usedCatheterReject = true;
gel1500MU_Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-4)\';
gel1500MU_Osctv_RR.controlPath = controlPath;
gel1500MU_Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel1500MU_Osctv_RR.reconNumberStart = 52;

gel1500MU_Osctv_FF_RR = osctvBaseFF;
gel1500MU_Osctv_FF_RR.gelName = gelName;
gel1500MU_Osctv_FF_RR.usedCatheterReject = true;
gel1500MU_Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-4 FF-R)\';
gel1500MU_Osctv_FF_RR.controlPath = controlPath;
gel1500MU_Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel1500MU_Osctv_FF_RR.reconNumberStart = 52;


% ** Gel 4-1/4-2 (2000MU) **
controlPath = 'E:\Thesis Recon Data\Gel 4-1\Gel 4-1_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 4-2\Catheter Coords.mat';
gelName = 'Gel 4-2';

gel2000MU_Control = fdkBase;
gel2000MU_Control.gelName = 'Gel 4-1';
gel2000MU_Control.readPath = 'E:\Thesis Recon Data\Gel 4-1\Gel 4-1_HR.vff';
gel2000MU_Control.controlPath = controlPath;
gel2000MU_Control.catheterCoordsFile = catheterCoordsFile;

gel2000MU_Fdk = fdkBase;
gel2000MU_Fdk.gelName = gelName;
gel2000MU_Fdk.readPath = 'E:\Thesis Recon Data\Gel 4-2\Gel 4-2_HR.vff';
gel2000MU_Fdk.controlPath = controlPath;
gel2000MU_Fdk.catheterCoordsFile = catheterCoordsFile;

gel2000MU_Osctv = osctvBase;
gel2000MU_Osctv.gelName = gelName;
gel2000MU_Osctv.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2)\';
gel2000MU_Osctv.controlPath = controlPath;
gel2000MU_Osctv.catheterCoordsFile = catheterCoordsFile;
gel2000MU_Osctv.reconNumberStart = 57;

gel2000MU_Osctv_FF = osctvBaseFF;
gel2000MU_Osctv_FF.gelName = gelName;
gel2000MU_Osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2 FF-R)\';
gel2000MU_Osctv_FF.controlPath = controlPath;
gel2000MU_Osctv_FF.catheterCoordsFile = catheterCoordsFile;
gel2000MU_Osctv_FF.reconNumberStart = 57;

gel2000MU_Osctv_RR = osctvBase;
gel2000MU_Osctv_RR.gelName = gelName;
gel2000MU_Osctv_RR.usedCatheterReject = true;
gel2000MU_Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2)\';
gel2000MU_Osctv_RR.controlPath = controlPath;
gel2000MU_Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel2000MU_Osctv_RR.reconNumberStart = 157;

gel2000MU_Osctv_FF_RR = osctvBaseFF;
gel2000MU_Osctv_FF_RR.gelName = gelName;
gel2000MU_Osctv_FF_RR.usedCatheterReject = true;
gel2000MU_Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2 FF-R)\';
gel2000MU_Osctv_FF_RR.controlPath = controlPath;
gel2000MU_Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel2000MU_Osctv_FF_RR.reconNumberStart = 157;


% ** Gel 4-3/4-4 (2500MU) **
controlPath = 'E:\Thesis Recon Data\Gel 4-3\Gel 4-3_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 4-4\Catheter Coords.mat';
gelName = 'Gel 4-4';

gel2500MU_Control = fdkBase;
gel2500MU_Control.gelName = 'Gel 4-3';
gel2500MU_Control.readPath = 'E:\Thesis Recon Data\Gel 4-3\Gel 4-3_HR.vff';
gel2500MU_Control.controlPath = controlPath;
gel2500MU_Control.catheterCoordsFile = catheterCoordsFile;

gel2500MU_Fdk = fdkBase;
gel2500MU_Fdk.gelName = gelName;
gel2500MU_Fdk.readPath = 'E:\Thesis Recon Data\Gel 4-4\Gel 4-4_HR.vff';
gel2500MU_Fdk.controlPath = controlPath;
gel2500MU_Fdk.catheterCoordsFile = catheterCoordsFile;

gel2500MU_Osctv = osctvBase;
gel2500MU_Osctv.gelName = gelName;
gel2500MU_Osctv.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-4)\';
gel2500MU_Osctv.controlPath = controlPath;
gel2500MU_Osctv.catheterCoordsFile = catheterCoordsFile;
gel2500MU_Osctv.reconNumberStart = 1;

gel2500MU_Osctv_FF = osctvBaseFF;
gel2500MU_Osctv_FF.gelName = gelName;
gel2500MU_Osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-4 FF-R)\';
gel2500MU_Osctv_FF.controlPath = controlPath;
gel2500MU_Osctv_FF.catheterCoordsFile = catheterCoordsFile;
gel2500MU_Osctv_FF.reconNumberStart = 1;

gel2500MU_Osctv_RR = osctvBase;
gel2500MU_Osctv_RR.gelName = gelName;
gel2500MU_Osctv_RR.usedCatheterReject = true;
gel2500MU_Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-4)\';
gel2500MU_Osctv_RR.controlPath = controlPath;
gel2500MU_Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel2500MU_Osctv_RR.reconNumberStart = 2;

gel2500MU_Osctv_FF_RR = osctvBaseFF;
gel2500MU_Osctv_FF_RR.gelName = gelName;
gel2500MU_Osctv_FF_RR.usedCatheterReject = true;
gel2500MU_Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-4 FF-R)\';
gel2500MU_Osctv_FF_RR.controlPath = controlPath;
gel2500MU_Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel2500MU_Osctv_FF_RR.reconNumberStart = 2;


% ** Gel 5-1/5-2 (Offset Cathteter) **
controlPath = 'E:\Thesis Recon Data\Gel 5-1\Gel 5-1_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 5-2\Catheter Coords.mat';
gelName = 'Gel 5-2';

gel1CathOffset_Control = fdkBase;
gel1CathOffset_Control.gelName = 'Gel 5-1';
gel1CathOffset_Control.readPath = 'E:\Thesis Recon Data\Gel 5-1\Gel 5-1_HR.vff';
gel1CathOffset_Control.controlPath = controlPath;
gel1CathOffset_Control.catheterCoordsFile = catheterCoordsFile;

gel1CathOffset_Fdk = fdkBase;
gel1CathOffset_Fdk.gelName = gelName;
gel1CathOffset_Fdk.readPath = 'E:\Thesis Recon Data\Gel 5-2\Gel 5-2_HR.vff';
gel1CathOffset_Fdk.controlPath = controlPath;
gel1CathOffset_Fdk.catheterCoordsFile = catheterCoordsFile;

gel1CathOffset_Osctv = osctvBase;
gel1CathOffset_Osctv.gelName = gelName;
gel1CathOffset_Osctv.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-2)\';
gel1CathOffset_Osctv.controlPath = controlPath;
gel1CathOffset_Osctv.catheterCoordsFile = catheterCoordsFile;
gel1CathOffset_Osctv.reconNumberStart = 1;

gel1CathOffset_Osctv_FF = osctvBaseFF;
gel1CathOffset_Osctv_FF.gelName = gelName;
gel1CathOffset_Osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-2 FF-R)\';
gel1CathOffset_Osctv_FF.controlPath = controlPath;
gel1CathOffset_Osctv_FF.catheterCoordsFile = catheterCoordsFile;
gel1CathOffset_Osctv_FF.reconNumberStart = 1;

gel1CathOffset_Osctv_RR = osctvBase;
gel1CathOffset_Osctv_RR.gelName = gelName;
gel1CathOffset_Osctv_RR.usedCatheterReject = true;
gel1CathOffset_Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-2)\';
gel1CathOffset_Osctv_RR.controlPath = controlPath;
gel1CathOffset_Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel1CathOffset_Osctv_RR.reconNumberStart = 2;

gel1CathOffset_Osctv_FF_RR = osctvBaseFF;
gel1CathOffset_Osctv_FF_RR.gelName = gelName;
gel1CathOffset_Osctv_FF_RR.usedCatheterReject = true;
gel1CathOffset_Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-2 FF-R)\';
gel1CathOffset_Osctv_FF_RR.controlPath = controlPath;
gel1CathOffset_Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel1CathOffset_Osctv_FF_RR.reconNumberStart = 2;


% ** Gel 5-1/5-3 (3 Cathteters) **
controlPath = 'E:\Thesis Recon Data\Gel 5-1\Gel 5-1_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 5-3\Catheter Coords.mat';
gelName = 'Gel 5-3';

gel3Cath_Control = fdkBase;
gel3Cath_Control.gelName = 'Gel 5-1';
gel3Cath_Control.readPath = 'E:\Thesis Recon Data\Gel 5-1\Gel 5-1_HR.vff';
gel3Cath_Control.controlPath = controlPath;
gel3Cath_Control.catheterCoordsFile = catheterCoordsFile;

gel3Cath_Fdk = fdkBase;
gel3Cath_Fdk.gelName = gelName;
gel3Cath_Fdk.readPath = 'E:\Thesis Recon Data\Gel 5-3\Gel 5-3_HR.vff';
gel3Cath_Fdk.controlPath = controlPath;
gel3Cath_Fdk.catheterCoordsFile = catheterCoordsFile;

gel3Cath_Osctv = osctvBase;
gel3Cath_Osctv.gelName = gelName;
gel3Cath_Osctv.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-3)\';
gel3Cath_Osctv.controlPath = controlPath;
gel3Cath_Osctv.catheterCoordsFile = catheterCoordsFile;
gel3Cath_Osctv.reconNumberStart = 1;

gel3Cath_Osctv_FF = osctvBaseFF;
gel3Cath_Osctv_FF.gelName = gelName;
gel3Cath_Osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-3 FF-R)\';
gel3Cath_Osctv_FF.controlPath = controlPath;
gel3Cath_Osctv_FF.catheterCoordsFile = catheterCoordsFile;
gel3Cath_Osctv_FF.reconNumberStart = 1;

gel3Cath_Osctv_RR = osctvBase;
gel3Cath_Osctv_RR.gelName = gelName;
gel3Cath_Osctv_RR.usedCatheterReject = true;
gel3Cath_Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-3)\';
gel3Cath_Osctv_RR.controlPath = controlPath;
gel3Cath_Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel3Cath_Osctv_RR.reconNumberStart = 2;

gel3Cath_Osctv_FF_RR = osctvBaseFF;
gel3Cath_Osctv_FF_RR.gelName = gelName;
gel3Cath_Osctv_FF_RR.usedCatheterReject = true;
gel3Cath_Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-3 FF-R)\';
gel3Cath_Osctv_FF_RR.controlPath = controlPath;
gel3Cath_Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel3Cath_Osctv_FF_RR.reconNumberStart = 2;


% ** Gel 5-1/5-4 (5 Cathteters) **
controlPath = 'E:\Thesis Recon Data\Gel 5-1\Gel 5-1_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 5-4\Catheter Coords.mat';
gelName = 'Gel 5-4';

gel5Cath_Control = fdkBase;
gel5Cath_Control.gelName = 'Gel 5-1';
gel5Cath_Control.readPath = 'E:\Thesis Recon Data\Gel 5-1\Gel 5-1_HR.vff';
gel5Cath_Control.controlPath = controlPath;
gel5Cath_Control.catheterCoordsFile = catheterCoordsFile;

gel5Cath_Fdk = fdkBase;
gel5Cath_Fdk.gelName = gelName;
gel5Cath_Fdk.readPath = 'E:\Thesis Recon Data\Gel 5-4\Gel 5-4_HR.vff';
gel5Cath_Fdk.controlPath = controlPath;
gel5Cath_Fdk.catheterCoordsFile = catheterCoordsFile;

gel5Cath_Osctv = osctvBase;
gel5Cath_Osctv.gelName = gelName;
gel5Cath_Osctv.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-4)\';
gel5Cath_Osctv.controlPath = controlPath;
gel5Cath_Osctv.catheterCoordsFile = catheterCoordsFile;
gel5Cath_Osctv.reconNumberStart = 1;

gel5Cath_Osctv_FF = osctvBaseFF;
gel5Cath_Osctv_FF.gelName = gelName;
gel5Cath_Osctv_FF.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-4 FF-R)\';
gel5Cath_Osctv_FF.controlPath = controlPath;
gel5Cath_Osctv_FF.catheterCoordsFile = catheterCoordsFile;
gel5Cath_Osctv_FF.reconNumberStart = 1;

gel5Cath_Osctv_RR = osctvBase;
gel5Cath_Osctv_RR.gelName = gelName;
gel5Cath_Osctv_RR.usedCatheterReject = true;
gel5Cath_Osctv_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-4)\';
gel5Cath_Osctv_RR.controlPath = controlPath;
gel5Cath_Osctv_RR.catheterCoordsFile = catheterCoordsFile;
gel5Cath_Osctv_RR.reconNumberStart = 2;

gel5Cath_Osctv_FF_RR = osctvBaseFF;
gel5Cath_Osctv_FF_RR.gelName = gelName;
gel5Cath_Osctv_FF_RR.usedCatheterReject = true;
gel5Cath_Osctv_FF_RR.readPath = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 5-4 FF-R)\';
gel5Cath_Osctv_FF_RR.controlPath = controlPath;
gel5Cath_Osctv_FF_RR.catheterCoordsFile = catheterCoordsFile;
gel5Cath_Osctv_FF_RR.reconNumberStart = 2;

  
%%
% *********
% ** RUN **
% *********

crunchParameterOptimizationMetrics(...
    {...
    gel500MU_Control, gel500MU_Fdk, gel500MU_Osctv, gel500MU_Osctv_FF, gel500MU_Osctv_RR, gel500MU_Osctv_FF_RR,...
    gel1500MU_Control, gel1500MU_Fdk, gel1500MU_Osctv, gel1500MU_Osctv_FF, gel1500MU_Osctv_RR, gel1500MU_Osctv_FF_RR,...    
    gel2000MU_Control, gel2000MU_Fdk, gel2000MU_Osctv, gel2000MU_Osctv_FF, gel2000MU_Osctv_RR, gel2000MU_Osctv_FF_RR,...  
    gel2500MU_Control, gel2500MU_Fdk, gel2500MU_Osctv, gel2500MU_Osctv_FF, gel2500MU_Osctv_RR, gel2500MU_Osctv_FF_RR,...
    gel1CathOffset_Control, gel1CathOffset_Fdk, gel1CathOffset_Osctv, gel1CathOffset_Osctv_FF, gel1CathOffset_Osctv_RR, gel1CathOffset_Osctv_FF_RR,...
    gel3Cath_Control, gel3Cath_Fdk, gel3Cath_Osctv, gel3Cath_Osctv_FF, gel3Cath_Osctv_RR, gel3Cath_Osctv_FF_RR,...
    gel5Cath_Control, gel5Cath_Fdk, gel5Cath_Osctv, gel5Cath_Osctv_FF, gel5Cath_Osctv_RR, gel5Cath_Osctv_FF_RR,...
    },...
    catheterMaskRadius,...
    writePath, sheetName);
