function handle = circleOrArcPatch(x, y, z, r, ang1, ang2, edgeColour, faceColour, lineStyle, lineWidth)
% handle = circleOrArcPatch(x,y,z,r,ang1,ang2,edgeColour, faceColour, lineStyle, lineWidth)
% creates a circle or arc at the given point in 3 space
% use ang1 = 0 and ang2 = 360 for a circle


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


%(1) Define angles at which patch vertices will appear:
step = 1;               %one vertex for every 2 degrees; adjust this parameter for smoother/coarser edges
phi = ang1:step:ang2;   %angles (degrees) at which patch vertices will appear
if phi(end)~=ang2
    phi = [phi  ang2];  %append phi1 if 'step' is not a factor of (phi1-phi0) 
end
phi = pi/180*phi';      %angles (radians)


%(2) Define patch vertices and faces
vert = zeros(length(phi), 3);     
vert(1:end,1:2) = [x+r*cos(phi), y+r*sin(phi)];
vert(1:end,3) = z;

if strcmp(faceColour, 'none')
    handle = line(vert(:,1),vert(:,2),vert(:,3),...
    'Color', edgeColour,...
    'LineStyle', lineStyle,...
    'LineWidth', lineWidth);
else
    faces = [1:size(vert,1) 1]; 
    handle = patch('vertices',vert, 'faces',faces,...
    'EdgeColor', edgeColour,...
    'FaceColor', faceColour,...
    'LineStyle', lineStyle,...
    'LineWidth', lineWidth);
end



    

