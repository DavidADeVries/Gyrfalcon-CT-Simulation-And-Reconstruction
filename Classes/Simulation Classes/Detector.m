classdef Detector < GyrfalconObject
    % Detector
    % This class contains all the data pertaining to an x-ray detector for the CT
    % simulator.
    %
    % FIELDS:
    % *location:
    % the location where the centre of the detector will begin for a
    % simulated scan. The detector is assumed to be symmetrical around its
    % centre. Only x,y coordinates given, z coordinates given by slice
    % units are in m
    %
    % *wholeDetectorDimensions:
    % the number of detectors that make up the whole detector, and in each
    % direction
    % [# in width, # in depth]
    %
    % *singleDetectorDimensions:
    % the dimensions of a single detector that will make up the whole
    % detector
    % units are in mm or degrees
    %
    % *detectorMovesWithSource:
    % boolean field that determines whether the detector moves with the
    % radiation source or not
    
    
    
    properties
        location
        locationUnits = Units.m
        
        wholeDetectorDimensions
        singleDetectorDimensions
        
        movesWithScanAngle
        movesWithPerAngleTranslation
    end
    
    methods
        function detector = Detector(location, wholeDetectorDimensions, singleDetectorDimensions, detectorMovesWithScanAngle, detectorMovesWithPerAngleTranslation)
            if nargin > 0
                % validate detector parameters and fill in blanks if needed
                
                % validate location
                locationNumDims = length(location);
                
                if locationNumDims ~= 2
                    error('Location of detector not given in 2 space');
                end
                
                % validate wholeDetectorDimensions
                wholeDetectorNumDims = length(wholeDetectorDimensions);
                
                if wholeDetectorNumDims < 1 || wholeDetectorNumDims > 2
                    error('Whole detector dimensions not given in 1 or 2 space');
                elseif wholeDetectorNumDims == 1
                    % take on depth = 1 for completeness
                    
                    wholeDetectorDimensions = [wholeDetectorDimensions, 1];
                end
                
                % singleDetectorDimensions
                singleDetectorNumDims = length(singleDetectorDimensions);
                
                if singleDetectorNumDims < 1 || singleDetectorNumDims > 2
                    error('Single dectector dimensions not given in 1 or 2 space');
                elseif singleDetectorNumDims == 1
                    % make depth measurement as 0, planar
                    
                    value = 0;
                    isPlanar = true;
                    
                    singleDetectorDimensions = [singleDetectorDimensions, Dimension(value, isPlanar)];
                end
                
                % if we get here, we're good to go, so lets assign the fields
                detector.location = location;
                detector.wholeDetectorDimensions = wholeDetectorDimensions;
                detector.singleDetectorDimensions = singleDetectorDimensions;
                detector.movesWithScanAngle = detectorMovesWithScanAngle;
                detector.movesWithPerAngleTranslation = detectorMovesWithPerAngleTranslation;
            end
        end
                
        function object = createBlankObject(object)
            object = Detector;
        end
        
        function name = displayName(detector)
            name = 'Detector';
        end
        
        function [saved, detectorForGUI, detectorForParent, detectorForSaving] = saveChildrenObjects(detector, defaultSavePath)
            detectorForGUI = detector;
            detectorForParent = detector;
            detectorForSaving = detector;
            
            saved = true;
        end
        
        function detector = loadFields(detector, defaultLoadPath)
        end
        
        function bool = isDetectorPlanarAnd2D(detector)
            is2D1 = detector.singleDetectorDimensions(1).value > 0;
            is2D2 = detector.singleDetectorDimensions(2).value > 0;
            isPlanar1 = detector.singleDetectorDimensions(1).isPlanar();
            isPlanar2 = detector.singleDetectorDimensions(2).isPlanar();
            
            bool = is2D1 & is2D2 * isPlanar1 & isPlanar2;
        end

        function dimensions = getSingleDetectorDimensionsInM(detector)
            radiusInM = detector.getDistanceBetweenOriginAndDetectorCentrePointInM();
            
            xy = detector.singleDetectorDimensions(1).getLengthInM(radiusInM);
            z = detector.singleDetectorDimensions(1).getLengthInM(radiusInM);

            dimensions = [xy,z];
        end
                
        function detector = setDefaultValues(detector)
            detector.location = [0,-1];
            
            detector.wholeDetectorDimensions = [10,10];
            
            dim = Dimension(50, Units.mm);
            
            detector.singleDetectorDimensions = [dim,dim];
            
            detector.movesWithScanAngle = true;
            detector.movesWithPerAngleTranslation = false;
        end  
        
        function name = defaultName(detector)
            name = [Constants.Default_Detector_Name, Constants.Matlab_File_Extension]; 
        end
              
        function bool = equal(detector1, detector2)
            b1 = matricesEqual(detector1.location, detector2.location);
            b2 = detector1.locationUnits == detector2.locationUnits;
            b3 = matricesEqual(detector1.wholeDetectorDimensions, detector2.wholeDetectorDimensions);
            b4 = dimensionMatricesEqual(detector1.singleDetectorDimensions, detector2.singleDetectorDimensions);
            
            b5 = matricesEqual(detector1.movesWithScanAngle, detector2.movesWithScanAngle);
            b6 = matricesEqual(detector1.movesWithPerAngleTranslation, detector2.movesWithPerAngleTranslation);
            b7 = strcmp(detector1.savePath, detector2.savePath);
            b8 = strcmp(detector1.saveFileName, detector2.saveFileName);
            
            bool = b1 && b2 && b3 && b4 && b5 && b6 && b7 && b8;
        end
        
        function locationInM = getLocationInM(detector)
            units = detector.locationUnits;
            location = detector.location;
            
            locationInM = units.convertToM(location);            
        end
        
        function detector = setLocationInM(detector, newLocationInM)
            toUnits = detector.locationUnits;
            
            newLocationInToUnits = toUnits.convertFromM(newLocationInM);
            
            detector.location = newLocationInToUnits;
        end
        
        function dist = getDistanceBetweenOriginAndDetectorCentrePointInM(detector)
            locationInM = detector.getLocationInM();
            
            dist = norm(locationInM);
        end
        
        function position = getDetectorPosition(detector, slicePosition, scanAngle)
            location = detector.getLocationInM();
            
            z = slicePosition;
            
            if detector.movesWithScanAngle
                [theta, radius] = cart2pol(location(1), location(2));
                theta = theta * Constants.rad_to_deg;
                
                detectorAngle = theta - scanAngle; %minus because we define scanAngle to be clockwise, but Matlab is counter-clockwise
                
                [x,y] = pol2cart(detectorAngle * Constants.deg_to_rad, radius);
            else
                x = location(1);
                y = location(2);
            end
            
            position = [x,y,z];
        end
        
        function plotHandles = plot(detector, axesHandle, slicePosition, angle, perAngleXY, perAngleZ)
            hold(axesHandle,'on');
            
            [xPlotVals, yPlotVals, zPlotVals] = getAllDetectorCoords(detector, slicePosition, angle, perAngleXY, perAngleZ);
            
            edgeColour = Constants.Detector_Colour;
            
            handle = mesh(xPlotVals,yPlotVals,zPlotVals,...
                'EdgeColor', edgeColour,...
                'FaceColor', 'none',...
                'Parent', axesHandle);
            
            plotHandles = {handle};                
                
            if detector.movesWithScanAngle
                % draw circle outlining the movement of the
                % detector
                dims = size(zPlotVals);
                
                numZ = dims(1);
                numXY = dims(2);
                
                halfXY = round(numXY/2);
                
                x = xPlotVals(1,halfXY);
                y = yPlotVals(1,halfXY);
                
                highZ = zPlotVals(numZ,halfXY);
                lowZ = zPlotVals(1,halfXY);
                
                circRadius = norm([x y]);
                                
                edgeColour = Constants.Detector_Colour;
                lineStyle = '--';
                lineWidth = [];
                faceColour = [];                
                
                if highZ == lowZ
                    handle = circleOrArcPatch(0, 0, highZ,...
                        circRadius, 0, 360,...
                        edgeColour, faceColour, lineStyle, lineWidth, axesHandle);
                    
                    handles = {handle};
                else
                    handle1 = circleOrArcPatch(...
                        0, 0, lowZ,...
                        circRadius, 0, 360,...
                        edgeColour, faceColour, lineStyle, lineWidth, axesHandle);
                    handle2 = circleOrArcPatch(...
                        0, 0, highZ,...
                        circRadius, 0, 360,...
                        edgeColour, faceColour, lineStyle, lineWidth, axesHandle);
                    
                    handles = {handle1, handle2};
                end
                
                % add to plot handles
                plotHandles = [plotHandles, handles];
            end
        end
        
        function app = setGUI(detector, app)
            x = detector.location(1);
            y = detector.location(2);
            
            app.DetectorLocationXEditField.Value = x;
            app.DetectorLocationYEditField.Value = y;
            
            xy = detector.wholeDetectorDimensions(1);
            z = detector.wholeDetectorDimensions(2);
            
            app.DetectorWholeDetectorDimsXYEditField.Value = xy;
            app.DetectorWholeDetectorDimsZEditField.Value = z;
            
            xy = detector.singleDetectorDimensions(1).value;
            z = detector.singleDetectorDimensions(2).value;
            
            xyUnits = detector.singleDetectorDimensions(1).units;
            zUnits = detector.singleDetectorDimensions(2).units;
            
            app.DetectorPixelDimsXYEditField.Value = xy;
            app.DetectorPixelDimsZEditField.Value = z;
            
            app.DetectorPixelDimsXYUnitsDropDown.Value = xyUnits;
            app.DetectorPixelDimsZUnitsDropDown.Value = zUnits;
            
            app.DetectorMovesWithScanAngleCheckBox.Value = detector.movesWithScanAngle;
            app.DetectorMovesWithPerAngleStepsCheckBox.Value = detector.movesWithPerAngleTranslation;
            
            app.DetectorSaveInSeparateFileCheckBox.Value = detector.saveInSeparateFile;
            
            if ~detector.saveInSeparateFile
                app.DetectorFilePathLabel.Text = 'Tied to Simulation';
            elseif isempty(detector.saveFileName)
                app.DetectorFilePathLabel.Text = 'Not Saved';
            else
                app.DetectorFilePathLabel.Text = detector.saveFileName;
            end
        end
        
        function detector = createFromGUI(detector, app)
            x = app.DetectorLocationXEditField.Value;
            y = app.DetectorLocationYEditField.Value;
            
            detector.location = [x,y];
            
            xy = app.DetectorWholeDetectorDimsXYEditField.Value;
            z = app.DetectorWholeDetectorDimsZEditField.Value;
            
            detector.wholeDetectorDimensions = [xy, z];
            
            xy = app.DetectorPixelDimsXYEditField.Value;
            z = app.DetectorPixelDimsZEditField.Value;
            
            xyUnits = app.DetectorPixelDimsXYUnitsDropDown.Value;
            zUnits = app.DetectorPixelDimsZUnitsDropDown.Value;
            
            xyDimension = Dimension(xy, xyUnits);
            zDimension = Dimension(z, zUnits);
            
            detector.singleDetectorDimensions = [xyDimension, zDimension];
            
            detector.movesWithScanAngle = app.DetectorMovesWithScanAngleCheckBox.Value;
            detector.movesWithPerAngleTranslation = app.DetectorMovesWithPerAngleStepsCheckBox.Value;
            
            detector.saveInSeparateFile = app.DetectorSaveInSeparateFileCheckBox.Value;
        end
        
    end
    
end

