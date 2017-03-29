classdef Simulation < GyrfalconObject
    % Simulation
    % This class contains all the data pertaining to an CT scan simulation
    % 
    % FIELDS:
    % *phantom:
    %  See Phantom class
    %
    % *detector: 
    %  See Detector class
    %
    % *source:
    %  See Source class
    %
    % *scan:
    %  See Scan class
    %
    % *scatteringNoiseLevel:
    % The level of noise modelled from Compton scattering
    % [0..1] (0 - no noise)
    %
    % *detectorNoiseLevel:
    % The level of noise modelled from electronic noise in the detectors
    % [0..1] (0 - no noise)
    %
    % *partialPixelModelling
    % Boolean field that if true, means that partial values of pixels will
    % be used in the attenuation modelling
    % T/F
    
    
    
    properties
        phantom
        detector
        source
        scan
        
        scatteringNoiseLevel
        detectorNoiseLevel
        partialPixelModelling
        partialPixelResolution
        
    end
    
    methods
        function simulation = Simulation(phantom, detector, source, scan, scatteringNoiseLevel, detectorNoiseLevel, partialPixelModelling, partialPixelResolution)
            if nargin > 0
                % validate simulation parameters and fill in blanks if needed
                
                % phantom, detector, source, scan are all validated within
                % their classes
                
                % validate scatteringNoiseLevel
                if scatteringNoiseLevel < 0 || scatteringNoiseLevel > 1
                    error('Scattering Noise Level is not between 0 and 1')
                end
                
                % validate detectorNoiseLevel
                if detectorNoiseLevel < 0 || detectorNoiseLevel > 1
                    error('Detector Noise Level is not between 0 and 1')
                end
                
                % validate partialPixelModelling
                % no validation needed
                
                % if we get here, we're good to go, so lets assign the fields
                simulation.phantom = phantom;
                simulation.detector = detector;
                simulation.source = source;
                simulation.scan = scan;
                simulation.scatteringNoiseLevel = scatteringNoiseLevel;
                simulation.detectorNoiseLevel = detectorNoiseLevel;
                simulation.partialPixelModelling = partialPixelModelling;
                simulation.partialPixelResolution = partialPixelResolution;
            end
        end
        
        function object = createBlankObject(object)
            object = Simulation;
        end
        
        function simulation = setDefaultValues(simulation)
            phantom = Phantom;
            phantom = phantom.setDefaultValues();
            
            detector = Detector;
            detector = detector.setDefaultValues();
                        
            source = Source;
            source = source.setDefaultValues();
                        
            scan = Scan;
            scan = scan.setDefaultValues();
            
            simulation.phantom = phantom;
            simulation.detector = detector;
            simulation.source = source;
            simulation.scan = scan;
            
            simulation.scatteringNoiseLevel = 0;
            simulation.detectorNoiseLevel = 0;
            simulation.partialPixelModelling = true;
            simulation.partialPixelResolution = 1;
        end
        
        function name = defaultName(simulation)
            name = [Constants.Default_Simulation_Name, Constants.Matlab_File_Extension];
        end
                
        function name = displayName(simulation)
            name = 'Simulation';
        end
        
        function [] = plot(simulation, handles)
            axesHandle = handles.axesHandle;
            
            axes(axesHandle);
            
            redrawAxes(axesHandle);
            
            simulation.phantom.plot(axesHandle);
            
            slicePosition = [];
            angle = [];
            
            simulation.detector.plot(axesHandle, slicePosition, angle, 0, 0);
            simulation.source.plot(axesHandle,[],[]);
            simulation.scan.plot(simulation.source, axesHandle, 0, 0);
            
            slicePosition = []; %plot all
            
            simulation.scan.plotSlices(simulation.source, axesHandle, slicePosition);
                       
        end
        
        function plotHandles = plotSlice(simulation, axesHandle, slicePosition)
            plotHandles = plotSlices(simulation.scan, simulation.source, axesHandle, slicePosition);
        end
        
        function plotHandles = plotAngle(simulation, axesHandle, slicePosition, angle)
            if ~simulation.detector.movesWithPerAngleTranslation
                detectorHandles = simulation.detector.plot(axesHandle, slicePosition, angle, 0, 0);
            else
                detectorHandles = {};
            end
            
            scanHandles = simulation.scan.plot(simulation.source, axesHandle, slicePosition, angle);
            
            plotHandles = [detectorHandles, scanHandles];
        end
        
        function plotHandles = plotPerAnglePosition(simulation, axesHandle, slicePosition, angle, perAngleXY, perAngleZ, startBoxCoords, endBoxCoords)
            if simulation.detector.movesWithPerAngleTranslation
                detectorHandles = simulation.detector.plot(axesHandle, slicePosition, angle, perAngleXY, perAngleZ);
            else
                detectorHandles = {};
            end
            
            sourceHandles = simulation.source.plot(axesHandle, startBoxCoords, endBoxCoords);
            
            plotHandles = [detectorHandles, sourceHandles];
        end
        
        function plotHandles = plotDetectorRaster(simulation, axesHandle, detectorCornerCoords)
            axes(axesHandle);
            hold on
            
            temp = detectorCornerCoords(3,:);
            
            detectorCornerCoords(3,:) = detectorCornerCoords(4,:);
            detectorCornerCoords(4,:) = temp;
            
            x = detectorCornerCoords(:,1);
            y = detectorCornerCoords(:,2);
            z = detectorCornerCoords(:,3);
            
            plotHandles = patch(...
                'XData', x, 'YData', y, 'ZData', z,...
                'FaceColor', Constants.Detector_Raster_Colour,...
                'FaceAlpha', Constants.Detector_Raster_Alpha,...
                'EdgeColor', 'none',...
                'LineStyle', 'none',...
                'Parent', axesHandle);
            
            plotHandles = {plotHandles};
        end
        
        function handles = setGUI(simulation, handles)
            
            % PHANTOM
            
            handles = simulation.phantom.setGUI(handles);
            
            % DETECTOR
            
            handles = simulation.detector.setGUI(handles);
            
            % SOURCE
            
            handles = simulation.source.setGUI(handles);
            
            % SCAN
            
            handles = simulation.scan.setGUI(handles);
            
            % SIMULATION
            
            setDoubleForHandle(handles.simulationScatteringNoiseLevelEdit, simulation.scatteringNoiseLevel);
            setDoubleForHandle(handles.simulationDetectorNoiseLevelEdit, simulation.detectorNoiseLevel);
            set(handles.simulationPartialPixelModellingCheckbox, 'Value', simulation.partialPixelModelling);
            setDoubleForHandle(handles.simulationPartialPixelResolutionEdit, simulation.partialPixelResolution);
                        
            set(handles.simulationSaveInSeparateFileCheckbox, 'Value', simulation.saveInSeparateFile);
            
            if ~simulation.saveInSeparateFile
                setString(handles.simulationFileNameText, 'Tied to Workspace');
            elseif isempty(simulation.saveFileName)
                setString(handles.simulationFileNameText, 'Not Saved');
            else
                setString(handles.simulationFileNameText, simulation.saveFileName);
            end
        end
        
        function simulation = createFromGUI(simulation, handles)
            % PHANTOM
                        
            simulation.phantom = simulation.phantom.createFromGUI(handles);
            
            % DETECTOR
                        
            simulation.detector = simulation.detector.createFromGUI(handles);
            
            % SOURCE
                        
            simulation.source = simulation.source.createFromGUI(handles);
            
            % SCAN
                        
            simulation.scan = simulation.scan.createFromGUI(handles);
            
            % SIMULATION
            
            simulation.scatteringNoiseLevel = getDoubleFromHandle(handles.simulationScatteringNoiseLevelEdit);
            simulation.detectorNoiseLevel = getDoubleFromHandle(handles.simulationDetectorNoiseLevelEdit);
            simulation.partialPixelModelling = get(handles.simulationPartialPixelModellingCheckbox, 'Value');
            simulation.partialPixelResolution = getDoubleFromHandle(handles.simulationPartialPixelResolutionEdit);
            
            simulation.saveInSeparateFile = get(handles.simulationSaveInSeparateFileCheckbox,'Value');
        end
        
        function bool = equal(sim1, sim2)
            b1 = gyrfalconObjectsEqual(sim1.phantom, sim2.phantom);
            b2 = gyrfalconObjectsEqual(sim1.detector, sim2.detector);
            b3 = gyrfalconObjectsEqual(sim1.source, sim2.source);
            b4 = gyrfalconObjectsEqual(sim1.scan, sim2.scan);
            
            b5 = matricesEqual(sim1.scatteringNoiseLevel, sim2.scatteringNoiseLevel);
            b6 = matricesEqual(sim1.detectorNoiseLevel, sim2.detectorNoiseLevel);
            b7 = matricesEqual(sim1.partialPixelModelling, sim2.partialPixelModelling);
            b8 = matricesEqual(sim1.partialPixelResolution, sim2.partialPixelResolution);
            
            bool = b1 && b2 && b3 && b4 && b5 && b6 && b7 && b8;
        end
        
        function [saved, simulationForGUI, simulationForParent, simulationForSaving] = saveChildrenObjects(simulation)
            simulationForGUI = simulation;
            simulationForParent = simulation;
            simulationForSaving = simulation;
            
            if ~isempty(simulation.phantom)
                [saved, phantomForGUI, phantomForParent, ~] = simulation.phantom.saveAsIfChanged();
                
                if saved
                    simulationForGUI.phantom = phantomForGUI;
                    simulationForParent.phantom = phantomForParent;
                    simulationForSaving.phantom = phantomForParent;
                end
            else
                saved = true;
            end
            
            if saved
                if ~isempty(simulation.source)
                    [saved, sourceForGUI, sourceForParent, ~] = simulation.source.saveAsIfChanged();
                    
                    if saved
                        simulationForGUI.source = sourceForGUI;
                        simulationForParent.source = sourceForParent;
                        simulationForSaving.source = sourceForParent;
                    end
                else
                    saved = true;
                end
            end
            
            if saved
                if ~isempty(simulation.detector)
                    [saved, detectorForGUI, detectorForParent, ~] = simulation.detector.saveAsIfChanged();
                    
                    if saved
                        simulationForGUI.detector = detectorForGUI;
                        simulationForParent.detector = detectorForParent;
                        simulationForSaving.detector = detectorForParent;
                    end
                else
                    saved = true;
                end
            end
            
            if saved
                if ~isempty(simulation.scan)
                    [saved, scanForGUI, scanForParent, ~] = simulation.scan.saveAsIfChanged();
                    
                    if saved
                        simulationForGUI.scan = scanForGUI;
                        simulationForParent.scan = scanForParent;
                        simulationForSaving.scan = scanForParent;
                    end
                else
                    saved = true;
                end
            end
        end
        
        function [simulation, simulationForSaving] = clearBeforeSaveFields(simulation, clearBeforeSave)
            simulationForSaving = simulation;
            
            [phantom, phantomForSaving] = simulation.phantom.saveBeforeClearIfNeeded();
            
            simulation.phantom = phantom;
            simulationForSaving.phantom = phantomForSaving;
            
            [detector, detectorForSaving] = simulation.detector.saveBeforeClearIfNeeded();
            
            simulation.detector = detector;
            simulationForSaving.detector = detectorForSaving;
            
            [source, sourceForSaving] = simulation.source.saveBeforeClearIfNeeded();
            
            simulation.source = source;
            simulationForSaving.source = sourceForSaving;
            
            [scan, scanForSaving] = simulation.scan.saveBeforeClearIfNeeded();
            
            simulation.scan = scan;
            simulationForSaving.scan = scanForSaving;
            
            if clearBeforeSave
                if simulationForSaving.saveInSeparateFile
                    cache = simulationForSaving;
                    
                    simulationForSaving = Simulation;
                    
                    simulationForSaving.savePath = cache.savePath;
                    simulationForSaving.saveFileName = cache.saveFileName;
                else
                    simulationForSaving.savePath = '';
                    simulationForSaving.saveFileName = '';
                end
            end
        end
        
        function simulation = loadFields(simulation)
            simulation.phantom = simulation.phantom.load();
            simulation.detector = simulation.detector.load();
            simulation.source = simulation.source.load();
            simulation.scan = simulation.scan.load();
        end    
        
        function simulation = calibrateAndSetPhantomData(simulation)
            phantomDataInHU = simulation.phantom.data;
            
            beam = simulation.scan.beamCharacterization;
            
            beam = beam.calibrateAndSetPhantomData(phantomDataInHU);
            
            simulation.scan.beamCharacterization = beam;
        end
        
        function [scanGeometry, errorMsg] = findScanGeometry(simulation)
            [scanGeometry, errorMsg] = boolLogicForFindScanGeometry(simulation);
        end
        
        function data = runScanSimulation(simulation, axesHandle, displaySlices, displayAngles, displayPerAnglePosition, displayDetectorRaster, displayDetectorValues, displayDetectorRayTrace, statusOutputTextHandle, savePath)
            slices = simulation.scan.getSlicesInM();
            
            numSlices = length(slices);
            
            data = cell(numSlices, 1);
            
            % we're going to be displaying the scan, so get the axis ready
            if displaySlices || displayAngles || displayPerAnglePosition || displayDetectorRaster
                                
                axes(axesHandle);
                
                [az,el] = view;
                
                redrawAxes(axesHandle);
                
                view(az,el);
                
                simulation.phantom.plot(axesHandle);
            end
            
            if displayDetectorValues
                figure(...
                    'Color', Constants.Detector_Display_Colour,...
                    'Name', Constants.Detector_Display_Title);
                
                displayRange = [0, simulation.scan.beamCharacterization.rawIntensity()];
                
                detectorImageHandle = imshow([], displayRange, 'InitialMagnification', 'fit');
            else
                detectorImageHandle = [];
            end
            
            baseString = getString(statusOutputTextHandle);
            
            baseString = [baseString; {['Simulation Run Start (', convertTimestampToString(now), ')']}];
                        
            setString(statusOutputTextHandle, baseString);
            
            for i=1:numSlices
                setString(statusOutputTextHandle, [baseString; {['  Slice ', num2str(i), '/', num2str(numSlices)]}]);
                drawnow;
                
                newDir = ['Slice ', num2str(i)];
                mkdir(savePath, newDir);
                sliceSavePath = makePath(savePath, newDir);
                
                slicePosition = slices(i);
                
                sliceData = simulation.runScanSimulationForSlice(axesHandle, slicePosition, displaySlices, displayAngles, displayPerAnglePosition, displayDetectorRaster, displayDetectorValues, displayDetectorRayTrace, detectorImageHandle, statusOutputTextHandle, sliceSavePath);
                
                data{i} = SliceData(sliceData, slicePosition);
                
            end   
            
            setString(statusOutputTextHandle, [baseString; {['Simulation Run Complete (', convertTimestampToString(now), ')']}]);
        end
        
        function sliceData = runScanSimulationForSlice(simulation, axesHandle, slicePosition, displaySlices, displayAngles, displayPerAnglePosition, displayDetectorRaster, displayDetectorValues, displayDetectorRayTrace, detectorImageHandle, statusOutputTextHandle, sliceSavePath)
            angles = simulation.scan.getScanAnglesInDegrees();
            
            numAngles = length(angles);
            
            sliceData = cell(numAngles, 1);
            
            if displaySlices
                plotHandles = simulation.plotSlice(axesHandle, slicePosition);
                
                pause(0.000001);
            end
            
            baseString = getString(statusOutputTextHandle);
            
            for i=1:numAngles
                setString(statusOutputTextHandle, [baseString; {['  Angle ', num2str(i), '/', num2str(numAngles)]}]);
                drawnow;
                
                angle = angles(i); 
                
                newDir = ['Angle ', num2str(angle)];
                mkdir(sliceSavePath, newDir);
                angleSavePath = makePath(sliceSavePath, newDir);
                               
                
                angleData = simulation.runScanSimulationForAngle(axesHandle, slicePosition, angle, displayAngles, displayPerAnglePosition, displayDetectorRaster, displayDetectorValues, displayDetectorRayTrace, detectorImageHandle, statusOutputTextHandle, angleSavePath);
                                
                sliceData{i} = AngleData(angleData, angle);
            end
            
            if displaySlices
                deleteHandles(plotHandles);
            end
        end
        
        function angleData = runScanSimulationForAngle(simulation, axesHandle, slicePosition, angle, displayAngles, displayPerAnglePosition, displayDetectorRaster, displayDetectorValues, displayDetectorRayTrace, detectorImageHandle, statusOutputTextHandle, angleSavePath)
            perAngleTranslationDimensions = simulation.scan.perAngleTranslationDimensions;
            
            xyNumSteps = perAngleTranslationDimensions(1);
            zNumSteps = perAngleTranslationDimensions(2);
            
            angleData = cell(zNumSteps, xyNumSteps);
            
            if displayAngles
                plotHandles = simulation.plotAngle(axesHandle, slicePosition, angle);
                
                pause(0.000001);
            end
            
            baseString = getString(statusOutputTextHandle);
            
            totalNumStepStr = num2str(zNumSteps*xyNumSteps);
            
            for zStep=1:zNumSteps
                for xyStep=1:xyNumSteps
                    curNumStepStr = num2str(((zStep-1)*zNumSteps) + xyStep);
                    setString(statusOutputTextHandle, [baseString; {['  Position ', curNumStepStr, '/', totalNumStepStr]}]);
                    drawnow;
                    
                    newDir = ['Position (', num2str(zStep), ',', num2str(xyStep), ')'];
                    mkdir(angleSavePath, newDir);
                    positionSavePath = makePath(angleSavePath, newDir);
                    
                    [perAngleXYInM, perAngleZInM] = simulation.scan.getPerAnglePositionInM(xyStep, zStep);
                    
                    [positionData, attenuationCoords, attenuationDistances, detectorCoords, sourceStartBoxCoords, sourceEndBoxCoords]...
                        = simulation.runScanSimulationForPerAnglePosition(...
                        axesHandle,...
                        slicePosition,...
                        angle,...
                        perAngleXYInM,...
                        perAngleZInM,...
                        displayPerAnglePosition,...
                        displayDetectorRaster,...
                        displayDetectorValues,...
                        displayDetectorRayTrace,...
                        detectorImageHandle,...
                        statusOutputTextHandle,...
                        positionSavePath);
                    
                    positionDataType = PositionData(...
                        positionData,...
                        attenuationCoords,...
                        attenuationDistances,...
                        detectorCoords,...
                        sourceStartBoxCoords,...
                        sourceEndBoxCoords);
                                           
                    positionDataType.saveBigData(positionSavePath);
                    
                    angleData{zStep, xyStep} = positionDataType.clearBeforeSave();                    
                end
            end
            
            if displayAngles
                deleteHandles(plotHandles);
            end
        end
        
        function [positionData, attenuationCoords, attenuationDistances, detectorCoords, sourceStartBoxCoords, sourceEndBoxCoords]...
                = runScanSimulationForPerAnglePosition(simulation, axesHandle, slicePosition, angle, perAngleXY, perAngleZ, displayPerAnglePosition, displayDetectorRaster, displayDetectorValues, displayDetectorRayTrace, detectorImageHandle, statusOutputTextHandle, positionSavePath)
            diameter = [];
            
            [...
                sourceStartBoxCoords,...
                sourceEndBoxCoords,...
                sourceDirectionUnitVector,...
                perAngleShiftUsed] = ...
                    simulation.source.getSourcePosition(...
                slicePosition,...
                angle,...
                perAngleXY,...
                perAngleZ,...
                diameter);
            
            detectorPosition = simulation.detector.getDetectorPosition(slicePosition, angle);
            
            xyNumDetectors = simulation.detector.wholeDetectorDimensions(1);
            zNumDetectors = simulation.detector.wholeDetectorDimensions(2);
            
            positionData = zeros(zNumDetectors, xyNumDetectors);
            attenuationCoords = cell(zNumDetectors, xyNumDetectors);
            attenuationDistances = cell(zNumDetectors, xyNumDetectors);
            detectorCoords = cell(zNumDetectors, xyNumDetectors);
                        
            if displayPerAnglePosition 
                plotHandles = simulation.plotPerAnglePosition(axesHandle, slicePosition, angle, perAngleXY, perAngleZ, sourceStartBoxCoords, sourceEndBoxCoords);
                
                pause(0.000001);
            end
            
            if displayDetectorRaster
                rasterPlotHandles = {};
            end
            
            baseString = getString(statusOutputTextHandle);
            
            totalNumStepStr = num2str(zNumDetectors*xyNumDetectors);
            
            [xCoords, yCoords, zCoords] = getAllDetectorCoords(simulation.detector, slicePosition, angle, perAngleXY, perAngleZ);

            for zDetector=1:zNumDetectors
                for xyDetector=1:xyNumDetectors                    
                    curNumStepStr = num2str(((zDetector-1)*zNumDetectors) + xyDetector);
                    setString(statusOutputTextHandle, [baseString; {['  Detector ', curNumStepStr, '/', totalNumStepStr]}]);
                    drawnow;
                    
                    newDir = ['Detector (', num2str(zDetector), ',', num2str(xyDetector), ')'];
                    mkdir(positionSavePath, newDir);
                    
                    clockwisePosZ = [xCoords(zDetector,xyDetector), yCoords(zDetector,xyDetector), zCoords(zDetector,xyDetector)];
                    clockwiseNegZ = [xCoords(zDetector+1,xyDetector), yCoords(zDetector+1,xyDetector), zCoords(zDetector+1,xyDetector)];
                    counterClockwisePosZ = [xCoords(zDetector,xyDetector+1), yCoords(zDetector,xyDetector+1), zCoords(zDetector,xyDetector+1)];
                    counterClockwiseNegZ = [xCoords(zDetector+1,xyDetector+1), yCoords(zDetector+1,xyDetector+1), zCoords(zDetector+1,xyDetector+1)];
                    
                    detectorCornerCoords = [clockwisePosZ; clockwiseNegZ; counterClockwisePosZ; counterClockwiseNegZ];
                    
                    if displayDetectorRaster
                        handles = simulation.plotDetectorRaster(axesHandle, detectorCornerCoords);
                        
                        rasterPlotHandles = [rasterPlotHandles, handles];
                        
                        pause(0.000001);
                    end
                    
                    [detectorData, attenuationCoordsForDetector, attenuationDistancesForDetector]...
                        = simulation.runScanSimulationForDetector(...
                        axesHandle,...
                        sourceStartBoxCoords,...
                        sourceEndBoxCoords,...
                        sourceDirectionUnitVector,...
                        detectorCornerCoords,...
                        displayDetectorRayTrace,...
                        statusOutputTextHandle);
                                                         
                    positionData(zDetector, xyDetector) = detectorData;                    
                    attenuationCoords{zDetector, xyDetector} = attenuationCoordsForDetector;
                    attenuationDistances{zDetector, xyDetector} = attenuationDistancesForDetector;
                    detectorCoords{zDetector, xyDetector} = detectorCornerCoords;
                    
                    if displayDetectorValues
                        % update image data
                        set(detectorImageHandle, 'CData', positionData);
                    end
                end
            end
            
            if displayPerAnglePosition
                deleteHandles(plotHandles);
            end
            
            if displayDetectorRaster
                deleteHandles(rasterPlotHandles);
            end
        end
        
        function [detectorData, attenuationCoords, attenuationDistances] = runScanSimulationForDetector(...
                simulation,...
                axesHandle,...
                sourceStartBoxCoords,...
                sourceEndBoxCoords,...
                sourceDirectionUnitVector,...
                detectorCornerCoords,...
                displayDetectorRayTrace,...
                statusOutputTextHandle)
            
            scatteringNoiseLevel = simulation.scatteringNoiseLevel;
            detectorNoiseLevel = simulation.detectorNoiseLevel;
            partialPixel = simulation.partialPixelModelling;
            partialPixelResolution = simulation.partialPixelResolution;
            
            beamCharacterization = simulation.scan.beamCharacterization;
            
            phantomData = simulation.phantom.data;
            voxelDimsInM = simulation.phantom.getVoxelDimensionsInM();
            phantomLocationInM = simulation.phantom.getLocationInM();
            
            [detectorData, attenuationCoords, attenuationDistances] = ...
                runBeamTrace(...
                axesHandle,...
                sourceStartBoxCoords,...
                sourceEndBoxCoords,...
                sourceDirectionUnitVector,...
                detectorCornerCoords,...
                phantomData,...
                voxelDimsInM,...
                phantomLocationInM,...
                beamCharacterization,...
                scatteringNoiseLevel,...
                detectorNoiseLevel,...
                partialPixel,...
                partialPixelResolution,...
                displayDetectorRayTrace);
        end
        
    end
    
end

