function [scanGeometry, errorMsg] = boolLogicForFindScanGeometry(simulationOrImagingScan)
% scanGeometry = boolLogicForFindScanGeometry(simulationOrImagingScan)

if isempty(simulationOrImagingScan)
    scanGeometry = [];
    errorMsg = 'No Simulation/Imaging Scan Selected';
else
    
    scanGeometry = [];
    errorMsg = '';
    
    detector = simulationOrImagingScan.detector;
    scan = simulationOrImagingScan.scan;
    source = simulationOrImagingScan.source;
    
    isPencilBeam = false;
    isFanBeam = false;
    isConeBeam = false;
    
    beamAngle = source.beamAngle;
    
    xyAngle = beamAngle(1);
    zAngle = beamAngle(2);
    
    if xyAngle == 0
        if zAngle == 0
            isPencilBeam = true;
        else
            % fan beam, but in the z-direction
            errorMsg = 'Scan has a configuration with a fan-beam in the z-direction. This scan configuration cannot be reconstructed.';
        end
    else
        if zAngle == 0
            isFanBeam = true;
        else
            isConeBeam = true;
        end
    end
    
    if source.isPointSource()
        detectorPlanar = detector.singleDetectorDimensions(1).isPlanar() && detector.singleDetectorDimensions(2).isPlanar();
        
        if isConeBeam
            detectorValid = detectorPlanar && detector.movesWithScanAngle && ~detector.movesWithPerAngleTranslation;
            
            scanValid = scan.perAngleTranslationDimensions(1) == 1 && scan.perAngleTranslationDimensions(2) == 1;
            
            if detectorValid && scanValid
                scanGeometry = ScanGeometries.coneBeamCT;
            else
                errorMsg = {};
                
                if ~detectorValid
                    errorMsg = [errorMsg, {'For a cone-beam reconstruction to be done, the detector used must be planar, move with the scan angle, and not move with per angle translations'}];
                end
                
                if ~scanValid
                    errorMsg = [errorMsg, {'For a cone-beam reconstruction to be done, the scan used must not have any per angle translations for the source.'}];
                end
            end
        elseif isFanBeam
            detectorValid = detector.wholeDetectorDimensions(2) == 1;
            scanValid = scan.perAngleTranslationDimensions(2) == 1;
            
            if detectorValid && scanValid
                hasPerAngleTranslation = scan.perAngleTranslationDimensions(1) > 1;
                movesWithScanAngle = detector.movesWithScanAngle;
                movesWithPerAngle = detector.movesWithPerAngleTranslation;
                
                if hasPerAngleTranslation
                    if movesWithScanAngle && movesWithPerAngle
                        scanGeometry = ScanGeometries.secondGenCT;
                    else
                        errorMsg = 'For a 2nd Generation CT scan, the detector must move with the scan angle and per angle translations.';
                    end
                else
                    if ~movesWithPerAngle
                        if movesWithScanAngle
                            scanGeometry = ScanGeometries.thirdGenCT;
                        elseif ~detectorPlanar
                            scanGeometry = ScanGeometries.fourthGenCT;
                        else
                            errorMsg = 'Detector must be curved for 4th Generation CT scans.';
                        end
                    else
                        errorMsg = 'For a 3rd or 4th Generation CT scan, the detector must not move with per angle translations.';
                    end
                end
            else
                errorMsg = {};
                
                if ~detectorValid
                    errorMsg = [errorMsg, {'For a fan-beam CT scan, the detector must be 1D (no detectors in z-direction).'}];
                end
                
                if ~scanValid
                    errorMsg = [errorMsg, {'For a fan-beam CT scan, the source must not have an per angle translation in the z-direction.'}];
                end
            end
        elseif isPencilBeam
            detectorValid = detectorPlanar && detector.wholeDetectorDimensions(1) == 1 && detector.wholeDetectorDimensions(2) == 1 && detector.movesWithScanAngle && detector.movesWithPerAngleTranslation;
            scanValid = scan.perAngleTranslationDimensions(2) == 1;
            
            if detectorValid && scanValid
                scanGeometry = ScanGeometries.firstGenCT;
            else
                errorMsg = {};
                
                if ~detectorValid
                    errorMsg = [errorMsg, {'For a pencil-beam CT scan, the detector must be 1D, planar, a single pixel, and move with the scan angle and source.'}];
                end
                
                if ~scanValid
                    errorMsg = [errorMsg, {'For a pencil-beam CT scan, the source must not have an per angle translation in the z-direction.'}];
                end
            end
        end
    else
        errorMsg = 'Scan has a non-point source. This scan configuration cannot be reconstructed.';
    end
end

end

