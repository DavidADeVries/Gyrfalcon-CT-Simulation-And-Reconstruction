function [] = setDetectorInterpolationGUI(app, reconstruction)
%[] = setDetectorInterpolationGUI(app, reconstruction)

if reconstruction.interpolateDetectorData    
    app.ReconstructionRunPixelDimsXYEditField.Editable = 'on';
    app.ReconstructionRunPixelDimsZEditField.Editable = 'on';

    app.ReconstructionRunWholeDetectorDimsXYEditField.Value = reconstruction.processingWholeDetectorDimensions(1);
    app.ReconstructionRunWholeDetectorDimsZEditField.Value = reconstruction.processingWholeDetectorDimensions(2);
    
    app.ReconstructionRunPixelDimsXYEditField.Value = reconstruction.processingSingleDetectorDimensions(1);
    app.ReconstructionRunPixelDimsZEditField.Value = reconstruction.processingSingleDetectorDimensions(2);
    
    app.ReconstructionRunInterpolateDetectorDataCheckBox.Value = true;
else    
    app.ReconstructionRunPixelDimsXYEditField.Editable = 'off';
    app.ReconstructionRunPixelDimsZEditField.Editable = 'off';

    app.ReconstructionRunWholeDetectorDimsXYEditField.Value = reconstruction.processingWholeDetectorDimensions(1);
    app.ReconstructionRunWholeDetectorDimsZEditField.Value = reconstruction.processingWholeDetectorDimensions(2);
    
    app.ReconstructionRunPixelDimsXYEditField.Value = reconstruction.processingSingleDetectorDimensions(1);
    app.ReconstructionRunPixelDimsZEditField.Value = reconstruction.processingSingleDetectorDimensions(2);
    
    app.ReconstructionRunInterpolateDetectorDataCheckBox.Value = false;
end
            

end

