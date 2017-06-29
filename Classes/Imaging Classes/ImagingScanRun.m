classdef ImagingScanRun
    % ImagingScanRun
    % Holds data from when the imaging scan in question was run
    %
    % FIELDS:
    % *imagingScan
    % See ImagingScan class and related subclasses. 
    %
    % *scanTimestamp
    % Unix timestamp of when the real-world scan was done
    %
    % *importTimestamp
    % Unix timestamp of when the scan was imported into Gyrfalcon
    %
    % **FURTHER SCANNER SPECIFIC FIELDS IN ImagingScan SUBCLASSES
    
    
    
    properties
        imagingScan
        
        scanTimestamp
        importTimestamp
        
        notes
    end
    
    methods
        function scanRun = ImagingScanRun(scanRun)
            
        end
        
        function run = importDataSet(run, imagingScan, scanTimestamp, notes)
            run.imagingScan = imagingScan; %everything should already be imported
            run.scanTimestamp = scanTimestamp;
            run.importTimestamp = now;
            run.notes = notes;
        end
        
        function run = loadData(run, basePath) %use given basePath in case files are moved around
            sim = run.simulation;
            
            numSlices = length(sim.scan.slices);
                        
            sliceData = cell(1, numSlices);
            
            for i=1:numSlices
                sliceFolder = makeSliceFolderName(i);
                
                path = makePath(basePath, sliceFolder);
                
                data = SliceData;
                
                data = data.loadData(path, sim);
                
                sliceData{i} = data;
            end
            
            run.sliceData = sliceData;
            
        end
        
        function run = setDefaultValues(run)
            run.simulation = [];
            run.performanceType = SimulationRunPerformanceTypes.high;
            run.sliceData = [];
            
            run.startTimestamp = [];
            run.endTimestamp = [];
            
            run.computerInfo = ComputerInfo();
            run.versionUsed = Constants.version;
            
            run.notes = '';
            run.savePath = '';
            run.saveFileName = '';
            
            run.useMexCode = true;
        end
        
        function run = createFromGUI(run, app)
        end 
        
        function [sliceNames, angleNames, positionNames, positionFileNames] = getFolderNames(run)
            numSlices = length(run.simulation.scan.slices);
            
            angles = run.simulation.scan.getScanAnglesInDegrees();
            numAngles = length(angles);
            
            positionDims = run.simulation.scan.perAngleTranslationDimensions;
            
            xyNumSteps = positionDims(1);
            zNumSteps = positionDims(2);
            
            numSteps = xyNumSteps*zNumSteps;
            
            sliceNames = cell(numSlices,1);
            angleNames = cell(numAngles,1);
            positionNames = cell(numSteps,1);
            positionFileNames = cell(numSteps,1);
            
            for i=1:numSlices
                sliceNames{i} = makeSliceFolderName(i);
            end
            
            for i=1:numAngles
                angleNames{i} = makeAngleFolderName(angles(i));
            end
            
            isPositionMosiac = run.simulation.isScanMultiplePositionMosiac();
            
            if isPositionMosiac
                positionNames = {makePositionName(0,0,isPositionMosiac)}; %single entry
                positionFileNames = {makePositionFileName(positionNames{1})};
            else
                for i=1:zNumSteps
                    for j=1:xyNumSteps
                        index = (i-1)*zNumSteps + j;
                        
                        positionNames{index} = makePositionName(j,i,isPositionMosiac);
                        positionFileNames{index} = makePositionFileName(positionNames{index});
                    end
                end                
            end
            
        end
        
        function image = loadImageForScanSimulationViewer(run, app)
            % get selected folders/files
            sliceFolder = app.SimulationViewerSliceListBox.Value;
            angleFolder = app.SimulationViewerScanAngleListBox.Value;
            positionDetectorDataFilename = app.SimulationViewerPerAngleTranslationPositionListBox.Value; %ItemData used to the filename
            
            loadPath = makePath(run.savePath,...
                sliceFolder,...
                angleFolder,...
                positionDetectorDataFilename);
            
            fileData = load(loadPath);
            
            image = fileData.(Constants.Detector_Data_Var_Name);
        end
                  
        function run = createSaveDir(run)
            path = run.savePath;
            dirName = removeFileExtension(run.saveFileName);
            
            mkdir(path,dirName);
            
            run.savePath = makePath(path,dirName);
        end
        
    end
    
end

