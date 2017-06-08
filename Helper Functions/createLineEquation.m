function [deltas, point] = createLineEquation(point1, point2)
% [deltas, point] = createLineEquation(point1, point2)
% creates a description of a line in 3-space to satisfy the equation:
% newPoint = point + t*deltas

point = point1;

deltas = point2 - point1;


end

