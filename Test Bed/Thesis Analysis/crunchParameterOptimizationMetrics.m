function [] = crunchParameterOptimizationMetrics(analysisRuns, catheterMaskRadius, writePath, sheetName)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

% ********************************************
% Prep sheet output
% ********************************************

row1 = {...
    '','','','','','','','',...
    'Value Mean','','',...
    'Value Stdev','','',...    
    'Gradient Mean','','',...
    'Gradient Stdev','','',...
    'Control Delta Mean','','',...
    'Control Delta Stdev','','',...
    'Value Mean (No Cath Voxels)','','',...
    'Value Stdev (No Cath Voxels)','','',...    
    'Gradient Mean (No Cath Voxels)','','',...
    'Gradient Stdev (No Cath Voxels)','','',...
    'Control Delta Mean (No Cath Voxels)','','',...
    'Control Delta Stdev (No Cath Voxels)','','',...
    'd1 Mean','','',...
    'd1 Stdev','','',...   
    'd2 Mean','','',...
    'd2 Stdev','',''};

row2 = {...
    'Gel', 'Recon',	'Flood Field?',	'Cath Reject?',	'Num Iterations', 'Num Subsets', 'c', 'Time',...
    'Bot', 'Mid', 'Top', 'Bot', 'Mid', 'Top', 'Bot', 'Mid', 'Top', 'Bot', 'Mid', 'Top',...    
    'Bot', 'Mid', 'Top', 'Bot', 'Mid', 'Top', 'Bot', 'Mid', 'Top', 'Bot', 'Mid', 'Top',...
    'Bot', 'Mid', 'Top', 'Bot', 'Mid', 'Top', 'Bot', 'Mid', 'Top', 'Bot', 'Mid', 'Top',...
    'Bot', 'Mid', 'Top', 'Bot', 'Mid', 'Top', 'Bot', 'Mid', 'Top', 'Bot', 'Mid', 'Top'};

numColumns = length(row1);

numRuns = length(analysisRuns);

numRows = 2;

for i=1:numRuns
    numRows = numRows + analysisRuns{i}.numRows();
end

output = cell(numRows, numColumns);

output(1,:) = row1;
output(2,:) = row2;

% ********************************************
% Pre-compute masks
% ********************************************

%ROI Masks
[...
    botMask, midMask, topMask,...
    botSlices, midSlices, topSlices,...
    d1ProfileCoords, d2ProfileCoords] = getRoiVolumeMasks();

botMaskVff = false(256, 256, 256);
midMaskVff = false(256, 256, 256);
topMaskVff = false(256, 256, 256);

botSlicesVff = botSlices + 20;
midSlicesVff = midSlices + 20;
topSlicesVff = topSlices + 20;

botMaskVff(:,:,21:21+216-1) = botMask;
midMaskVff(:,:,21:21+216-1) = midMask;
topMaskVff(:,:,21:21+216-1) = topMask;



% ********************************************
% Run analysis on reconstructions
% ********************************************

rowCounter = 3; %start at 3 because of header rows

for i=1:numRuns
    run = analysisRuns{i};
    
    % Catheter Masks
    cathMaskVff = createCatheterMask(...
        run.catheterCoordsFile, [256 256 256], catheterMaskRadius);
        
    run.d1ProfileCoords = d1ProfileCoords;
	run.d2ProfileCoords = d2ProfileCoords;
    
    
	controlVolumeVff = loadOpticalCtVistaRecon(run.controlPath);
    
    switch run.reconAlgorithm
        case 'FDK'
            run.botRoiMask = botMaskVff;
            run.midRoiMask = midMaskVff;
            run.topRoiMask = topMaskVff;
            
            run.botSlices = botSlicesVff;
            run.midSlices = midSlicesVff;
            run.topSlices = topSlicesVff;
            
            run.cathMask = cathMaskVff;
            
            run.controlVolume = controlVolumeVff;
        case 'OSC-TV'
            run.botRoiMask = botMask;
            run.midRoiMask = midMask;
            run.topRoiMask = topMask;
            
            run.botSlices = botSlices;
            run.midSlices = midSlices;
            run.topSlices = topSlices;
            
            run.cathMask = cathMaskVff(:,:,21:21+216-1);
            
            run.controlVolume = controlVolumeVff(:,:,21:21+216-1);
    end
    
    results = getRoiAnalysisResults(run, numColumns);
    
    numRows = run.numRows;
    
    output(rowCounter:rowCounter + numRows - 1, :) = results;
    
    rowCounter = rowCounter + numRows;
end

% ********************************************
% Write Output to an Excel .xls
% ********************************************
xlswrite(writePath, output, sheetName);

end

