function [] = redrawAxes(axesHandles)
% [] = redrawAxes(axesHandles)
% clears the axes and redraws the axes

axes(axesHandles); % set as current axes

cla reset

axis equal
axis off

% plot axes, MATLABs are dumb
line([1,-1],[0,0],[0,0],'Color','y');
line([0,0],[1,-1],[0,0],'Color','y');
line([0,0],[0,0],[1,-1],'Color','c');

% make labels
text(1.05,0,0,'x','Color','y');
text(0,1.1,0,'y','Color','y');
text(0.03,-0.03,1,'z','Color','c');

end

