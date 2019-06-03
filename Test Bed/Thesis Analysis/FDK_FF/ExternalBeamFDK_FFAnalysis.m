% output params
writePath = 'E:\Thesis Results\External Beam Trials.xls';
sheetName = 'FDK_FF 2';

% general params
catheterMaskRadius = 5;

% Set-up base for FDK analysis
fdkBase = AnalysisRun;
fdkBase.usedCatheterReject = false;
fdkBase.reconAlgorithm = 'FDK';


% ** Gel 2-3/2-4 Pre/Post  **
controlPath = 'E:\Thesis Recon Data\Gel 2-3 (FF-R)\Gel 2-3 (FF-R)_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 2-4\Catheter Coords.mat';

gel2_4PreControl = fdkBase;
gel2_4PreControl.gelName = 'Gel 2-3 Pre';
gel2_4PreControl.readPath = 'E:\Thesis Recon Data\Gel 2-3 (FF-R)\Gel 2-3 (FF-R)_HR.vff';
gel2_4PreControl.controlPath = controlPath;
gel2_4PreControl.catheterCoordsFile = catheterCoordsFile;

gel2_4Pre = fdkBase;
gel2_4Pre.gelName = 'Gel 2-4 Pre';
gel2_4Pre.readPath = 'E:\Thesis Recon Data\Gel 2-4 (FF-R)\Gel 2-4 (FF-R)_HR.vff';
gel2_4Pre.controlPath = controlPath;
gel2_4Pre.catheterCoordsFile = catheterCoordsFile;

controlPath = 'E:\Thesis Recon Data\Gel 2-3 (FF-D)\Gel 2-3 (FF-D)_HR.vff';

gel2_4PostControl = fdkBase;
gel2_4PostControl.gelName = 'Gel 2-3 Post';
gel2_4PostControl.readPath = 'E:\Thesis Recon Data\Gel 2-3 (FF-D)\Gel 2-3 (FF-D)_HR.vff';
gel2_4PostControl.controlPath = controlPath;
gel2_4PostControl.catheterCoordsFile = catheterCoordsFile;

gel2_4Post = fdkBase;
gel2_4Post.gelName = 'Gel 2-4 Post';
gel2_4Post.readPath = 'E:\Thesis Recon Data\Gel 2-4 (FF-D)\Gel 2-4 (FF-D)_HR.vff';
gel2_4Post.controlPath = controlPath;
gel2_4Post.catheterCoordsFile = catheterCoordsFile;

% ** Gel 4-1/4-2 Pre/Post  **
controlPath = 'E:\Thesis Recon Data\Gel 4-1 (FF-R)\Gel 4-1 (FF-R)_HR.vff';
catheterCoordsFile = 'E:\Thesis Recon Data\Gel 4-2\Catheter Coords.mat';

gel4_2PreControl = fdkBase;
gel4_2PreControl.gelName = 'Gel 4-1 Pre';
gel4_2PreControl.readPath = 'E:\Thesis Recon Data\Gel 4-1 (FF-R)\Gel 4-1 (FF-R)_HR.vff';
gel4_2PreControl.controlPath = controlPath;
gel4_2PreControl.catheterCoordsFile = catheterCoordsFile;

gel4_2Pre = fdkBase;
gel4_2Pre.gelName = 'Gel 4-2 Pre';
gel4_2Pre.readPath = 'E:\Thesis Recon Data\Gel 4-2 (FF-R)\Gel 4-2 (FF-R)_HR.vff';
gel4_2Pre.controlPath = controlPath;
gel4_2Pre.catheterCoordsFile = catheterCoordsFile;

controlPath = 'E:\Thesis Recon Data\Gel 4-1 (FF-D)\Gel 4-1 (FF-D)_HR.vff';

gel4_2PostControl = fdkBase;
gel4_2PostControl.gelName = 'Gel 4-1 Post';
gel4_2PostControl.readPath = 'E:\Thesis Recon Data\Gel 4-1 (FF-D)\Gel 4-1 (FF-D)_HR.vff';
gel4_2PostControl.controlPath = controlPath;
gel4_2PostControl.catheterCoordsFile = catheterCoordsFile;

gel4_2Post = fdkBase;
gel4_2Post.gelName = 'Gel 4-2 Post';
gel4_2Post.readPath = 'E:\Thesis Recon Data\Gel 4-2 (FF-D)\Gel 4-2 (FF-D)_HR.vff';
gel4_2Post.controlPath = controlPath;
gel4_2Post.catheterCoordsFile = catheterCoordsFile;

  
% *********
% ** RUN **
% *********

crunchParameterOptimizationMetrics(...
    {...
    gel2_4PreControl, gel2_4PostControl, gel4_2PreControl, gel4_2PostControl,...
    gel2_4Pre, gel2_4Post, gel4_2Pre, gel4_2Post...
    },...
    catheterMaskRadius,...
    writePath, sheetName);

