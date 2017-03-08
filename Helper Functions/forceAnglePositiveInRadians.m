function posAngle = forceAnglePositiveInRadians(angleInRadians)
% posAngle = forceAnglePositiveInRadians(angleInRadians)

if angleInRadians < 0
    posAngle = 2*pi - angleInRadians;
else
    posAngle = angleInRadians;
end



end

