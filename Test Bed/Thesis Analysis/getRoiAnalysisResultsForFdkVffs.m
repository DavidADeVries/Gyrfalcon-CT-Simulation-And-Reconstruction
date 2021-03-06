function [results, resultsSub] = getRoiAnalysisResultsForFdkVffs(controlPath, fdkReconPath, botMask, midMask, topMask, cathMask, botSlices, midSlices, topSlices, d1ProfileCoords, d2ProfileCoords)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

numColumns = 1 + (3 * 8);

results = cell(1+2, numColumns);
resultsSub = cell(1+2, numColumns);

results(1,:) = {...
    'Recon/Gel',...
    'Mean (Bot)', 'Mean (Mid)', 'Mean (Top)',...
    'Var (Bot)', 'Var (Mid)', 'Var (Top)',...
    'Grad Mean (Bot)', 'Grad Mean (Mid)', 'Grad Mean (Top)',...
    'Grad Var (Bot)', 'Grad Var (Mid)', 'Grad Var (Top)',...
    'd1 Mean (Bot)', 'd1 Mean (Mid)', 'd1 Mean (Top)',...
    'd1 Var (Bot)', 'd1 Var (Mid)', 'd1 Var (Top)',...
    'd2 Mean (Bot)', 'd2 Mean (Mid)', 'd2 Mean (Top)',...
    'd2 Var (Bot)', 'd2 Var (Mid)', 'd2 Var (Top)'};

resultsSub(1,:) = results(1,:);

botMask2 = false(256, 256, 256);
midMask2 = false(256, 256, 256);
topMask2 = false(256, 256, 256);

botSlices = botSlices + 20;
midSlices = midSlices + 20;
topSlices = topSlices + 20;

botMask2(:,:,21:21+216-1) = botMask;
midMask2(:,:,21:21+216-1) = midMask;
topMask2(:,:,21:21+216-1) = topMask;
      
% load volumes
controlVolume = loadOpticalCtVistaRecon(controlPath);
fdkVolume = loadOpticalCtVistaRecon(fdkReconPath);

% Control Gel w/ FDK
[...
    meanValBot, meanValMid, meanValTop,...
    varValBot, varValMid, varValTop,...
    gradMeanBot, gradMeanMid, gradMeanTop,...
    gradVarBot, gradVarMid, gradVarTop,...
    meanValBotSub, meanValMidSub, meanValTopSub,...
    varValBotSub, varValMidSub, varValTopSub,...
    gradMeanBotSub, gradMeanMidSub, gradMeanTopSub,...
    gradVarBotSub, gradVarMidSub, gradVarTopSub,...
    d1MeanBot, d1MeanMid, d1MeanTop,...
    d1VarBot, d1VarMid, d1VarTop,...
    d2MeanBot, d2MeanMid, d2MeanTop,...
    d2VarBot, d2VarMid, d2VarTop] = ...
    getMetricsForRoi(controlVolume,...
    botMask2, midMask2, topMask2, cathMask,...
    botSlices, midSlices, topSlices,...
    d1ProfileCoords, d2ProfileCoords);

results(2,1:end) = {...
    'Control Gel w/ FDK',...
    meanValBot, meanValMid, meanValTop,...
    varValBot, varValMid, varValTop,...
    gradMeanBot, gradMeanMid, gradMeanTop,...
    gradVarBot, gradVarMid, gradVarTop,...
    d1MeanBot, d1MeanMid, d1MeanTop,...
    d1VarBot, d1VarMid, d1VarTop,...
    d2MeanBot, d2MeanMid, d2MeanTop,...
    d2VarBot, d2VarMid, d2VarTop};

resultsSub(2,1:end) = {...
    'Control Gel w/ FDK',...
    meanValBotSub, meanValMidSub, meanValTopSub,...
    varValBotSub, varValMidSub, varValTopSub,...
    gradMeanBotSub, gradMeanMidSub, gradMeanTopSub,...
    gradVarBotSub, gradVarMidSub, gradVarTopSub,...
    d1MeanBot, d1MeanMid, d1MeanTop,...
    d1VarBot, d1VarMid, d1VarTop,...
    d2MeanBot, d2MeanMid, d2MeanTop,...
    d2VarBot, d2VarMid, d2VarTop};

% Catheter Gel w/ FDK
[...
    meanValBot, meanValMid, meanValTop,...
    varValBot, varValMid, varValTop,...
    gradMeanBot, gradMeanMid, gradMeanTop,...
    gradVarBot, gradVarMid, gradVarTop,...
    meanValBotSub, meanValMidSub, meanValTopSub,...
    varValBotSub, varValMidSub, varValTopSub,...
    gradMeanBotSub, gradMeanMidSub, gradMeanTopSub,...
    gradVarBotSub, gradVarMidSub, gradVarTopSub,...
    d1MeanBot, d1MeanMid, d1MeanTop,...
    d1VarBot, d1VarMid, d1VarTop,...
    d2MeanBot, d2MeanMid, d2MeanTop,...
    d2VarBot, d2VarMid, d2VarTop] = ...
    getMetricsForRoi(fdkVolume,...
    botMask2, midMask2, topMask2, cathMask,...
    botSlices, midSlices, topSlices,...
    d1ProfileCoords, d2ProfileCoords);

results(3,1:end) = {...
    'Catheter Gel w/ FDK',...
    meanValBot, meanValMid, meanValTop,...
    varValBot, varValMid, varValTop,...
    gradMeanBot, gradMeanMid, gradMeanTop,...
    gradVarBot, gradVarMid, gradVarTop,...
    d1MeanBot, d1MeanMid, d1MeanTop,...
    d1VarBot, d1VarMid, d1VarTop,...
    d2MeanBot, d2MeanMid, d2MeanTop,...
    d2VarBot, d2VarMid, d2VarTop};

resultsSub(3,1:end) = {...
    'Catheter Gel w/ FDK',...
    meanValBotSub, meanValMidSub, meanValTopSub,...
    varValBotSub, varValMidSub, varValTopSub,...
    gradMeanBotSub, gradMeanMidSub, gradMeanTopSub,...
    gradVarBotSub, gradVarMidSub, gradVarTopSub,...
    d1MeanBot, d1MeanMid, d1MeanTop,...
    d1VarBot, d1VarMid, d1VarTop,...
    d2MeanBot, d2MeanMid, d2MeanTop,...
    d2VarBot, d2VarMid, d2VarTop};
  


end
