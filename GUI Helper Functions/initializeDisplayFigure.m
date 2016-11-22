function handles = initializeDisplayFigure(handles)
% handles = initializeDisplayFigure(handles)
% initialize figure that axes will be displayed on

% set up the axes figure
figureHandle = figure('Color',[0,0,0],'Name','Gyrfalcon - Display');
axesHandle = axes();

handles.displayFigureHandle = figureHandle;
handles.axesHandle = axesHandle;

redrawAxes(axesHandle);

end

