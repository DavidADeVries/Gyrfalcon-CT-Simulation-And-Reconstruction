function [] = createAndWriteBarGraph(writePath, figureDimsInCm, barData, groupNames, subgroupNames, subgroupLabelWriteIndex, subgroupLabelOrientation, subgroupColours, customColours, yLabel, axesTitle)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

fig = figure();
axis = axes('parent', fig);
hold(axis, 'on');

fig.Units = 'centimeters';
fig.Position = [1 1 figureDimsInCm(2) figureDimsInCm(1)];

x = 1;

xTicks = zeros(length(barData),1);

subgroupLabelX = 0;
subgroupLabelData = [];

for i=1:length(barData)
    labelData = barData{i};
    customColour = customColours{i};
    
    if isempty(customColour)
        colours = subgroupColours;
    else
        colours = customColour;
    end
    
    len = length(labelData);
    
    startX = x;
        
    if subgroupLabelWriteIndex == i
        subgroupLabelX = x;
        subgroupLabelData = labelData;
    end
    
    for j=1:len
        bar(x, labelData(j), 'Parent', axis, 'FaceColor', colours(j,:));
                
        x = x + 1;
    end
    
    endX = x - 1;
    
    xTicks(i) = startX + ((endX - startX) / 2);
    
    if i ~= length(barData) % space out subgroups
        x = x + 1;
    end
end

xlim(axis, [0, x]);

axis.XTick = xTicks;
axis.XTickLabel = groupNames;
axis.TickLabelInterpreter = 'latex';

ylabel(axis, yLabel, 'Interpreter', 'latex');

box(axis, 'on');
axis.YGrid = 'on';

axis.Units = 'centimeters';

pos = axis.Position;
pos(1) = 1.5;
pos(3) = figureDimsInCm(2)-1.6;

axis.Position = pos;

title(axis, axesTitle, 'Interpreter', 'latex', 'FontWeight', 'normal');

% set subgroup labels

x = subgroupLabelX;

y = ylim(axis);

bump = abs(y(2) - y(1)) ./ 50;

for j=1:len
    
    switch subgroupLabelOrientation
        case 'above'
            text(...
                x, bump, subgroupNames{j},...
                'Rotation', 45);
        case 'below'
            text(...
                x, -bump, subgroupNames{j},...
                'Rotation', -45);
        case 'above-stepped'
            text(...
                x, max(subgroupLabelData(j),0)+bump, subgroupNames{j},...
                'Rotation', 45);
            
    end
    
    x = x+1;
end

drawnow;

% save to .png

saveas(fig, writePath);

savefig(fig, strrep(writePath, '.png', '.fig'), 'compact');

delete(fig);

end

