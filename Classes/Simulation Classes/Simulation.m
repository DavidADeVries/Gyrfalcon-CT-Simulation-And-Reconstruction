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
        
        function bool = isScanMultiplePositionMosiac(simulation)
            % in order for the scan to be a "position mosiac", it must have 
            % a detector that moves with the source and be one of:
            % 1) Scan along the xy ONLY with a beam extending ONLY in the z
            % 2) Scan along the z ONLY with a beam extending ONLY in the xy
            % 3) Scanning in the xy and z but ONLY with a 1x1 detector
            
            scan = simulation.scan;
            detector = simulation.detector;
            
            detectorMoves = detector.movesWithScanAngle && detector.movesWithPerAngleTranslation;
            
            detectorDims = detector.wholeDetectorDimensions;
            translationDims = scan.perAngleTranslationDimensions;
            
            isCase1 = translationDims(2) == 1 && detectorDims(1) == 1;
            isCase2 = translationDims(1) == 1 && detectorDims(2) == 1;
            isCase3 = all(detectorDims == 1);
            
            bool = detectorMoves && (isCase1 || isCase2 || isCase3);
        end
        
        function name = defaultName(simulation)
            name = [Constants.Default_Simulation_Name, Constants.Matlab_File_Extension];
        end
                
        function name = displayName(simulation)
            name = 'Simulation';
        end
        
        function [] = plot(simulation, app)
            axesHandle = app.axesHandle;
            
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
        
        function app = setGUI(simulation, app)
            
            % PHANTOM
            
            app = simulation.phantom.setGUI(app);
            
            % DETECTOR
            
            app = simulation.detector.setGUI(app);
            
            % SOURCE
            
            app = simulation.source.setGUI(app);
            
            % SCAN
            
            app = simulation.scan.setGUI(app);
            
            % SIMULATION
            
            app.SimulationScatteringNoiseLevelEditField.Value = simulation.scatteringNoiseLevel;
            app.SimulationDetectorNoiseLevelEditField.Value = simulation.detectorNoiseLevel;
            app.SimulationEnablePartialPixelModellingCheckBox.Value = simulation.partialPixelModelling;
            app.SimulationPartialPixelResolutionEditField.Value = simulation.partialPixelResolution;
                        
            app.SimulationSaveInSeparateFileCheckBox.Value = simulation.saveInSeparateFile;
            
            if ~simulation.saveInSeparateFile
                app.SimulationFilePathLabel.Text = 'Tied to Workspace';
            elseif isempty(simulation.saveFileName)
                app.SimulationFilePathLabel.Text = 'Not Saved';
            else
                app.SimulationFilePathLabel.Text = simulation.saveFileName;
            end
            
            % SIMULATION RUN FIELDS
            
        end
        
        function simulation = createFromGUI(simulation, app)
            % PHANTOM
                        
            simulation.phantom = simulation.phantom.createFromGUI(app);
            
            % DETECTOR
                        
            simulation.detector = simulation.detector.createFromGUI(app);
            
            % SOURCE
                        
            simulation.source = simulation.source.createFromGUI(app);
            
            % SCAN
                        
            simulation.scan = simulation.scan.createFromGUI(app);
            
            % SIMULATION
            
            simulation.scatteringNoiseLevel = app.SimulationScatteringNoiseLevelEditField.Value;
            simulation.detectorNoiseLevel = app.SimulationDetectorNoiseLevelEditField.Value;
            simulation.partialPixelModelling = app.SimulationEnablePartialPixelModellingCheckBox.Value;
            simulation.partialPixelResolution = app.SimulationPartialPixelResolutionEditField.Value;
            
            simulation.saveInSeparateFile = app.SimulationSaveInSeparateFileCheckBox.Value;
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
        
        function [saved, simulationForGUI, simulationForParent, simulationForSaving] = saveChildrenObjects(simulation, defaultSavePath)
            simulationForGUI = simulation;
            simulationForParent = simulation;
            simulationForSaving = simulation;
            
            if ~isempty(simulation.phantom)
                [saved, phantomForGUI, phantomForParent, ~] = simulation.phantom.saveAsIfChanged(defaultSavePath);
                
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
                    [saved, sourceForGUI, sourceForParent, ~] = simulation.source.saveAsIfChanged(defaultSavePath);
                    
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
                    [saved, detectorForGUI, detectorForParent, ~] = simulation.detector.saveAsIfChanged(defaultSavePath);
                    
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
                    [saved, scanForGUI, scanForParent, ~] = simulation.scan.saveAsIfChanged(defaultSavePath);
                    
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
        
        function simulation = loadFields(simulation, defaultLoadPath)
            simulation.phantom = simulation.phantom.load(defaultLoadPath);
            simulation.detector = simulation.detector.load(defaultLoadPath);
            simulation.source = simulation.source.load(defaultLoadPath);
            simulation.scan = simulation.scan.load(defaultLoadPath);
        end    
        
        function simulation = calibrateAndSetPhantomData(simulation)
            phantomDataInHU = simulation.phantom.dataSet.data;
            
            beam = simulation.scan.beamCharacterization;
            
            beam = beam.calibrateAndSetPhantomData(phantomDataInHU);
            
            simulation.scan.beamCharacterization = beam;
        end
        
        function [scanGeometry, errorMsg] = findScanGeometry(simulation)
            [scanGeometry, errorMsg] = boolLogicForFindScanGeometry(simulation);
        end
        
        function simulationRun = runScanSimulation(simulation, simulationRun, axesHandle, displaySlices, displayAngles, displayPerAnglePosition, displayDetectorRaster, displayDetectorValues, displayDetectorRayTrace, app)
            savePath = simulationRun.savePath;
            
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
            
            
            simulationRun = simulationRun.startRun();
            
            newString = ['Simulation Run Start (', convertTimestampToString(now), ')'];
            newLine = true;
            
            app = updateStatusOutput(app, newString, newLine);
            
            app.StatusOutputLamp.Color = [1 1 0]; % yellow
            
            for i=1:numSlices
                newString = ['  Slice ', num2str(i), '/', num2str(numSlices)];
                newLine = true;
                
                app = updateStatusOutput(app, newString, newLine);
                
                newDir = [Constants.Slice_Folder, ' ', num2str(i)];
                mkdir(savePath, newDir);
                sliceSavePath = makePath(savePath, newDir);
                
                slicePosition = slices(i);
                
                sliceData = simulation.runScanSimulationForSlice(axesHandle, slicePosition, displaySlices, displayAngles, displayPerAnglePosition, displayDetectorRaster, displayDetectorValues, displayDetectorRayTrace, detectorImageHandle, app, sliceSavePath);
                
                app = removeLastLineOfStatusOutput(app);
                
                data{i} = SliceData(sliceData, slicePosition);
                
            end
              
            simulationRun = simulationRun.endRun();
            
            newString = ['Simulation Run Complete (', convertTimestampToString(now), ')'];
            newLine = true;
            
            app = updateStatusOutput(app, newString, newLine);
            
            app.StatusOutputLamp.Color = [0 1 0]; % green
        end
        
        function string = getScanGeometryString(simulation, scanGeometry, errorMsg)
            if isempty(scanGeometry)
                string = errorMsg;
            else
                numSlices = num2str(length(simulation.scan.slices));
                numAngles = num2str(length(simulation.scan.scanAngles));
                
                angleString = [numAngles, ' Scan Angles [°] (', ')'];
                slicesString = [numSlices, ' Slices [mm] (', ')'];
                
                detectorDims = simulation.detector.wholeDetectorDimensions;
                
                detectorSizeString = ['Detector Size: ', num2str(detectorDims(1)), 'x', num2str(detectorDims(2))];
                
                perAngleDims = simulation.scan.perAngleTranslationResolution;
                
                perAngleString = ['Per Angle Translation Steps: ', num2str(perAngleDims(1)), 'x', num2str(perAngleDims(2))];
                
                string = {...
                    scanGeometry.displayString,...
                    scanGeometry.shortDescriptionString,...
                    angleString,...
                    slicesString,...
                    detectorSizeString,...
                    perAngleString};
            end
        end
        
        function sliceData = runScanSimulationForSlice(simulation, axesHandle, slicePosition, displaySlices, displayAngles, displayPerAnglePosition, displayDetectorRaster, displayDetectorValues, displayDetectorRayTrace, detectorImageHandle, app, sliceSavePath)
            angles = simulation.scan.getScanAnglesInDegrees();
            
            numAngles = length(angles);
            
            sliceData = cell(numAngles, 1);
            
            if displaySlices
                plotHandles = simulation.plotSlice(axesHandle, slicePosition);
                
                pause(0.000001);
            end
                        
            for i=1:numAngles
                newString = ['  Angle ', num2str(i), '/', num2str(numAngles)];
                newLine = true;
                
                app = updateStatusOutput(app, newString, newLine);
                
                angle = angles(i); 
                
                newDir = [Constants.Angle_Folder, ' ', num2str(angle)];
                mkdir(sliceSavePath, newDir);
                angleSavePath = makePath(sliceSavePath, newDir);
                               
                
                angleData = simulation.runScanSimulationForAngle(axesHandle, slicePosition, angle, displayAngles, displayPerAnglePosition, displayDetectorRaster, displayDetectorValues, displayDetectorRayTrace, detectorImageHandle, app, angleSavePath);
                                
                app = removeLastLineOfStatusOutput(app);
                
                sliceData{i} = AngleData(angleData, angle);
            end
            
            if displaySlices
                deleteHandles(plotHandles);
            end
        end
        
        function angleData = runScanSimulationForAngle(simulation, axesHandle, slicePosition, angle, displayAngles, displayPerAnglePosition, displayDetectorRaster, displayDetectorValues, displayDetectorRayTrace, detectorImageHandle, app, angleSavePath)
            perAngleTranslationDimensions = simulation.scan.perAngleTranslationDimensions;
            
            xyNumSteps = perAngleTranslationDimensions(1);
            zNumSteps = perAngleTranslationDimensions(2);
            
            angleData = cell(zNumSteps, xyNumSteps);
            
            if displayAngles
                plotHandles = simulation.plotAngle(axesHandle, slicePosition, angle);
                
                pause(0.000001);
            end
                        
            totalNumStepStr = num2str(zNumSteps*xyNumSteps);
            
            for zStep=1:zNumSteps
                for xyStep=1:xyNumSteps
                    curNumStepStr = num2str(((zStep-1)*zNumSteps) + xyStep);
                    newString = ['  Position ', curNumStepStr, '/', totalNumStepStr];
                    newLine = true;
                    
                    app = updateStatusOutput(app, newString, newLine);
                    
                    newDir = [Constants.Position_Folder, ' (', num2str(zStep), ',', num2str(xyStep), ')'];
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
                        app,...
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
                    
                    app = removeLastLineOfStatusOutput(app);
                end
            end
            
            if displayAngles
                deleteHandles(plotHandles);
            end
        end
        
        function [positionData, attenuationCoords, attenuationDistances, detectorCoords, sourceStartBoxCoords, sourceEndBoxCoords]...
                = runScanSimulationForPerAnglePosition(simulation, axesHandle, slicePosition, angle, perAngleXY, perAngleZ, displayPerAnglePosition, displayDetectorRaster, displayDetectorValues, displayDetectorRayTrace, detectorImageHandle, app, positionSavePath)
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
                        
            totalNumStepStr = num2str(zNumDetectors*xyNumDetectors);
            
            [xCoords, yCoords, zCoords] = getAllDetectorCoords(simulation.detector, slicePosition, angle, perAngleXY, perAngleZ);

            for zDetector=1:zNumDetectors
                for xyDetector=1:xyNumDetectors                    
                    curNumStepStr = num2str(((zDetector-1)*zNumDetectors) + xyDetector);
                    newString = ['  Detector ', curNumStepStr, '/', totalNumStepStr];
                    newLine = true;
                    
                    app = updateStatusOutput(app, newString, newLine);
                    
%                     newDir = [Constants.Detector_Folder, ' (', num2str(zDetector), ',', num2str(xyDetector), ')'];
%                     mkdir(positionSavePath, newDir);
                    
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
                        app);
                                                         
                    positionData(zDetector, xyDetector) = detectorData;                    
                    attenuationCoords{zDetector, xyDetector} = attenuationCoordsForDetector;
                    attenuationDistances{zDetector, xyDetector} = attenuationDistancesForDetector;
                    detectorCoords{zDetector, xyDetector} = detectorCornerCoords;
                    
                    if displayDetectorValues
                        % update image data
                        set(detectorImageHandle, 'CData', positionData);
                    end
                    
                    app = removeLastLineOfStatusOutput(app);
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
                app)
            
            scatteringNoiseLevel = simulation.scatteringNoiseLevel;
            detectorNoiseLevel = simulation.detectorNoiseLevel;
            partialPixel = simulation.partialPixelModelling;
            partialPixelResolution = simulation.partialPixelResolution;
            
            beamCharacterization = simulation.scan.beamCharacterization;
            
            phantomData = simulation.phantom.dataSet.data;
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
        
        function simulationRun = runScanSimulationHighPerformanceOnCPU(simulation, simulationRun, app)
            % SET-UP
            newString = ['Simulation Run Start (', convertTimestampToString(now), ')'];
            newLine = true;
            
            app = updateStatusOutput(app, newString, newLine);
            
            app.StatusOutputLamp.Color = [1 1 0]; % yellow
             
            
            numCPUs = simulationRun.computerInfo.numCoresUsed;
            
            runIsParallel = numCPUs > 1;
            
            % ANY SET-UP REQUIRED
            
            if runIsParallel % START PARALLEL WORKER POOL
                [app, cpuPool] = startCPUPool(app, numCPUs);
            end
            
            
            % START THE TIMER!
            simulationRun = simulationRun.startRun();
            
            % GATHER INFORMATION FOR ALL BEAM TRACES
            slices = simulation.scan.getSlicesInM();            
            numSlices = length(slices);
            
            angles = simulation.scan.getScanAnglesInDegrees();
            numAngles = length(angles);
            
            perAngleTranslationDimensions = simulation.scan.perAngleTranslationDimensions;
            
            xyNumSteps = perAngleTranslationDimensions(1);
            zNumSteps = perAngleTranslationDimensions(2);
            totalNumSteps = zNumSteps*xyNumSteps;
            
            xyNumDetectors = simulation.detector.wholeDetectorDimensions(1);
            zNumDetectors = simulation.detector.wholeDetectorDimensions(2);
            totalNumDetectors = xyNumDetectors * zNumDetectors;
            
            numBeamTraces = numSlices * numAngles * totalNumSteps * totalNumDetectors;
            
            % FIGURE OUT HOW TO PARALLELIZE
            
            maxNumBeamTraces = 0.75*simulationRun.computerInfo.getMaxArraySize(); % 75% of available memory
            
            optimizeForSlices = true;
            optimizeForAngles = true;
            optimizeForPerAngleTranslation = true;
            optimizeForDetector = true;
            
            if simulation.isScanMultiplePositionMosiac %if true, all detectors AND translations at each angle must be calculated together (since they will be saved together!)
                if totalNumSteps *totalNumDetectors > maxNumBeamTraces
                    error('Not enough memory for a High Performance CPU simulation');
                elseif numAngles * totalNumSteps * totalNumDetectors > maxNumBeamTraces
                    optimizeForSlices = false;
                    optimizeForAngles = false;
                elseif numSlices * numAngles * totalNumSteps * totalNumDetectors > maxNumBeamTraces
                    optimizeForSlices = false;
                end
            else % detector and position calcs are free to be split up
                if totalNumDetectors > maxNumBeamTraces
                    error('Not enough memory for a High Performance CPU simulation');
                elseif totalNumSteps * totalNumDetectors > maxNumBeamTraces
                    optimizeForSlices = false;
                    optimizeForAngles = false;
                    optimizeForPerAngleTranslation = false;
                elseif numAngles * totalNumSteps * totalNumDetectors > maxNumBeamTraces
                    optimizeForSlices = false;
                    optimizeForAngles = false;
                elseif numSlices * numAngles * totalNumSteps * totalNumDetectors > maxNumBeamTraces
                    optimizeForSlices = false;
                end
            end
            
            if runIsParallel && optimizeForSlices
                % everything can be done in one optimized MATLAB computation!
                % while this is all and good, we wouldn't want to have one
                % CPU trying to bash this out (even though it's optimized,
                % it still takes time!), if the user has given use multiple CPUs
                % to use
                if numSlices >= numCPUs % parallelize slices
                    optimizeForSlices = false;
                elseif numSlices * numAngles >= numCPUs % parallelize angles and slices
                    optimizeForSlices = false;
                    optimizeForAngles = false;
                else % parallelize angles, slices, and per angle translation
                    optimizeForSlices = false;
                    optimizeForAngles = false;
                    
                    if ~simulation.isScanMultiplePositionMosiac()
                        optimizeForPerAngleTranslation = false; % only split these up if allowed
                    end
                end
            end
            
            % CREATE FOLDERS FOR SAVING
            % parallelizing folder creation doesn't speed-up
            
            createFoldersForData(...
                simulationRun.savePath,...
                angles,...
                numSlices, numAngles);

            % RUN BEAM TRACES
            
            if simulation.partialPixelModelling
                runHighPerformancePartialPixelWithCentreOf2DDetectorsOnCPU(...
                    simulation, simulationRun, app, runIsParallel, slices, angles,...
                    numSlices, numAngles, zNumSteps, xyNumSteps, zNumDetectors, xyNumDetectors,...
                    optimizeForSlices, optimizeForAngles, optimizeForPerAngleTranslation, optimizeForDetector);
            else
                error('Invalid High Performance Geometry');
            end
                                    
            % END THE TIMER!
            simulationRun = simulationRun.endRun();
                        
            % TEAR-DOWN  
            if runIsParallel
                app = shutdownCPUPool(app, cpuPool);
            end
                       
            
            % Show finish on Output Status
            newString = ['Simulation Run Complete (', convertTimestampToString(now), ')'];
            newLine = true;
            
            app = updateStatusOutput(app, newString, newLine);
            
            app.StatusOutputLamp.Color = [0 1 0]; % green
            
        end
        
        function simulationRun = runScanSimulationHighPerformanceOnGPU(simulation, simulationRun, app)
            simulationRun = simulationRun.startRun();
            simulationRun = simulationRun.endRun();
        end
        
    end
    
end

% HELPER FUNCTIONS %

function indices = getIndices(index, indexingLevels, useFlags)
    dims = ~useFlags + useFlags.*indexingLevels; % dim of 1 at unused levels
    
    % use fliplr so that detector values will be sequential
    [indices(6), indices(5), indices(4), indices(3), indices(2), indices(1)] = ind2sub(fliplr(dims), index);
end

function [] = writeDetectorDataToDisk(detectorData, savePath, parallelBeamTraceIndices, parallelFlags, indexLevels, angles)
    parallelForDetector = parallelFlags(5) & parallelFlags(6);
    
    numBeamTraces = length(detectorData);
    numPixelsInDetector = indexLevels(5) * indexLevels(6);
    
    if parallelForDetector
        numDetectorImages = numBeamTraces / numPixelsInDetector;
        
        for i=1:numDetectorImages
            detectorImage = detectorData((i-1)*numPixelsInDetector+1:(i)*numPixelsInDetector, 1);
            
            detectorImage = reshape(detectorImage, indexLevels(6), indexLevels(5));
            
            detectorImage = detectorImage';
            
            saveDetectorImage(detectorImage, savePath, parallelBeamTraceIndices((i-1)*numPixelsInDetector+1,:), angles);
        end
    else
        error('No specified action for saving Non-Parallelized Detector Calculation');
    end
end

function [] = saveDetectorImage(detectorData, savePath, indices, angles)
    sliceFolder = makeSliceFolderName(indices(1));
    angleFolder = makeAngleFolderName(angles(indices(2)));
    positionFolder = makePositionFolderName(indices(3), indices(4));
    
    fileName = [Constants.Detector_Data_Filename, Constants.Matlab_File_Extension];
    
    writePath = makePath(savePath, sliceFolder, angleFolder, positionFolder, fileName);
    
    save(writePath, Constants.Detector_Data_Var_Name);
end


function [] = createFoldersForData(writePath, angles, numSlices, numAngles)

for i=1:numSlices
    sliceFolder = makeSliceFolderName(i);
    
    mkdir(writePath, sliceFolder)
    slicePath = makePath(writePath, sliceFolder);
    
    for j=1:numAngles
        angleFolder = makeAngleFolderName(angles(j));
        
        mkdir(slicePath, angleFolder);
    end
end

end