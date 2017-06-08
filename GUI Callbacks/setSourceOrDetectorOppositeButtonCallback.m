function [] = setSourceOrDetectorOppositeButtonCallback(app, setSource)
% ] = setSourceOrDetectorOppositeButtonCallback(app, setSource)



if setSource
    giveX = app.DetectorLocationXEditField;
    giveY = app.DetectorLocationYEditField;
    
    setX = app.SourceLocationXEditField;
    setY = app.SourceLocationYEditField;
else    
    setX = app.DetectorLocationXEditField;
    setY = app.DetectorLocationYEditField;
    
    giveX = app.SourceLocationXEditField;
    giveY = app.SourceLocationYEditField;
end

x = giveX.Value;
y = giveY.Value;

if x ~= 0
    x = -x;
end

if y ~= 0
    y = -y;
end

setX.Value = x;
setY.Value = y;

end

