function [invert, contrastBounds] = getSimulationViewerImageDisplaySettings(app)
% [invert, contrastBounds] = getSimulationViewerImageDisplaySettings(app)

invert = app.InvertImageDisplayCheckBox.Value;

contrastBounds = [app.ImageContrastLowEditField.Value, app.ImageContrastHighEditField.Value];

end

