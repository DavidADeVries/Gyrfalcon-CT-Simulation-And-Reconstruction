function  results = getMetricsForRoi(volume, botMask, midMask, topMask, cathMask, botSlices, midSlices, topSlices, d1ProfileCoords, d2ProfileCoords)
%[mean, variance] = getMetricsForRoi(volume, roiMask)

grad = imgradient3(volume);

[meanValBot, varValBot] = getRoiMetrics(volume, botMask);
[gradMeanBot, gradVarBot] = getRoiMetrics(grad, botMask);

[meanValMid, varValMid] = getRoiMetrics(volume, midMask);
[gradMeanMid, gradVarMid] = getRoiMetrics(grad, midMask);

[meanValTop, varValTop] = getRoiMetrics(volume, topMask);
[gradMeanTop, gradVarTop] = getRoiMetrics(grad, topMask);

[meanValBotSub, varValBotSub] = getRoiMetrics(volume, botMask & ~cathMask);
[gradMeanBotSub, gradVarBotSub] = getRoiMetrics(grad, botMask & ~cathMask);

[meanValMidSub, varValMidSub] = getRoiMetrics(volume, midMask & ~cathMask);
[gradMeanMidSub, gradVarMidSub] = getRoiMetrics(grad, midMask & ~cathMask);

[meanValTopSub, varValTopSub] = getRoiMetrics(volume, topMask & ~cathMask);
[gradMeanTopSub, gradVarTopSub] = getRoiMetrics(grad, topMask & ~cathMask);

[d1MeanBot, d1VarBot] = getProfileMetrics(volume, botSlices, d1ProfileCoords);
[d2MeanBot, d2VarBot] = getProfileMetrics(volume, botSlices, d2ProfileCoords);

[d1MeanMid, d1VarMid] = getProfileMetrics(volume, midSlices, d1ProfileCoords);
[d2MeanMid, d2VarMid] = getProfileMetrics(volume, midSlices, d2ProfileCoords);

[d1MeanTop, d1VarTop] = getProfileMetrics(volume, topSlices, d1ProfileCoords);
[d2MeanTop, d2VarTop] = getProfileMetrics(volume, topSlices, d2ProfileCoords);

results = {...
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
    d2VarBot, d2VarMid, d2VarTop};

end

function [meanVal, varVal] = getProfileMetrics(volume, slices, profileCoords)

vals = zeros(length(slices),1);

for i=1:length(slices)
    slice = volume(:,:,slices(i));
    
    d = getDValue(slice, profileCoords);
    
    if isempty(d)
        vals = zeros(length(slices),1);
        break;
    else
        vals(i) = d;
    end
end

meanVal = mean(vals);
varVal = var(vals);

end

function [meanVal, varVal] = getRoiMetrics(volume, mask)

vals = volume(mask);

meanVal = mean(vals);
varVal = var(vals);

end

function d = getDValue(slice, dProfileCoords)

points = improfile(slice, dProfileCoords(:,1), dProfileCoords(:,2), 50);
numPoints = length(points);

high = mean(points(1:5));
low = mean(points(end-4:end));

points = points(6:end-5);

indices = 1:length(points);

dHigh = min(indices(points < 0.95 * high));
dLow = max(indices(points > 0.05 * low));

distRatio = (dLow - dHigh) ./ numPoints;

d = distRatio .* norm(dProfileCoords(1,:) - dProfileCoords(2,:));

end