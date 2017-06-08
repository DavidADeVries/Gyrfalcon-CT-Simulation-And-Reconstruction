function [] = setAngularDetectorRadiusButtonCallback(app, type)
%[] = setAngularDetectorRadiusButtonCallback(app, type)

simulation = app.workspace.simulation.createFromGUI(app);

radius = 0;

switch type
    case 'Isocentre'
        detectorLocation = simulation.detector.getLocationInM();
        
        radius = norm(detectorLocation);
    case 'Source'
        detectorLocation = simulation.detector.getLocationInM();
        sourceLocation = simulation.source.getLocationInM();
        
        radius = norm(detectorLocation - sourceLocation);
    otherwise
        error('Invalid angular detector radius set type');
end

simulation.detector.angularDetectorRadius = radius;

simulation.setGUI(app);

app.workspace.simulation = simulation;


end