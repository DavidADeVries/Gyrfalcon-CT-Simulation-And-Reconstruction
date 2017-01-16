classdef Source
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
% centre
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

    savePath
    saveFileName
end

methods
    function source = Source(location, dimensions, beamAngle)
        if nargin > 0
            % validate source parameters and fill in blanks if needed

            % validate location
            locationNumDims = length(location);

            if locationNumDims < 2 || locationNumDims > 3
                error('Location of source not given in 2 or 3 space');
            elseif locationNumDims == 2
                % tack on z = 0 for completeness

                location = [location, 0];
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
    
    function bool = isPointSource(source)
        dimensions = source.dimensions;
        
        bool = dimensions(1).value == 0 && dimensions(2).value == 0;
    end
    
    function locationInM = getLocationInM(source)
        units = source.locationUnits;

        locationInM = units.convertToM(source.location);
    end

    function handles = plotSource(source, axesHandle, sourcePosition, sourceDirectionUnitVector, perAngleShiftsUsed)
        axes(axesHandle);
        hold on
        
        perAngleShiftsUsedForLineCoords = [perAngleShiftsUsed', perAngleShiftsUsed'];
        
        edgeColour = Constants.Source_Colour;
        faceColour = Constants.Source_Colour;
        lineStyle = []; % default
        lineWidth = []; % default
        
        % sourcePosition includes the perAngle translation shift, so we
        % want to take that out to make calculations earlier (for rotations
        % and such), and then add them back in
        sourcePosition = shiftCoords(sourcePosition, -perAngleShiftsUsed);

        x = sourcePosition(1);
        y = sourcePosition(2);
        z = sourcePosition(3);
                
        centreOfSourceCoords = [x,y,z];

        [theta, r] = cart2pol(x,y);
        theta = theta * Constants.rad_to_deg;

        if source.isPointSource()
            pointSourceCoords = centreOfSourceCoords;
            pointSourceCoords = shiftCoords(pointSourceCoords, perAngleShiftsUsed);            
            
            clockwisePosZ           = centreOfSourceCoords; % all the same, since point source
            clockwiseNegZ           = centreOfSourceCoords;
            counterClockwisePosZ    = centreOfSourceCoords;
            counterClockwiseNegZ    = centreOfSourceCoords;
            
            % plot point
            handle = circleOrArcPatch(...
                pointSourceCoords(1), pointSourceCoords(2), pointSourceCoords(3),...
                Constants.Point_Source_Radius, 0, 360,...
                edgeColour, faceColour, lineStyle, lineWidth);
            
            handles = {handle};
        else                
            if unitsArePlanar(source.dimensions)
                xyLength = source.dimensions(1).getLengthInM();
                zLength = source.dimensions(2).getLengthInM();

                rotationVector = [0,0,theta];

                clockwisePosZ = rotateCoords([r,-xyLength/2,z+zLength/2], rotationVector);
                clockwiseNegZ = rotateCoords([r,-xyLength/2,z-zLength/2], rotationVector);
                counterClockwisePosZ = rotateCoords([r,+xyLength/2,z+zLength/2], rotationVector);
                counterClockwiseNegZ = rotateCoords([r,+xyLength/2,z-zLength/2], rotationVector);

                line1Coords = [clockwisePosZ', clockwiseNegZ'];
                line2Coords = [clockwiseNegZ', counterClockwiseNegZ'];
                line3Coords = [counterClockwiseNegZ', counterClockwisePosZ'];
                line4Coords = [counterClockwisePosZ', clockwisePosZ'];
                
                % shift line coords for per angle translation
                line1Coords = shiftCoords(line1Coords, perAngleShiftsUsedForLineCoords);
                line2Coords = shiftCoords(line2Coords, perAngleShiftsUsedForLineCoords);
                line3Coords = shiftCoords(line3Coords, perAngleShiftsUsedForLineCoords);
                line4Coords = shiftCoords(line4Coords, perAngleShiftsUsedForLineCoords);

                line1 = line(line1Coords(1,:), line1Coords(2,:), line1Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
                line2 = line(line2Coords(1,:), line2Coords(2,:), line2Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
                line3 = line(line3Coords(1,:), line3Coords(2,:), line3Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
                line4 = line(line4Coords(1,:), line4Coords(2,:), line4Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
                
                handles = {line1, line2, line3, line4};
            else                    
                error('Undefined behaviour');
            end
        end

        xyBeamAngle = source.beamAngle(1);
        zBeamAngle = source.beamAngle(2);

        xyAngle = xyBeamAngle / 2;
        zAngle = zBeamAngle / 2;

        diameter = 2 * norm([x,y]);

        beamShift = [-diameter, 0, 0];
        rotationVector = [0,0,theta];

        beamShift = rotateCoords(beamShift, rotationVector);

        xyAngleShift = [0, diameter * tand(xyAngle), 0];

        xyAngleShift = rotateCoords(xyAngleShift, rotationVector);

        xyAngleShiftClockwise = -xyAngleShift;
        xyAngleShiftCounterClockwise = +xyAngleShift;

        zAngleShift = [0, 0, diameter * tand(zAngle)];

        zAngleShiftPos = zAngleShift;
        zAngleShiftNeg = -zAngleShift;

        endPointClockwisePosZ = clockwisePosZ + beamShift + xyAngleShiftClockwise + zAngleShiftPos;
        endPointClockwiseNegZ = clockwiseNegZ + beamShift + xyAngleShiftClockwise + zAngleShiftNeg;
        endPointCounterClockwisePosZ = counterClockwisePosZ + beamShift + xyAngleShiftCounterClockwise + zAngleShiftPos;
        endPointCounterClockwiseNegZ = counterClockwiseNegZ + beamShift + xyAngleShiftCounterClockwise + zAngleShiftNeg;
        
        % draw lines connecting source to end box
        line1Coords = [clockwisePosZ', endPointClockwisePosZ'];
        line2Coords = [clockwiseNegZ', endPointClockwiseNegZ'];
        line3Coords = [counterClockwisePosZ', endPointCounterClockwisePosZ'];
        line4Coords = [counterClockwiseNegZ', endPointCounterClockwiseNegZ'];
                      
        midlineCoords = [centreOfSourceCoords', shiftCoords(centreOfSourceCoords', beamShift')];
        
        % apply the per angle shift for these lines
        line1Coords = shiftCoords(line1Coords, perAngleShiftsUsedForLineCoords);
        line2Coords = shiftCoords(line2Coords, perAngleShiftsUsedForLineCoords);
        line3Coords = shiftCoords(line3Coords, perAngleShiftsUsedForLineCoords);
        line4Coords = shiftCoords(line4Coords, perAngleShiftsUsedForLineCoords);
        
        midlineCoords = shiftCoords(midlineCoords, perAngleShiftsUsedForLineCoords);        
        
        % plot the lines
        beamLine1 = line(line1Coords(1,:), line1Coords(2,:), line1Coords(3,:), 'Parent', axesHandle, 'Color',edgeColour);
        beamLine2 = line(line2Coords(1,:), line2Coords(2,:), line2Coords(3,:), 'Parent', axesHandle, 'Color',edgeColour);
        beamLine3 = line(line3Coords(1,:), line3Coords(2,:), line3Coords(3,:), 'Parent', axesHandle, 'Color',edgeColour);
        beamLine4 = line(line4Coords(1,:), line4Coords(2,:), line4Coords(3,:), 'Parent', axesHandle, 'Color',edgeColour);
        
        beamLine5 = line(midlineCoords(1,:), midlineCoords(2,:), midlineCoords(3,:), 'Parent', axesHandle, 'Color',edgeColour, 'LineStyle', '--');
        
        % draw end box
        line1Coords = [endPointClockwisePosZ', endPointCounterClockwisePosZ'];
        line2Coords = [endPointCounterClockwisePosZ', endPointCounterClockwiseNegZ'];
        line3Coords = [endPointCounterClockwiseNegZ', endPointClockwiseNegZ'];
        line4Coords = [endPointClockwiseNegZ', endPointClockwisePosZ'];
        
        crossLine1Coords = [endPointClockwisePosZ', endPointCounterClockwiseNegZ'];
        crossLine2Coords = [endPointCounterClockwisePosZ', endPointClockwiseNegZ'];
        
        % apply the per angle shift for these lines
        line1Coords = shiftCoords(line1Coords, perAngleShiftsUsedForLineCoords);
        line2Coords = shiftCoords(line2Coords, perAngleShiftsUsedForLineCoords);
        line3Coords = shiftCoords(line3Coords, perAngleShiftsUsedForLineCoords);
        line4Coords = shiftCoords(line4Coords, perAngleShiftsUsedForLineCoords);
        
        crossLine1Coords = shiftCoords(crossLine1Coords, perAngleShiftsUsedForLineCoords);
        crossLine2Coords = shiftCoords(crossLine2Coords, perAngleShiftsUsedForLineCoords);
        
        % plot the lines
        endBoxLine1 = line(line1Coords(1,:), line1Coords(2,:), line1Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
        endBoxLine2 = line(line2Coords(1,:), line2Coords(2,:), line2Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
        endBoxLine3 = line(line3Coords(1,:), line3Coords(2,:), line3Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
        endBoxLine4 = line(line4Coords(1,:), line4Coords(2,:), line4Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);

        endBoxLine5 = line(crossLine1Coords(1,:), crossLine1Coords(2,:), crossLine1Coords(3,:), 'Parent', axesHandle, 'Color',edgeColour, 'LineStyle', '--');
        endBoxLine6 = line(crossLine2Coords(1,:), crossLine2Coords(2,:), crossLine2Coords(3,:), 'Parent', axesHandle, 'Color',edgeColour, 'LineStyle', '--');
        
        % handles are returned, so that these lines can be deleted
        handles = [handles, {...
            beamLine1, beamLine2, beamLine3, beamLine4, beamLine5,...
            endBoxLine1, endBoxLine2, endBoxLine3, endBoxLine4, endBoxLine5, endBoxLine6}];
            
        
%         %x1 = sourcePosition(1);
%         y1 = sourcePosition(2);
%         z1 = sourcePosition(3);
% 
%         % plot source circle
% 
%         edgeColour = Constants.Source_Colour;
%         faceColour = Constants.Source_Colour;
%         lineStyle = [];
%         lineWidth = [];
% 
%         circleHandle = circleOrArcPatch(...
%             x1,y1,z1, Constants.Point_Source_Radius, 0, 360,...
%             edgeColour, faceColour, lineStyle, lineWidth);
% 
%         % plot midline
% 
%         % these x,y,z are representative of the middle of the per angle
%         % translation grid
%         x = x1 - perAngleShiftsUsed(1);
%         y = y1 - perAngleShiftsUsed(2);
%         z = z1 - perAngleShiftsUsed(3);
% 
%         [theta, radius] = cart2pol(x,y);
%         theta = theta * Constants.rad_to_deg;
% 
%         vector = 2 * radius * sourceDirectionUnitVector;
% 
%         x2 = x1 + vector(1);
%         y2 = y1 + vector(2);
%         z2 = z1 + vector(3);
% 
%         midlineHandle = line([x1,x2], [y1,y2], [z1,z2], 'Parent', axesHandle, 'Color', Constants.Source_Colour, 'LineStyle', '--');
% 
%         % plot beam angle lines
% 
%         units = source.beamAngleUnits;
% 
%         beamAngles = units.convertToDegrees(source.beamAngle);
% 
%         xyAngle = beamAngles(1) / 2;
%         zAngle = beamAngles(2) / 2;
% 
%         xyShift = 2 * radius * tand(xyAngle);
%         zShift = 2* radius * tand(zAngle);
% 
%         xShift = xyShift * cosd(theta + 90);
%         yShift = xyShift * sind(theta + 90);
% 
%         line1Endpoint = [x2 + xShift, y2 + yShift, z2 + zShift];
%         line2Endpoint = [x2 - xShift, y2 - yShift, z2 + zShift];
%         line3Endpoint = [x2 + xShift, y2 + yShift, z2 - zShift];
%         line4Endpoint = [x2 - xShift, y2 - yShift, z2 - zShift];
% 
%         line1Handle = line([x1, line1Endpoint(1)], [y1, line1Endpoint(2)], [z1, line1Endpoint(3)], 'Parent', axesHandle, 'Color', Constants.Source_Colour);
%         line2Handle = line([x1, line2Endpoint(1)], [y1, line2Endpoint(2)], [z1, line2Endpoint(3)], 'Parent', axesHandle, 'Color', Constants.Source_Colour);
%         line3Handle = line([x1, line3Endpoint(1)], [y1, line3Endpoint(2)], [z1, line3Endpoint(3)], 'Parent', axesHandle, 'Color', Constants.Source_Colour);
%         line4Handle = line([x1, line4Endpoint(1)], [y1, line4Endpoint(2)], [z1, line4Endpoint(3)], 'Parent', axesHandle, 'Color', Constants.Source_Colour);
% 
%         rectLine1Handle = line([line1Endpoint(1), line2Endpoint(1)], [line1Endpoint(2), line2Endpoint(2)], [line1Endpoint(3), line2Endpoint(3)], 'Parent', axesHandle, 'Color', Constants.Source_Colour);
%         rectLine2Handle = line([line2Endpoint(1), line4Endpoint(1)], [line2Endpoint(2), line4Endpoint(2)], [line2Endpoint(3), line4Endpoint(3)], 'Parent', axesHandle, 'Color', Constants.Source_Colour);
%         rectLine3Handle = line([line1Endpoint(1), line3Endpoint(1)], [line1Endpoint(2), line3Endpoint(2)], [line1Endpoint(3), line3Endpoint(3)], 'Parent', axesHandle, 'Color', Constants.Source_Colour);
%         rectLine4Handle = line([line3Endpoint(1), line4Endpoint(1)], [line3Endpoint(2), line4Endpoint(2)], [line3Endpoint(3), line4Endpoint(3)], 'Parent', axesHandle, 'Color', Constants.Source_Colour);
% 
%         crossLine1Handle = line([line1Endpoint(1), line4Endpoint(1)], [line1Endpoint(2), line4Endpoint(2)], [line1Endpoint(3), line4Endpoint(3)], 'Parent', axesHandle, 'Color', Constants.Source_Colour, 'LineStyle', '--');
%         crossLine2Handle = line([line2Endpoint(1), line3Endpoint(1)], [line2Endpoint(2), line3Endpoint(2)], [line2Endpoint(3), line3Endpoint(3)], 'Parent', axesHandle, 'Color', Constants.Source_Colour, 'LineStyle', '--');
% 
%         handles = {circleHandle, midlineHandle,...
%             line1Handle, line2Handle, line3Handle, line4Handle,...
%             rectLine1Handle, rectLine2Handle, rectLine3Handle, rectLine4Handle,...
%             crossLine1Handle, crossLine2Handle};
    end

%     function [] = plot(source, axesHandle)
%         dimensions = source.dimensions;
% 
%         edgeColour = Constants.Source_Colour;
%         faceColour = Constants.Source_Colour;
%         lineStyle = [];
%         lineWidth = [];
% 
%         locationInM = source.locationUnits.convertToM(source.location);
% 
%         x = locationInM(1);
%         y = locationInM(2);
%         z = locationInM(3);
% 
%         [theta, r] = cart2pol(x,y);
%         theta = theta * Constants.rad_to_deg;
% 
%         if dimensions(1).value == 0 && dimensions(2).value == 0 % point source
%             clockwisePosZ           = [x,y,z]; % all the same, since point source
%             clockwiseNegZ           = [x,y,z];
%             counterClockwisePosZ    = [x,y,z];
%             counterClockwiseNegZ    = [x,y,z];
% 
%             % plot point
%             circleOrArcPatch(...
%                 x,y,z, Constants.Point_Source_Radius, 0, 360,...
%                 edgeColour, faceColour, lineStyle, lineWidth);
%         else                
%             if unitsArePlanar(source.dimensionsUnits)
%                 xyLength = source.dimensionsUnits(1).convertToM(source.dimensions(2));
%                 zLength = source.dimensionsUnits(2).convertToM(source.dimensions(2));
% 
%                 rotationVector = [0,0,theta];
% 
%                 clockwisePosZ = rotateCoords([r,-xyLength/2,z+zLength/2], rotationVector);
%                 clockwiseNegZ = rotateCoords([r,-xyLength/2,z-zLength/2], rotationVector);
%                 counterClockwisePosZ = rotateCoords([r,+xyLength/2,z+zLength/2], rotationVector);
%                 counterClockwiseNegZ = rotateCoords([r,+xyLength/2,z-zLength/2], rotationVector);
% 
%                 line1Coords = [clockwisePosZ', clockwiseNegZ'];
%                 line2Coords = [clockwiseNegZ', counterClockwiseNegZ'];
%                 line3Coords = [counterClockwiseNegZ', counterClockwisePosZ'];
%                 line4Coords = [counterClockwisePosZ', clockwisePosZ'];
% 
%                 line1 = line(line1Coords(1,:), line1Coords(2,:), line1Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
%                 line2 = line(line2Coords(1,:), line2Coords(2,:), line2Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
%                 line3 = line(line3Coords(1,:), line3Coords(2,:), line3Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
%                 line4 = line(line4Coords(1,:), line4Coords(2,:), line4Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
% 
%             else                    
%                 error('Undefined behaviour');
%             end
%         end
% 
%         xyBeamAngle = source.beamAngle(1);
%         zBeamAngle = source.beamAngle(2);
% 
%         xyAngle = xyBeamAngle / 2;
%         zAngle = zBeamAngle / 2;
% 
%         diameter = 2 * norm([x,y]);
% 
%         beamShift = [-diameter, 0, 0];
%         rotationVector = [0,0,theta];
% 
%         beamShift = rotateCoords(beamShift, rotationVector);
% 
%         xyAngleShift = [0, diameter * tand(xyAngle), 0];
% 
%         xyAngleShift = rotateCoords(xyAngleShift, rotationVector);
% 
%         xyAngleShiftClockwise = xyAngleShift;
%         xyAngleShiftCounterClockwise = -xyAngleShift;
% 
%         zAngleShift = [0, 0, diameter * tand(zAngle)];
% 
%         zAngleShiftPos = zAngleShift;
%         zAngleShiftNeg = -zAngleShift;
% 
%         endPointClockwisePosZ = clockwisePosZ + beamShift + xyAngleShiftClockwise + zAngleShiftPos;
%         endPointClockwiseNegZ = clockwiseNegZ + beamShift + xyAngleShiftClockwise + zAngleShiftNeg;
%         endPointCounterClockwisePosZ = counterClockwisePosZ + beamShift + xyAngleShiftCounterClockwise + zAngleShiftPos;
%         endPointCounterClockwiseNegZ = counterClockwiseNegZ + beamShift + xyAngleShiftCounterClockwise + zAngleShiftNeg;
% 
% 
%         line1Coords = [clockwisePosZ', endPointClockwisePosZ'];
%         line2Coords = [clockwiseNegZ', endPointClockwiseNegZ'];
%         line3Coords = [counterClockwisePosZ', endPointCounterClockwisePosZ'];
%         line4Coords = [counterClockwiseNegZ', endPointCounterClockwiseNegZ'];
% 
%         line1 = line(line1Coords(1,:), line1Coords(2,:), line1Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
%         line2 = line(line2Coords(1,:), line2Coords(2,:), line2Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
%         line3 = line(line3Coords(1,:), line3Coords(2,:), line3Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
%         line4 = line(line4Coords(1,:), line4Coords(2,:), line4Coords(3,:), 'Parent', axesHandle,'Color',edgeColour);
% 
% 
% 
% 
%         lineLength = cosd(xyAngle) * cosd(zAngle) * diameter;
% 
% 
% 
% 
% 
%             ang = zBeamAngle / 2;
% 
%             zChordLength = tand(ang) * diameter;
% 
%             [theta,~] = cart2pol(-x,-y); % get angle for a 'pencil beam'
% 
%             theta = theta * Constants.rad_to_deg;
% 
%             xyAngle1 = theta - xyBeamAngle/2;
%             xyAngle2 = theta + xyBeamAngle/2;
% 
%             zAngle1 = - zBeamAngle/2;
%             zAngle2 = zBeamAngle/2;
% 
%             rotationOrigin = [x,y,z];
% 
%             aboutY = [0,1,0];
%             aboutZ = [0,0,1]; %about z-axis
% 
%             line_x = [x, x + norm([xyChordLength, zChordLength])];
%             line_y = [y, y];
%             line_z = [z, z];
% 
%             line1 = line(line_x, line_y, line_z, 'Parent', axesHandle, 'Color', Constants.Source_Colour);
%             line2 = line(line_x, line_y, line_z, 'Parent', axesHandle, 'Color', Constants.Source_Colour);
%             line3 = line(line_x, line_y, line_z, 'Parent', axesHandle, 'Color', Constants.Source_Colour);
%             line4 = line(line_x, line_y, line_z, 'Parent', axesHandle, 'Color', Constants.Source_Colour);
% 
%             line_x = [x, x + 2*norm(source.location)];
% 
%             midline = line(line_x, line_y, line_z, 'Parent', axesHandle, 'Color', Constants.Source_Colour, 'LineStyle', '--');
% 
%             % first rotate lines 1 - 4 around Y
%             rotate(line1, aboutY, zAngle1, rotationOrigin);
%             rotate(line2, aboutY, zAngle1, rotationOrigin);
%             rotate(line3, aboutY, zAngle2, rotationOrigin);
%             rotate(line4, aboutY, zAngle2, rotationOrigin);
% 
%             rotate(line1, aboutZ, xyAngle1, rotationOrigin);
%             rotate(line2, aboutZ, xyAngle2, rotationOrigin);
%             rotate(line3, aboutZ, xyAngle1, rotationOrigin);
%             rotate(line4, aboutZ, xyAngle2, rotationOrigin);
% 
%             rotate(midline, aboutZ, theta, rotationOrigin);
% 
%             % plot circle of source path during gantry rotation
%             x1 = 0;
%             y1 = 0;
%             z1 = z;
%             r = norm([x,y]);
%             edgeColour = Constants.Source_Colour;
%             faceColour = [];
%             lineStyle = ':';
%             lineWidth = [];
% 
%             circleOrArcPatch(x1, y1, z1, r, 0, 360, edgeColour, faceColour, lineStyle, lineWidth);
% 
%             x2 = 0;
%             y2 = 0;
%             z2 = z - zChordLength;
% 
%             circleOrArcPatch(x2, y2, z2, r, 0, 360, edgeColour, faceColour, lineStyle, lineWidth);
% 
%             x3 = 0;
%             y3 = 0;
%             z3 = z + zChordLength;
% 
%             circleOrArcPatch(x3, y3, z3, r, 0, 360, edgeColour, faceColour, lineStyle, lineWidth);
%         else
%             error('Undefined behaviour');
%         end
%     end

    function handles = setGUI(source, handles)
        x = source.location(1);
        y = source.location(2);
        z = source.location(3);

        setDoubleForHandle(handles.sourceStartingLocationXEdit, x);
        setDoubleForHandle(handles.sourceStartingLocationYEdit, y);
        setDoubleForHandle(handles.sourceStartingLocationZEdit, z);

        xy = source.dimensions(1).value;
        z = source.dimensions(2).value;

        xyUnits = source.dimensions(1).units;
        zUnits = source.dimensions(2).units;

        setDoubleForHandle(handles.sourceDimensionsXYEdit, xy);
        setDoubleForHandle(handles.sourceDimensionsZEdit, z);

        setSelectionForPopupMenu(handles.sourceDimensionsXYUnitsPopupMenu, 'Units', xyUnits);
        setSelectionForPopupMenu(handles.sourceDimensionsZUnitsPopupMenu, 'Units', zUnits);

        xy = source.beamAngle(1);
        z = source.beamAngle(2);

        setDoubleForHandle(handles.sourceBeamAngleXYEdit, xy);
        setDoubleForHandle(handles.sourceBeamAngleZEdit, z);

        if isempty(source.saveFileName)
            setString(handles.sourceFileNameText, 'Not Saved');
        else
            setString(handles.sourceFileNameText, source.saveFileName);
        end

        % set hidden handles
        handles.sourceSavePath = source.savePath;
        handles.sourceSaveFileName = source.saveFileName;
    end

    function source = createFromGUI(source, handles)
        x = getDoubleFromHandle(handles.sourceStartingLocationXEdit);
        y = getDoubleFromHandle(handles.sourceStartingLocationYEdit);
        z = getDoubleFromHandle(handles.sourceStartingLocationZEdit);

        source.location = [x,y,z];

        xy = getDoubleFromHandle(handles.sourceDimensionsXYEdit);
        z = getDoubleFromHandle(handles.sourceDimensionsZEdit);

        xyUnits = getSelectionFromPopupMenu(handles.sourceDimensionsXYUnitsPopupMenu, 'Units');
        zUnits = getSelectionFromPopupMenu(handles.sourceDimensionsZUnitsPopupMenu, 'Units');

        xyDimension = Dimension(xy, xyUnits);
        zDimension = Dimension(z, zUnits);

        source.dimensions = [xyDimension, zDimension];

        xy = getDoubleFromHandle(handles.sourceBeamAngleXYEdit);
        z = getDoubleFromHandle(handles.sourceBeamAngleZEdit);

        source.beamAngle = [xy, z];


        source.savePath = handles.sourceSavePath;
        source.saveFileName = handles.sourceSaveFileName;
    end

    function [sourcePosition, directionUnitVector, perAngleShift] = getSourcePosition(source, slicePosition, angle, perAngleXY, perAngleZ)
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
    end

end

end


function chordLength = findBeamChordLength(location, beamAngle)
theta = beamAngle / 2;

r = norm(location);

chordLength = sind(180-2*theta)*(r / sind(theta));
end