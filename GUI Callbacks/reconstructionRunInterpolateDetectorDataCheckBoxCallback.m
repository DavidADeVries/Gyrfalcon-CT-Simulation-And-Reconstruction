function [] = reconstructionRunInterpolateDetectorDataCheckBoxCallback(app)
%[] = reconstructionRunInterpolateDetectorDataCheckBoxCallback(app)

interpolate = app.ReconstructionRunInterpolateDetectorDataCheckBox.Value;

reconRun = app.workspace.reconstructionRun;

imagingSetup = reconRun.simulationOrImagingScanRun.getImagingSetup();

if interpolate
    reconRun.reconstruction.interpolateDetectorData = true;
else
    reconRun.reconstruction.interpolateDetectorData = false;
    
    reconRun.reconstruction.processingWholeDetectorDimensions = imagingSetup.detector.wholeDetectorDimensions;
    reconRun.reconstruction.processingSingleDetectorDimensions = reconRun.reconstruction.processingSingleDetectorUnits.convertFromM(imagingSetup.detector.getSingleDetectorDimensionsInM());        
end

setDetectorInterpolationGUI(app, reconRun.reconstruction);

app.workspace.reconstructionRun = reconRun;

end

