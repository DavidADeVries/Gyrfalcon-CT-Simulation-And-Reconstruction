function handle = plotCircle(x, y, r, edgeColour, faceColour, lineStyle, lineWidth)
% handle = plotCircle(x, y, r, edgeColour, faceColour, lineStyle, lineWidth)
% plots a circle with centre at x,y,z and radius r

rectX = x - r;
rectY = y - r;

pos = [rectX, rectY, 2*r, 2*r];
cur = [1,1]; % curvature

% graphic defaults:

if isempty(edgeColour)
    edgeColour = [0, 0, 0]; %black
end

if isempty(faceColour)
    faceColour = 'none';
end

if isempty(lineStyle)
    lineStyle = '-';
end

if isempty(lineWidth)
    lineWidth = 0.5;
end

% make it!

handle = rectangle('Position', pos, 'Curvature', cur, 'EdgeColor', edgeColour, 'FaceColor', faceColour, 'LineStyle', lineStyle, 'LineWidth', lineWidth);

