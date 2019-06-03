% **************************************
% Set Base Params
% **************************************
readPath = 'E:\Thesis Results\External Beam Trials.xls';
sheet = 'Stand. OSC-TV All Trials';

groupLabels = {...
    '\begin{tabular}{c}1 Cath.\end{tabular}',...
    '\begin{tabular}{c}1 Cath.\\(Offset)\end{tabular}',...
    '\begin{tabular}{c}3 Cath.\end{tabular}',...
    '\begin{tabular}{c}5 Cath.\end{tabular}'};

groupRows = {...
    11:12,...
    19:20,...
    23:24,...
    27:28};    

subgroupLabels = {...
    'Control',...
    'Catheter'};

subgroupColours = [...
    0.75 0.75 0.75;...
    0.25 0.25 0.25];

customColours = {...
    [],...
    [],...
    [],...
    []};

figDimsInCm = [5, 7.4];

subgroupLabelWriteIndex = 1;

% **************************************
% Mean
% **************************************

graphWritePath = 'E:\Thesis Figures\Results\Artifact Characterization\Num Catheters Bar Graphs\Mean Comparison.png';

column = 28;

yAxisLabel = '$\bar{\Delta}\mu_{ROI}$ $[cm^-1]$';

title = '$\bar{\Delta}\mu_{ROI}$';

f = @(x) x ./ 100;

subgroupLabelOrientation = {...
    'above',...
    'above'};

subgroupLabelAngle = {...
    30,...
    30};

lineAtBar = [];
linePosAndNeg = true;

barGraphDataCollectionAndCreation(...
    readPath, sheet, groupRows, column,...
    graphWritePath, groupLabels, subgroupLabels,...
    subgroupLabelWriteIndex, subgroupLabelOrientation, subgroupLabelAngle,...
    figDimsInCm, subgroupColours, customColours,...
    yAxisLabel, title, f, lineAtBar, linePosAndNeg); 

% **************************************
% Stdev
% **************************************

graphWritePath = 'E:\Thesis Figures\Results\Artifact Characterization\Num Catheters Bar Graphs\Stdev Comparison.png';

column = 31;

yAxisLabel = '$\sigma_{ROI}$ $[cm^-1]$';

title = '$\sigma_{ROI}$';

f = @(x) x ./ 100;

subgroupLabelOrientation = {...
    'above',...
    'above'};

subgroupLabelAngle = {...
    50,...
    50};

lineAtBar = [];
linePosAndNeg = true;

subgroupLabels = {...
    };

subgroupLabelWriteIndex = Inf;

barGraphDataCollectionAndCreation(...
    readPath, sheet, groupRows, column,...
    graphWritePath, groupLabels, subgroupLabels,...
    subgroupLabelWriteIndex, subgroupLabelOrientation, subgroupLabelAngle,...
    figDimsInCm, subgroupColours, customColours,...
    yAxisLabel, title, f, lineAtBar, linePosAndNeg); 

% **************************************
% Gradient Mean
% **************************************

graphWritePath = 'E:\Thesis Figures\Results\Artifact Characterization\Num Catheters Bar Graphs\Gradient Comparison.png';

column = 34;

yAxisLabel = '$\bar{\nabla}_{ROI}$ $[cm^{-1} / mm]$';

title = '$\bar{\nabla}_{ROI}$';

f = @(x) x ./ 100;

subgroupLabelOrientation = {...
    'above',...
    'above'};

subgroupLabelAngle = {...
    50,...
    50};

lineAtBar = [];
linePosAndNeg = true;

barGraphDataCollectionAndCreation(...
    readPath, sheet, groupRows, column,...
    graphWritePath, groupLabels, subgroupLabels,...
    subgroupLabelWriteIndex, subgroupLabelOrientation, subgroupLabelAngle,...
    figDimsInCm, subgroupColours, customColours,...
    yAxisLabel, title, f, lineAtBar, linePosAndNeg); 

% **************************************
% Delta Mean
% **************************************

groupRows = {...
    12,...
    20,...
    24,...
    28};

subgroupLabels = {...
    };

subgroupColours = [...
    0.25 0.25 0.25];


graphWritePath = 'E:\Thesis Figures\Results\Artifact Characterization\Num Catheters Bar Graphs\Delta Comparison.png';

column = 40;

yAxisLabel = '$\bar{\Delta}_{ROI}$ $[cm^{-1}]$';

title = '$\bar{\Delta}_{ROI}$';

f = @(x) x ./ 100;

subgroupLabelOrientation = {...
    'above',...
    'above'};

subgroupLabelAngle = {...
    50,...
    50};

lineAtBar = [];
linePosAndNeg = true;

barGraphDataCollectionAndCreation(...
    readPath, sheet, groupRows, column,...
    graphWritePath, groupLabels, subgroupLabels,...
    subgroupLabelWriteIndex, subgroupLabelOrientation, subgroupLabelAngle,...
    figDimsInCm, subgroupColours, customColours,...
    yAxisLabel, title, f, lineAtBar, linePosAndNeg); 

