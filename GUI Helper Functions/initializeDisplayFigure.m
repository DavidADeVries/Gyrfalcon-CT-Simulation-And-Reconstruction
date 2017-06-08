function app = initializeDisplayFigure(app)
% handles = initializeDisplayFigure(appd)
% initialize figure that axes will be displayed on

% set up the axes figure
figureHandle = figure('Color',[0,0,0],'Name','Gyrfalcon - Display');
axesHandle = axes();

app.displayFigureHandle = figureHandle;
app.axesHandle = axesHandle;

redrawAxes(axesHandle);

hold(axesHandle, 'on');

end

