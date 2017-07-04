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
    % *importPath
    % path data was imported from
    %
    % *savePath
    % path where data was saved to
    %
    % *notes
    % any notes about the imaging scan run
    %
    % **FURTHER SCANNER SPECIFIC FIELDS IN ImagingScan SUBCLASSES
    
    
    
    properties
        imagingScan
        
        importTimestamp
        
        importPath
        savePath
        
        notes
    end
    
    methods
        function scanRun = ImagingScanRun()
            
        end
        
        function app = setGUI(run, app)
            if isempty(run.savePath) % not yet set
                app.ImagingScanRunSavePathEditField.Value = 'Not Selected...';
            else
                app.ImagingScanRunSavePathEditField.Value = run.savePath;
            end
            
            if isempty(run.importPath) % not yet set
                app.ImagingScanDataImportPathEditField.Value = 'Not Selected...';
            else
                app.ImagingScanDataImportPathEditField.Value = run.importPath;
            end
            
            % need to be set to run the import
            if isempty(run.savePath) || isempty(run.importPath)
                app.ImportImagingScanDataButton.Enable = 'off';
            else
                app.ImportImagingScanDataButton.Enable = 'on';
            end
            
            app.ImagingScanRunNotesTextArea.Value = run.notes;
            
            % select / set settings tab
            scanClass = class(run.imagingScan);
            
            hideAllImagingScanImportSettingsTabs(app);
            
            if strcmp(scanClass, class(ImagingScanTypes.opticalCT.imagingScanObject))
                app.ImagingScanTypeDropDown.Value = ImagingScanTypes.opticalCT;
                
                app.OpticalCTImportSettingsTab.Parent = app.ImportImagingScanTabGroup;
                
                % set fields
                app.OptCTSettings_DetectorWholeDetectorDimsXYEditField.Value = run.imagingScan.targetDetectorDimensions(1);
                app.OptCTSettings_DetectorWholeDetectorDimsZEditField.Value = run.imagingScan.targetDetectorDimensions(2);
                
                app.OptCtSettings_DetectorPixelDimsXYEditField.Value = run.imagingScan.targetPixelDimensions(1).value;
                app.OptCtSettings_DetectorPixelDimsZEditField.Value = run.imagingScan.targetPixelDimensions(2).value;
                
                app.OptCtSettings_DetectorPixelDimsXYUnitsDropDown.Value = run.imagingScan.targetPixelDimensions(1).units;
                app.OptCtSettings_DetectorPixelDimsXYUnitsDropDown.Value = run.imagingScan.targetPixelDimensions(2).units;
            elseif strcmp(scanClass, class(ImagingScanTypes.xrayCT.imagingScanObject))
                app.ImagingScanTypeDropDown.Value = ImagingScanTypes.xrayCT;
                
                app.XRayCTImportSettingsTab.Parent = app.ImportImagingScanTabGroup;
            end
        end
        
        function run = createFromGUI(run, app)
            run.importPath = app.ImagingScanDataImportPathEditField.Value;
            run.savePath = app.ImagingScanRunSavePathEditField.Value;
            
            run.notes = app.ImagingScanRunNotesTextArea.Value;
            
            run.imagingScan = app.ImagingScanTypeDropDown.Value.imagingScanObject;
        end
        
        function run = importDataSet(run, app)
            run = run.createFromGUI(app);
                
            run.importTimestamp = now;
            
            run.createSaveDirectory();
            
            run.imagingScan = run.imagingScan.importDataSet(app, run.importPath, run.savePath);
        end
        
        function [] = createSaveDirectory(run)
            pathSections = breakUpPath(run.savePath);
            
            folder = pathSections{end};
            path = run.savePath(1:end-length(folder));
            
            mkdir(path, folder);
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
            scan = OpticalCTImagingScan;
            scan = scan.setDefaultValues();
            
            run.imagingScan = scan;
            
            run.importTimestamp = [];
            
            run.importPath = '';
            run.savePath = '';
            run.notes = '';
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

