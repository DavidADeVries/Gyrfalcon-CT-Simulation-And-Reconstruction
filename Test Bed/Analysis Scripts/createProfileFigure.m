function [] = createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, sampleX, sampleY, numPoints, xLabel, yLabel, yLimits)
%function [] = createProfileFigure(savePath, profileData, profileLabels, lineColours, lineWidths, sampleX, sampleY, numPoints, xLabel, yLabel, yLimits)

numProfiles = length(profileData);

fig = figure('units', 'normalized', 'outerposition', [0 0 1 1]);
hold on;

for i=1:numProfiles
    lineData = improfile(profileData{i}, sampleX, sampleY, numPoints);
    
    plot(lineData, lineColours{i}, 'LineWidth', lineWidths{i});
%     if i==1
%     plot(lineData(3:256), lineColours{i}, 'LineWidth', lineWidths{i});
%     else
%     plot(lineData(1:256-2), lineColours{i}, 'LineWidth', lineWidths{i});
%     end
        
        
end

axes = gca;
xlim(axes, [0 numPoints]);
ylim(axes, yLimits);

legend(profileLabels);

xlabel(xLabel, 'Interpreter', 'latex');
ylabel(yLabel, 'Interpreter', 'latex');

drawnow;

saveas(fig, savePath, 'png');
close(fig);

end

