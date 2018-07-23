function [] = writeSliceImagesFromFigure(writePath, slice, threshold, imageHeightInCm, colourbarTicks, colourbarLabel, lineCoordsX, lineCoordsY, lineColours, lineStyles, lineWidths)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

fig = figure();
fig.Units = 'centimeters';
fig.Position = [1 1 imageHeightInCm imageHeightInCm+0.2*2];

axis = axes('parent', fig);
hold(axis, 'on');
axis.Units = 'centimeters';
axis.Position = [0 0.2 imageHeightInCm imageHeightInCm];
im = imshow(slice,threshold,'Parent',axis);

numLines = length(lineCoordsX);

if numLines ~= 0 %plot these before we start rescaling axes and such
    lineHandles = cell(numLines,1);
    
    for i=1:numLines
        lineHandles{i} = line(...
            lineCoordsX{i}, lineCoordsY{i},...
            'Color', lineColours{i},...
            'LineStyle', lineStyles{i},...
            'LineWidth', lineWidths{i});
        
        lineHandles{i}.Visible = 'off'; % hide them for now
    end
end

im.XData = [1 256];
im.YData = [1 256];
axis.XLim = [1 256];
axis.YLim = [1 256];

% save figure with only slice (no colour bar, no lines)
saveas(fig, strrep(writePath, '.', ' (1).'));

% add in lines (if needed)
if numLines ~= 0 %plot these before we start rescaling axes and such
    for i=1:numLines
        lineHandles{i}.Visible = 'on';
    end
    
    saveas(fig, strrep(writePath, '.', ' (3).'));
    
    for i=1:numLines
        lineHandles{i}.Visible = 'off';
    end
end

% add colour bar (no lines)
fig.Position = [1 1 imageHeightInCm+4 imageHeightInCm+0.2*2];

cBar = colorbar(...
    axis,...
    'Ticks', colourbarTicks,...
    'FontName', 'times',...
    'FontSize', 10);

axis.Position = [0 0.2 imageHeightInCm imageHeightInCm];

cBar.Label.String = colourbarLabel;
cBar.Label.Interpreter = 'latex';

cBar.Units = 'centimeters';

pos = cBar.Position;
pos(1) = imageHeightInCm + 0.1;
cBar.Position = pos;


saveas(fig, strrep(writePath, '.', ' (2).'));

% add in lines (if needed)
if numLines ~= 0 %plot these before we start rescaling axes and such
    for i=1:numLines
        lineHandles{i}.Visible = 'on';
    end
    
    saveas(fig, strrep(writePath, '.', ' (4).'));
    
    for i=1:numLines
        lineHandles{i}.Visible = 'off';
    end
end

delete(fig);

end

