classdef Simulation
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
        
        savePath
        saveFileName
    end
    
    methods
        function simulation = Simulation(phantom, detector, source, scan, scatteringNoiseLevel, detectorNoiseLevel, partialPixelModelling)
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
            end
        end
        
        function [] = plot(simulation, handles)
            axesHandle = handles.axesHandle;
            
            axes(axesHandle);
            
            redrawAxes(axesHandle);
            
            simulation.phantom.plot(axesHandle);
            
            slicePosition = [];
            angle = [];
            
            simulation.detector.plot(axesHandle, slicePosition, angle);
            simulation.source.plot(axesHandle);
            simulation.scan.plot(simulation.source, axesHandle);
                       
        end
        
        function plotHandles = plotSlice(simulation, axesHandle, slicePosition)
            axes(axesHandle);
            hold on
            
            locationInM = simulation.source.getLocationInM();
            
            x = 0;
            y = 0; % at origin
            r = norm([locationInM(1), locationInM(2)]); % found above
            ang1 = 0;
            ang2 = 360; % to make circle
            
            edgeColour = Constants.Slice_Colour;
            faceColour = 'none';
            lineStyle = '--';
            lineWidth = [];
            
            handle = circleOrArcPatch(x, y, slicePosition, r, ang1, ang2, edgeColour, faceColour, lineStyle, lineWidth);
            
            plotHandles = {handle};
        end
        
        function plotHandles = plotAngle(simulation, axesHandles, slicePosition, angle)
            plotHandles = simulation.detector.plot(axesHandles, slicePosition, angle);
        end
        
        function plotHandles = plotPerAnglePosition(simulation, axesHandle, slicePosition, angle, sourcePosition, sourceDirectionUnitVector)
            plotHandles = {};
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
            
            plotHandles = patch(x,y,z,'w');
            
            plotHandles = {plotHandles};
        end
        
        function handles = setGUIFromSimulation(simulation, handles)
            
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
                       
            % set hidden handles
            handles.simulationSavePath = simulation.savePath;
            handles.simulationSaveFileName = simulation.saveFileName;
        end
        
        function simulation = createFromGUI(simulation, handles)
            % PHANTOM
            
            phant = Phantom();
            
            simulation.phantom = phant.createFromGUI(handles);
            
            % DETECTOR
            
            detector = Detector();
            
            simulation.detector = detector.createFromGUI(handles);
            
            % SOURCE
            
            source = Source();
            
            simulation.source = source.createFromGUI(handles);
            
            % SCAN
            
            scan = Scan();
            
            simulation.scan = scan.createFromGUI(handles);
            
            % SIMULATION
            
            simulation.scatteringNoiseLevel = getDoubleFromHandle(handles.simulationScatteringNoiseLevelEdit);
            simulation.detectorNoiseLevel = getDoubleFromHandle(handles.simulationDetectorNoiseLevelEdit);
            simulation.partialPixelModelling = get(handles.simulationPartialPixelModellingCheckbox, 'Value');
            
            
            simulation.savePath = handles.simulationSavePath;
            simulation.saveFileName = handles.simulationSaveFileName;
        end
        
        function data = runScanSimulation(simulation, axesHandle, displaySlices, displayAngles, displayPerAnglePosition, displayDetectorRaster)
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
            
            for i=1:numSlices
                slicePosition = slices(i);
                
                sliceData = simulation.runScanSimulationForSlice(axesHandle, slicePosition, displaySlices, displayAngles, displayPerAnglePosition, displayDetectorRaster);
                
                data{i} = sliceData;
            end            
        end
        
        function sliceData = runScanSimulationForSlice(simulation, axesHandle, slicePosition, displaySlices, displayAngles, displayPerAnglePosition, displayDetectorRaster)
            angles = simulation.scan.getScanAnglesInDegrees();
            
            numAngles = length(angles);
            
            sliceData = cell(numAngles, 1);
            
            if displaySlices
                plotHandles = simulation.plotSlice(axesHandle, slicePosition);
            end
            
            for i=1:numAngles
                angle = angles(i);                
                
                angleData = simulation.runScanSimulationForAngle(axesHandle, slicePosition, angle, displayAngles, displayPerAnglePosition, displayDetectorRaster);
                                
                sliceData{i} = angleData;
            end
            
            if displaySlices
                deleteHandles(plotHandles);
            end
        end
        
        function angleData = runScanSimulationForAngle(simulation, axesHandle, slicePosition, angle, displayAngles, displayPerAnglePosition, displayDetectorRaster)
            perAngleTranslationDimensions = simulation.scan.perAngleTranslationDimensions;
            
            xyNumSteps = perAngleTranslationDimensions(1);
            zNumSteps = perAngleTranslationDimensions(2);
            
            angleData = cell(zNumSteps, xyNumSteps);
            
            if displayAngles
                plotHandles = simulation.plotAngle(axesHandle, slicePosition, angle);
            end
            
            for zStep=1:zNumSteps
                for xyStep=1:xyNumSteps
                    [perAngleXYInM, perAngleZInM] = simulation.scan.getPerAnglePositionInM(xyStep, zStep);
                    
                    positionData = simulation.runScanSimulationForPerAnglePosition(axesHandle, slicePosition, angle, perAngleXYInM, perAngleZInM, displayPerAnglePosition, displayDetectorRaster);
                    
                    angleData{zStep, xyStep} = positionData;
                end
            end
            
            if displayAngles
                deleteHandles(plotHandles);
            end
        end
        
        function positionData = runScanSimulationForPerAnglePosition(simulation, axesHandle, slicePosition, angle, perAngleXY, perAngleZ, displayPerAnglePosition, displayDetectorRaster)
            [sourcePosition, sourceDirectionUnitVector] = simulation.source.getSourcePosition(slicePosition, angle, perAngleXY, perAngleZ);
            
            detectorPosition = simulation.detector.getDetectorPosition(slicePosition, angle);
            
            xyNumDetectors = simulation.detector.wholeDetectorDimensions(1);
            zNumDetectors = simulation.detector.wholeDetectorDimensions(2);
            
            positionData = zeros(zNumDetectors, xyNumDetectors);
                        
            if displayPerAnglePosition
                plotHandles = simulation.plotPerAnglePosition(axesHandle, slicePosition, angle, sourcePosition, sourceDirectionUnitVector);
            end
            
            if displayDetectorRaster
                rasterPlotHandles = {};
            end
            
            for zDetector=1:zNumDetectors
                for xyDetector=1:xyNumDetectors
                    [clockwisePosZ,...
                     clockwiseNegZ,...
                     counterClockwisePosZ,...
                     counterClockwiseNegZ]...
                     = simulation.detector.getDetectorCoords(detectorPosition, xyDetector, zDetector);
                    
                    detectorCornerCoords = [clockwisePosZ; clockwiseNegZ; counterClockwisePosZ; counterClockwiseNegZ];
                    
                    if displayDetectorRaster
                        handles = simulation.plotDetectorRaster(axesHandle, detectorCornerCoords);
                        
                        rasterPlotHandles = [rasterPlotHandles, handles];
                        
                        pause(0.001);
                    end
                    
                    detectorData = simulation.runScanSimulationForDetector(sourcePosition, sourceDirectionUnitVector, detectorCornerCoords);
                                                         
                    positionData(zDetector, xyDetector) = detectorData;
                end
            end
            
            if displayPerAnglePosition
                deleteHandles(plotHandles);
            end
            
            if displayDetectorRaster
                deleteHandles(rasterPlotHandles);
            end
        end
        
        function detectorData = runScanSimulationForDetector(simulation, sourcePosition, sourceDirectionUnitVector, detectorCornerCoords)
            scatteringNoiseLevel = simulation.scatteringNoiseLevel;
            detectorNoiseLevel = simulation.detectorNoiseLevel;
            partialPixel = simulation.partialPixelModelling;
            
            beamCharacterization = simulation.scan.beamCharacterization;
            
            phantomData = simulation.phantom.data;
            voxelDimsInM = simulation.phantom.getVoxelDimensionsInM();
            phantomLocationInM = simulation.phantom.getLocationInM();
            
            detectorData = runBeamTrace(...
                sourcePosition,...
                sourceDirectionUnitVector,...
                detectorCornerCoords,...
                phantomData,...
                voxelDimsInM,...
                phantomLocationInM,...
                beamCharacterization,...
                scatteringNoiseLevel,...
                detectorNoiseLevel,...
                partialPixel);
        end
        
    end
    
end

