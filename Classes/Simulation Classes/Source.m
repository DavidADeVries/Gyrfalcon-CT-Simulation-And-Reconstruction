classdef Source < GyrfalconObject
% Source
% This class contains all the data pertaining to an x-ray source for the CT
% simulator. While point sources are oftened used, a source of
% arbitrary size can be specified, where each "sub-source" is modelled
% as a point source
% 
% FIELDS:
% *location:
% the location where the centre of the source will begin for a
% simulated scan. The source is assumed to be symmetrical around its
% centre. Only x,y coordinates set, z set by slice
% units are in m
%
% *dimensions: 
% the dimensions of the source, that can be given in planar (flat)
% or angular (curved) dimensions. Dimensions of [0,0] give a point
% source
% units are in m
%
% *beamAngle:
% the angle of the source beam (fan or cone angle). This is NOT a half
% angle, but rather the full angle from one side to other



properties
    location
    locationUnits = Units.m

    dimensions

    beamAngle
    beamAngleUnits = Units.degree
end

methods
    function source = Source(location, dimensions, beamAngle)
        if nargin > 0
            % validate source parameters and fill in blanks if needed

            % validate location
            locationNumDims = length(location);

            if locationNumDims ~= 2
                error('Location of source not given in 2 space');
            end

            % validate dimensions
            dimensionsNumDims = length(dimensions);

            if dimensionsNumDims < 1 || dimensionsNumDims > 2
                error('Dimensions not given in 1 or 2 space');
            elseif dimensionsNumDims == 1
                % take on depth = 0 for completeness

                value = 0;
                isPlanar = true;

                dimensions = [dimensions, Dimension(value, isPlanar)];
            end

            % beamAngle
            angleNumDims = length(beamAngle);

            if angleNumDims < 1 || angleNumDims > 2
                error('Beam angle not given in 1 or 2 space');
            elseif angleNumDims == 1
                % take on depth beam angle = 0 for completeness

                beamAngle = [beamAngle, 0];
            end

            % if we get here, we're good to go, so lets assign the fields
            source.location = location;
            source.dimensions = dimensions;
            source.beamAngle = beamAngle;
        end
    end
                
    function object = createBlankObject(object)
        object = Source;
    end
        
    function name = displayName(source)
        name = 'Source';
    end
    
    function [saved, sourceForGUI, sourceForParent, sourceForSaving] = saveChildrenObjects(source, defaultSavePath)
        sourceForGUI = source;
        sourceForParent = source;
        sourceForSaving = source;
        
        saved = true;
    end
        
    function source = loadFields(source, defaultLoadPath)
    end
           
    function source = setDefaultValues(source)
        source.location = [0,1];
        
        dim = Dimension(0, Units.mm);
        
        source.dimensions = [dim,dim];
        
        source.beamAngle = [14.25,14.1411];
    end
            
    function name = defaultName(source)
        name = [Constants.Default_Source_Name, Constants.Matlab_File_Extension];
    end
    
    function bool = equal(source1, source2)
        b1 = matricesEqual(source1.location, source2.location);
        b2 = source1.locationUnits == source2.locationUnits;
        b3 = dimensionMatricesEqual(source1.dimensions, source2.dimensions);  
        b4 = matricesEqual(source1.beamAngle, source2.beamAngle);
        b5 = source1.beamAngleUnits == source2.beamAngleUnits;
        b6 = strcmp(source1.savePath, source2.savePath);
        b7 = strcmp(source1.saveFileName, source2.saveFileName);
        
        bool = b1 && b2 && b3 && b4 && b5 && b6 && b7;
    end
    
    function bool = isPointSource(source)
        dimensions = source.dimensions;
        
        bool = dimensions(1).value == 0 && dimensions(2).value == 0;
    end
    
    function locationInM = getLocationInM(source)
        units = source.locationUnits;

        locationInM = units.convertToM(source.location);
    end
    
    function dist = getDistanceBetweenOriginAndSourceCentrePointInM(source)
        locationInM = source.getLocationInM();
        
        dist = norm(locationInM);
    end

    function handles = plot(source, axesHandle, startBoxCoords, endBoxCoords)
        
        if isempty(startBoxCoords) || isempty(endBoxCoords)
            slicePosition = 0; %default
            angle = 0; %default
            perAngleXY = 0; %default
            perAngleZ = 0; %default
            diameter = [];
            
            [startBoxCoords, endBoxCoords, ~, ~] = ...
                getSourcePosition(source, slicePosition, angle, perAngleXY, perAngleZ, diameter);
        end
        
        if isempty(endBoxCoords)
            
        end
        
        edgeColour = Constants.Source_Colour;
        faceColour = Constants.Source_Colour;
        lineStyle = []; % default
        lineWidth = []; % default
                        
        centreOfSourceCoords = centreOfQuadrangle(startBoxCoords);        
        
        startClockwisePosZ = startBoxCoords(1,:);
        startClockwiseNegZ = startBoxCoords(2,:);
        startCounterClockwisePosZ = startBoxCoords(3,:);
        startCounterClockwiseNegZ = startBoxCoords(4,:);
        
        endClockwisePosZ = endBoxCoords(1,:);
        endClockwiseNegZ = endBoxCoords(2,:);
        endCounterClockwisePosZ = endBoxCoords(3,:);
        endCounterClockwiseNegZ = endBoxCoords(4,:);

        if source.isPointSource()
            % plot point source
            handle = circleOrArcPatch(...
                startClockwisePosZ(1), startClockwisePosZ(2), startClockwisePosZ(3),...
                Constants.Point_Source_Radius, 0, 360,...
                edgeColour, faceColour, lineStyle, lineWidth, axesHandle);
            
            handles = {handle};
        else                
            if unitsArePlanar(source.dimensions)
                line1Coords = [startClockwisePosZ', startClockwiseNegZ'];
                line2Coords = [startClockwiseNegZ', startCounterClockwiseNegZ'];
                line3Coords = [startCounterClockwiseNegZ', startCounterClockwisePosZ'];
                line4Coords = [startCounterClockwisePosZ', startClockwisePosZ'];
                
                line1 = line(...
                    line1Coords(1,:), line1Coords(2,:), line1Coords(3,:),...
                    'Parent', axesHandle, 'Color', edgeColour);
                line2 = line(...
                    line2Coords(1,:), line2Coords(2,:), line2Coords(3,:),...
                    'Parent', axesHandle, 'Color', edgeColour);
                line3 = line(...
                    line3Coords(1,:), line3Coords(2,:), line3Coords(3,:),...
                    'Parent', axesHandle, 'Color', edgeColour);
                line4 = line(...
                    line4Coords(1,:), line4Coords(2,:), line4Coords(3,:),...
                    'Parent', axesHandle, 'Color', edgeColour);
                
                handles = {line1, line2, line3, line4};
            else                    
                error('Undefined behaviour');
            end
        end
         
        % draw lines connecting start box to end box
        line1Coords = [startClockwisePosZ', endClockwisePosZ'];
        line2Coords = [startClockwiseNegZ', endClockwiseNegZ'];
        line3Coords = [startCounterClockwisePosZ', endCounterClockwisePosZ'];
        line4Coords = [startCounterClockwiseNegZ', endCounterClockwiseNegZ'];
        
        beamLine1 = line(...
                    line1Coords(1,:), line1Coords(2,:), line1Coords(3,:),...
                    'Parent', axesHandle, 'Color', edgeColour);
        beamLine2 = line(...
                    line2Coords(1,:), line2Coords(2,:), line2Coords(3,:),...
                    'Parent', axesHandle, 'Color', edgeColour);
        beamLine3 = line(...
                    line3Coords(1,:), line3Coords(2,:), line3Coords(3,:),...
                    'Parent', axesHandle, 'Color', edgeColour);
        beamLine4 = line(...
                    line4Coords(1,:), line4Coords(2,:), line4Coords(3,:),...
                    'Parent', axesHandle, 'Color', edgeColour);
        
        %plot midline coords
        endBoxCentreCoords = centreOfQuadrangle(endBoxCoords);        
        midlineCoords = [centreOfSourceCoords', endBoxCentreCoords']; 
        
        beamLine5 = line(...
                    midlineCoords(1,:), midlineCoords(2,:), midlineCoords(3,:),...
                    'Parent', axesHandle, 'Color', edgeColour, 'LineStyle', '--');
        
        % draw end box
        line1Coords = [endClockwisePosZ', endCounterClockwisePosZ'];
        line2Coords = [endCounterClockwisePosZ', endCounterClockwiseNegZ'];
        line3Coords = [endCounterClockwiseNegZ', endClockwiseNegZ'];
        line4Coords = [endClockwiseNegZ', endClockwisePosZ'];
        
        crossLine1Coords = [endClockwisePosZ', endCounterClockwiseNegZ'];
        crossLine2Coords = [endCounterClockwisePosZ', endClockwiseNegZ'];
                
        % plot the lines
        endBoxLine1 = line(...
                    line1Coords(1,:), line1Coords(2,:), line1Coords(3,:),...
                     'Parent', axesHandle, 'Color', edgeColour);
        endBoxLine2 = line(...
                    line2Coords(1,:), line2Coords(2,:), line2Coords(3,:),...
                    'Parent', axesHandle, 'Color', edgeColour);
        endBoxLine3 = line(...
                    line3Coords(1,:), line3Coords(2,:), line3Coords(3,:),...
                    'Parent', axesHandle, 'Color', edgeColour);
        endBoxLine4 = line(...
                    line4Coords(1,:), line4Coords(2,:), line4Coords(3,:),...
                    'Parent', axesHandle, 'Color', edgeColour);

        endBoxLine5 = line(...
                    crossLine1Coords(1,:), crossLine1Coords(2,:), crossLine1Coords(3,:),...
                    'Parent', axesHandle, 'Color', edgeColour, 'LineStyle', '--');
        endBoxLine6 = line(...
                    crossLine2Coords(1,:), crossLine2Coords(2,:), crossLine2Coords(3,:),...
                    'Parent', axesHandle, 'Color', edgeColour, 'LineStyle', '--');
        
        % handles are returned, so that these lines can be deleted
        handles = [handles, {...
            beamLine1, beamLine2, beamLine3, beamLine4, beamLine5,...
            endBoxLine1, endBoxLine2, endBoxLine3, endBoxLine4, endBoxLine5, endBoxLine6}];
     end



    function app = setGUI(source, app)
        x = source.location(1);
        y = source.location(2);

        app.SourceLocationXEditField.Value = x;
        app.SourceLocationYEditField.Value = y;

        xy = source.dimensions(1).value;
        z = source.dimensions(2).value;

        xyUnits = source.dimensions(1).units;
        zUnits = source.dimensions(2).units;

        app.SourceDimsXYEditField.Value = xy;
        app.SourceDimsZEditField.Value = z;

        app.SourceDimsXYUnitsDropDown.Value = xyUnits;
        app.SourceDimsXYUnitsDropDown.Value = zUnits;

        xy = source.beamAngle(1);
        z = source.beamAngle(2);

        app.SourceBeamAngleXYEditField.Value = xy;
        app.SourceBeamAngleZEditField.Value = z;
            
        app.SourceSaveInSeparateFileCheckBox.Value = source.saveInSeparateFile;

        if ~source.saveInSeparateFile
            app.SourceFilePathLabel.Text = 'Tied to Simulation';
        elseif isempty(source.saveFileName)
            app.SourceFilePathLabel.Text = 'Not Saved';
        else
            app.SourceFilePathLabel.Text = source.saveFileName;
        end
    end

    function source = createFromGUI(source, app)
        x = app.SourceLocationXEditField.Value;
        y = app.SourceLocationYEditField.Value;

        source.location = [x,y];

        xy = app.SourceDimsXYEditField.Value;
        z = app.SourceDimsZEditField.Value;

        xyUnits = app.SourceDimsXYUnitsDropDown.Value;
        zUnits = app.SourceDimsZUnitsDropDown.Value;

        xyDimension = Dimension(xy, xyUnits);
        zDimension = Dimension(z, zUnits);

        source.dimensions = [xyDimension, zDimension];

        xy = app.SourceBeamAngleXYEditField.Value;
        z = app.SourceBeamAngleZEditField.Value;

        source.beamAngle = [xy, z];
        
        source.saveInSeparateFile = app.SourceSaveInSeparateFileCheckBox.Value;
    end

    function [startBoxCoords, endBoxCoords, directionUnitVector, perAngleShift] = getSourcePosition(source, slicePosition, angle, perAngleXY, perAngleZ, diameter)
        startingLocation = source.getLocationInM();

        z = slicePosition + perAngleZ;
        dirZ = 0;

        [theta, radius] = cart2pol(startingLocation(1), startingLocation(2));
        theta = theta * Constants.rad_to_deg;

        sourceAngle = theta - angle; % we minus the angle because we define angles to be clockwise, but in coords it is counter-clockwise

        [x,y] = pol2cart(sourceAngle * Constants.deg_to_rad, radius);

        perAngleX = cosd(sourceAngle + 90) * perAngleXY;
        perAngleY = sind(sourceAngle + 90) * perAngleXY;

        x = x + perAngleX;
        y = y + perAngleY;

        dirX = -cosd(sourceAngle);
        dirY = -sind(sourceAngle);

        sourcePosition = [x, y, z];
        directionUnitVector = [dirX, dirY, dirZ];
        perAngleShift = [perAngleX, perAngleY, perAngleZ];
        
        % find the coords for the start and end box of the source
        % start without perAngleShifts to make the math easier, and then
        % add the shifts back in later
        unshiftedSourceCoords = shiftCoords(sourcePosition, -perAngleShift);
        
        if source.isPointSource()
            startBoxClockwisePosZ           = unshiftedSourceCoords; % all the same, since point source
            startBoxClockwiseNegZ           = unshiftedSourceCoords;
            startBoxCounterClockwisePosZ    = unshiftedSourceCoords;
            startBoxCounterClockwiseNegZ    = unshiftedSourceCoords;
        else                
            if unitsArePlanar(source.dimensions)
                xyLength = source.dimensions(1).getLengthInM();
                zLength = source.dimensions(2).getLengthInM();

                rotationVector = [0,0,sourceAngle];

                startBoxClockwisePosZ = rotateCoords([radius,-xyLength/2,unshiftedSourceCoords(3)+zLength/2], rotationVector);
                startBoxClockwiseNegZ = rotateCoords([radius,-xyLength/2,unshiftedSourceCoords(3)-zLength/2], rotationVector);
                startBoxCounterClockwisePosZ = rotateCoords([radius,+xyLength/2,unshiftedSourceCoords(3)+zLength/2], rotationVector);
                startBoxCounterClockwiseNegZ = rotateCoords([radius,+xyLength/2,unshiftedSourceCoords(3)-zLength/2], rotationVector);
            else                    
                error('Undefined behaviour');
            end
        end
        
        xyBeamAngle = source.beamAngle(1);
        zBeamAngle = source.beamAngle(2);

        xyAngle = xyBeamAngle / 2;
        zAngle = zBeamAngle / 2;
        
        if isempty(diameter)
            diameter = 2 * radius;
        end            

        beamShift = [-diameter, 0, 0];
        rotationVector = [0,0,sourceAngle];

        beamShift = rotateCoords(beamShift, rotationVector);
        
        xyShift = diameter * tand(xyAngle);
        
        xyAngleShift = [0, xyShift, 0];

        xyAngleShift = rotateCoords(xyAngleShift, rotationVector);

        xyAngleShiftClockwise = -xyAngleShift;
        xyAngleShiftCounterClockwise = +xyAngleShift;

        zAngleShift = [0, 0, norm([diameter xyShift]) * tand(zAngle)];

        zAngleShiftPos = zAngleShift;
        zAngleShiftNeg = -zAngleShift;

        endBoxClockwisePosZ = startBoxClockwisePosZ + beamShift + xyAngleShiftClockwise + zAngleShiftPos;
        endBoxClockwiseNegZ = startBoxClockwiseNegZ + beamShift + xyAngleShiftClockwise + zAngleShiftNeg;
        endBoxCounterClockwisePosZ = startBoxCounterClockwisePosZ + beamShift + xyAngleShiftCounterClockwise + zAngleShiftPos;
        endBoxCounterClockwiseNegZ = startBoxCounterClockwiseNegZ + beamShift + xyAngleShiftCounterClockwise + zAngleShiftNeg;
        
        % apply the per angle shifts
        startBoxCoords = [...
            startBoxClockwisePosZ;...
            startBoxClockwiseNegZ;...
            startBoxCounterClockwisePosZ;...
            startBoxCounterClockwiseNegZ];
        
        endBoxCoords = [...
            endBoxClockwisePosZ;...
            endBoxClockwiseNegZ;...
            endBoxCounterClockwisePosZ;...
            endBoxCounterClockwiseNegZ];
        
        perAngleShifts = [...
            perAngleShift;...
            perAngleShift;...
            perAngleShift;...
            perAngleShift];
        
        startBoxCoords = shiftCoords(startBoxCoords, perAngleShifts);
        endBoxCoords = shiftCoords(endBoxCoords, perAngleShifts);
        
    end

end

end


function chordLength = findBeamChordLength(location, beamAngle)
theta = beamAngle / 2;

r = norm(location);

chordLength = sind(180-2*theta)*(r / sind(theta));
end