function colour = convertBoolToLampColour(bool)
% colour = convertBoolToLampColour(bool)
% T -> green
% F -> red

if bool
    colour = [0 1 0];
else
    colour = [1 0 0];
end


end

