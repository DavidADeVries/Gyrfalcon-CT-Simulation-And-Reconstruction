classdef Scan < GyrfalconObject
    % Scan
    % This class contains all the data pertaining to an CT scan
    % 
    % FIELDS:
    % *scanAngles:
    % the angles at which the source (and detector in some cases)
    % will go to during the duration of the scan
    % [0,45,90,135,180,225,270,315]
    %
    % *slices: 
    % the positions in the z (slice) direction that the gantry will go to
    % [0,1,2,3]
    % units are in mm
    %
    % *perAngleTranslationDimensions:
    % the dimensions that the source/detector should translate with at each
    % angle the gantry moves too
    % [transverse, depth]
    % units are in m
    %
    % *perAngleTranslationResolution:
    % the step-size that is used to transverse the above 
    % perAngleTranslationDimesion
    % [transverse, depth]
    % units are in m
    %
    % *beamCharacterization:
    % an aray of PhotonBeam data structures, that describe the
    % total overall beam being used in imaging. Use {singleEnergyBeam} for
    % a single energy beam
    % [photonBeam1, photonBeam2, photonBeam3]
    
    
    
    properties
        scanAngles
        scanAngleUnits = Units.degree
        
        slices
        sliceUnits = Units.mm
        
        perAngleTranslationDimensions
        perAngleTranslationResolution
        perAngleTranslationUnits = Units.mm
        
        beamCharacterization
        
    end
    
    methods
        function scan = Scan(scanAngles, slices, perAngleTranslationDimensions, perAngleTranslationResolution, beamCharacterization)
            if nargin > 0
                % validate scan parameters and fill in blanks if needed
                
                % validate scanAngles
                % no validation
                
                % validate slices
                % no validation
                
                % validate perAngleTranslationDimensions
                perAngleTranslationDimensionsNumDims = length(perAngleTranslationDimensions);
                
                if perAngleTranslationDimensionsNumDims < 1 || perAngleTranslationDimensionsNumDims > 2
                    error('Translation Dimensions not given in 1 or 2 space');
                elseif perAngleTranslationDimensionsNumDims == 1
                    % make depth measurement as 0
                    
                    perAngleTranslationDimensions = [perAngleTranslationDimensions, 0];
                end
                
                % validate perAngleTranslationResolution
                perAngleTranslationResolutionNumDims = length(perAngleTranslationResolution);
                
                if perAngleTranslationResolutionNumDims < 1 || perAngleTranslationResolutionNumDims > 2
                    error('Translation Resolution not given in 1 or 2 space');
                elseif perAngleTranslationResolutionNumDims == 1
                    % make depth resolution as 0
                    
                    perAngleTranslationResolution = [perAngleTranslationResolution, 0];
                end
                
                if perAngleTranslationDimensionsNumDims ~= perAngleTranslationResolutionNumDims
                    error('Translation Dimensions and Resolution dimensionality are not consistent');
                end
                
                % validate beamCharacterization
                % no validation
                
                % if we get here, we're good to go, so lets assign the fields
                scan.scanAngles = scanAngles;
                scan.slices = slices;
                scan.perAngleTranslationDimensions = perAngleTranslationDimensions;
                scan.perAngleTranslationResolution = perAngleTranslationResolution;
                scan.beamCharacterization = beamCharacterization;
            end
        end
                
        function object = createBlankObject(object)
            object = Scan;
        end
        
        function name = displayName(scan)
            name = 'Scan';
        end
        
        function [saved, scanForGUI, scanForParent, scanForSaving] = saveChildrenObjects(scan)
            scanForGUI = scan;
            scanForParent = scan;
            scanForSaving = scan;
            
            if ~isempty(scan.beamCharacterization)
                [saved, beamForGUI, beamForParent, ~] = scan.beamCharacterization.saveAsIfChanged();
                
                if saved
                    scanForGUI.beamCharacterization = beamForGUI;
                    scanForParent.beamCharacterization = beamForParent;
                    scanForSaving.beamCharacterization = beamForParent;
                end
            else
                saved = true;
            end
        end
        
        function scan = loadFields(scan)
            scan.beamCharacterization = scan.beamCharacterization.load();
        end   
                       
        function source = setDefaultValues(source)
            source.scanAngles = 0;
            source.slices = 0;
            
            source.perAngleTranslationDimensions = [1,1];
            source.perAngleTranslationResolution = [0,0];
            
            beam = PhotonBeam;
            beam.setDefaultValues();
            
            source.beamCharacterization = beam;
        end
        
        function name = defaultName(scan)
            name = [Constants.Default_Scan_Name, Constants.Matlab_File_Extension]; 
        end
        
        function bool = equal(scan1, scan2)
            b1 = matricesEqual(scan1.scanAngles, scan2.scanAngles);
            b2 = scan1.scanAngleUnits == scan2.scanAngleUnits;
            b3 = matricesEqual(scan1.slices, scan2.slices);
            b4 = scan1.sliceUnits == scan2.sliceUnits;
            b5 = matricesEqual(scan1.perAngleTranslationDimensions, scan2.perAngleTranslationDimensions);
            b6 = matricesEqual(scan1.perAngleTranslationResolution, scan2.perAngleTranslationResolution);
            b7 = scan1.perAngleTranslationUnits == scan2.perAngleTranslationUnits;
            
            b8 = gyrfalconObjectsEqual(scan1.beamCharacterization, scan2.beamCharacterization);
            
            b9 = strcmp(scan1.savePath, scan2.savePath);
            b10 = strcmp(scan1.saveFileName, scan2.saveFileName);
        
            bool = b1 && b2 && b3 && b4 && b5 && b6 && b7 && b8 && b9 && b10;
        end
        
        function slicesInM = getSlicesInM(scan)
            slices = scan.slices;
            units = scan.sliceUnits;
            
            slicesInM = units.convertToM(slices);
        end
        
        function anglesInDegrees = getScanAnglesInDegrees(scan)
            angles = scan.scanAngles;
            units = scan.scanAngleUnits;
            
            anglesInDegrees = units.convertToDegrees(angles);
        end
        
        function [perAngleXYInM, perAngleZInM] = getPerAnglePositionInM(scan, xyStep, zStep)
            units = scan.perAngleTranslationUnits;
            
            totalNumXYSteps = scan.perAngleTranslationDimensions(1);
            totalNumZSteps = scan.perAngleTranslationDimensions(2);
            
            midXYStep = (totalNumXYSteps + 1) / 2;
            midZStep = (totalNumZSteps + 1) / 2;
            
            xyPos = (xyStep - midXYStep) * scan.perAngleTranslationResolution(1);
            zPos = (zStep - midZStep) * scan.perAngleTranslationResolution(2);
            
            perAngleXYInM = units.convertToM(xyPos);
            perAngleZInM = units.convertToM(zPos);
        end
        
        function handles = plotSlices(scan, source, axesHandle, slicePositionInM)
            if isempty(slicePositionInM)
                slicePositions = scan.getSlicesInM();
            else
                slicePositions = slicePositionInM;
            end
            
            for i=1:length(slicePositions)
                slicePosition = slicePositions(i);
                
                locationInM = source.getLocationInM();
                
                x = 0;
                y = 0; % at origin
                r = norm([locationInM(1), locationInM(2)]); % found above
                ang1 = 0;
                ang2 = 360; % to make circle
                
                edgeColour = Constants.Slice_Colour;
                faceColour = 'none';
                lineStyle = '--';
                lineWidth = [];
                
                handle = circleOrArcPatch(...
                    x, y, slicePosition,...
                    r, ang1, ang2,...
                    edgeColour, faceColour, lineStyle, lineWidth, axesHandle);
                
                handles = {handle};
            end
        end
        
        function handles = plot(scan, source, axesHandle, slicePosition, angle)            
            handles = {};
            
            locationInM = source.locationUnits.convertToM(source.location);
            
            if ~isempty(slicePosition) % set z to slice position
                locationInM(3) = slicePosition;
            end
            
            if ~isempty(angle)
                [theta,radius] = cart2pol(locationInM(1),locationInM(2));
                theta = theta * Constants.rad_to_deg;
                
                theta = theta - angle; %negative because our angles are clockwise
                
                theta = theta * Constants.deg_to_rad;
                [x,y] = pol2cart(theta,radius);
                
                locationInM(1) = x;
                locationInM(2) = y;
            end
            
            % plot per angle translation grid
            translationResolutionInM = scan.perAngleTranslationUnits.convertToM(scan.perAngleTranslationResolution);
            
            x = locationInM(1);
            y = locationInM(2);
            z = locationInM(3);
            
            [theta,radius] = cart2pol(x,y);                
            theta = theta * Constants.rad_to_deg;
            
            aboutZ = [0,0,1];
            
            xyResolution = translationResolutionInM(1);
            zResolution = translationResolutionInM(2);
            
            xyNumSteps = scan.perAngleTranslationDimensions(1);
            zNumSteps = scan.perAngleTranslationDimensions(2);
            
            if xyNumSteps ~= 0
                xyNumSteps = xyNumSteps - 1;
            end
            
            if zNumSteps ~= 0
                zNumSteps = zNumSteps - 1;
            end
            
            xyStart = -xyResolution*(xyNumSteps/2);
            xyEnd = xyResolution*(xyNumSteps/2);
            
            zStart = z-(zNumSteps/2)*zResolution;
            zEnd = z+(zNumSteps/2)*zResolution;
            
            lineColour = Constants.Per_Angle_Translation_Colour;
            
            if xyStart == xyEnd % draw line along z
                
                handle = line(...
                    [x,x], [y,y], [zStart,zEnd],...
                    'Color', lineColour, 'Parent', axesHandle);
                                
                % add handle
                handles = [handles, {handle}];
                
                for zVal=zStart:zResolution:zEnd
                    y1 = y - Constants.Per_Angle_Translation_Tick_Length;
                    y2 = y + Constants.Per_Angle_Translation_Tick_Length;
                    
                    lineHandle = line(...
                        [x,x], [y1,y2], [zVal,zVal],...
                        'Color', lineColour, 'Parent', axesHandle);
                    
                    origin = [x, y, zVal];
                    
                    rotate(lineHandle, aboutZ, theta, origin);
                    
                    % add handle
                    handles = [handles, {lineHandle}];
                end
            else
                for zVal=zStart:zResolution:zEnd
                    lineHandle = line(...
                        [radius,radius], [xyStart,xyEnd], [zVal,zVal],...
                        'Color', lineColour, 'Parent', axesHandle);
                    
                    % add handle
                    handles = [handles, {lineHandle}];
                        
                    rotate(lineHandle, aboutZ, theta);
                    
                    for xyVal=xyStart:xyResolution:xyEnd
                        z1 = zVal - Constants.Per_Angle_Translation_Tick_Length;
                        z2 = zVal + Constants.Per_Angle_Translation_Tick_Length;
                        
                        lineHandle = line(...
                            [radius,radius], [xyVal,xyVal], [z1,z2],...
                            'Color', lineColour, 'Parent', axesHandle);
                                                
                        rotate(lineHandle, aboutZ, theta);
                        
                        % add handle
                        handles = [handles, {lineHandle}];
                    end
                end
            end
            
        end
               
        function handles = setGUI(scan, handles)
            setMultipleDoublesForHandle(handles.scanAnglesEdit, scan.scanAngles);
            setMultipleDoublesForHandle(handles.scanSlicePositionsEdit, scan.slices);
            
            xy = scan.perAngleTranslationDimensions(1);
            z = scan.perAngleTranslationDimensions(2);
            
            setDoubleForHandle(handles.scanPerAngleTranslationStepsXYEdit, xy);
            setDoubleForHandle(handles.scanPerAngleTranslationStepsZEdit, z);
            
            xy = scan.perAngleTranslationResolution(1);
            z = scan.perAngleTranslationResolution(2);
            
            setDoubleForHandle(handles.scanPerAngleStepDimensionsXYEdit, xy);
            setDoubleForHandle(handles.scanPerAngleStepDimensionsZEdit, z);
            
            set(handles.scanSaveInSeparateFileCheckbox, 'Value', scan.saveInSeparateFile);
                                    
            if ~scan.saveInSeparateFile
                setString(handles.scanFileNameText, 'Tied to Simulation');
            elseif isempty(scan.saveFileName)
                setString(handles.scanFileNameText, 'Not Saved');
            else
                setString(handles.scanFileNameText, scan.saveFileName);
            end
            
            handles = scan.beamCharacterization.setGUI(handles);
        end
        
        function scan = createFromGUI(scan, handles)
            scan.scanAngles = getMultipleDoublesFromHandle(handles.scanAnglesEdit);
            scan.slices = getMultipleDoublesFromHandle(handles.scanSlicePositionsEdit);
            
            xy = getDoubleFromHandle(handles.scanPerAngleTranslationStepsXYEdit);
            z = getDoubleFromHandle(handles.scanPerAngleTranslationStepsZEdit);
            
            scan.perAngleTranslationDimensions = [xy, z];
            
            xy = getDoubleFromHandle(handles.scanPerAngleStepDimensionsXYEdit);
            z = getDoubleFromHandle(handles.scanPerAngleStepDimensionsZEdit);
            
            scan.perAngleTranslationResolution = [xy, z];
            
            scan.beamCharacterization = scan.beamCharacterization.createFromGUI(handles);
            
            scan.saveInSeparateFile = get(handles.scanSaveInSeparateFileCheckbox,'Value');
        end
        
    end
    
end

