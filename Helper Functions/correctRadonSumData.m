function radonSumData = correctRadonSumData(radonSumData)
%function radonSumData = correctRadonSumData(radonSumData)

% eliminate negative Radon Sums (can't have negative attenuation)
radonSumData(radonSumData < 0) = 0;

% eliminate infitnite Radon Sums (do make sense, but can throw calculations
% off)
radonSumData(abs(radonSumData) == Inf) = Constants.Infinite_Radon_Sum_Approximation;

end

