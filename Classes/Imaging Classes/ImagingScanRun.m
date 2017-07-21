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
    % * sliceData
    % when data is loaded up, it'll be in here
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
        saveFileName
        
        sliceData
        
        notes
    end
    
    methods
        function scanRun = ImagingScanRun()
            
        end
        
        function app = setGUI(run, app)
            if isempty(run.savePath) % not yet set
                app.ImagingScanRunSavePathEditField.Value = 'Not Selected...';
            else
                app.ImagingScanRunSavePathEditField.Value = makePath(run.savePath, run.saveFileName);
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
            run.imagingScan.setGUI(app);
        end
        
        function path = getPath(run)
            path = makePath(run.savePath, run.saveFileName);
        end
        
        function setup = getImagingSetup(run)
            setup = run.imagingScan;
        end
            
        function phantom = getPhantom(run)
            phantom = []; % threre is no phantom return empty
        end
        
        function run = loadData(run, basePath) %use given basePath in case files are moved around
%             imagingScan = run.imagingScan;
%             
%             numSlices = length(imagingScan.scan.slices);
%                         
%             sliceData = cell(1, numSlices);
%             
%             for i=1:numSlices
%                 sliceFolder = makeSliceFolderName(i);
%                 
%                 path = makePath(basePath, sliceFolder);
%                 
%                 data = SliceData;
%                 
%                 data = data.loadData(path, imagingScan);
%                 
%                 sliceData{i} = data;
%             end
%             
%             run.sliceData = sliceData;
            
        end 
        
        function app = setGUIForScanSimulationViewer(run, app)
            if isempty(run.getPath())
                app.SimulationViewerFilePathLabel.Text = 'No Run Selected';
                
                app.SimulationViewerSliceListBox.Enable = 'off';
                app.SimulationViewerScanAngleListBox.Enable = 'off';
                app.SimulationViewerPerAngleTranslationPositionListBox.Enable = 'off';
                
                app.SimulationViewerSliceListBox.Items = {};
                app.SimulationViewerScanAngleListBox.Items = {};
                app.SimulationViewerPerAngleTranslationPositionListBox.Items = {};
                
                app.SimulationViewerInfoStartDateTimeEditField.Value = '';
                app.SimulationViewerInfoRunPerformanceEditField.Value = '';
                app.SimulationViewerInfoGyrfalconVersionEditField.Value = '';
                app.SimulationViewerInfoRunTimeEditField.Value = '';
                app.SimulationViewerInfoComputerArchitectureSummaryTextArea.Value = '';
                app.SimulationViewerInfoNotesTextArea.Value = '';
                
                imshow([], 'Parent', app.SimulationViewerAxes);
                
                app.InvertImageDisplayCheckBox.Enable = 'off';
                app.ImageContrastLowEditField.Enable = 'off';
                app.ImageContrastHighEditField.Enable = 'off';
                app.SimulationViewerLoopThroughAnglesButton.Enable = 'off';
            else
                app.SimulationViewerFilePathLabel.Text = run.savePath;
                
                app.SimulationViewerSliceListBox.Enable = 'on';
                app.SimulationViewerScanAngleListBox.Enable = 'on';
                app.SimulationViewerPerAngleTranslationPositionListBox.Enable = 'on';
                
                [sliceNames, angleNames, positionNames, positionFileNames] = run.getFolderNames();
                
                app.SimulationViewerSliceListBox.Items = sliceNames;
                app.SimulationViewerScanAngleListBox.Items = angleNames;
                app.SimulationViewerPerAngleTranslationPositionListBox.Items = positionNames;
                app.SimulationViewerPerAngleTranslationPositionListBox.ItemsData = positionFileNames;
                
                if isempty(app.SimulationViewerSliceListBox.Value)
                    app.SimulationViewerSliceListBox.Value = sliceNames{1};
                end
                
                if isempty(app.SimulationViewerScanAngleListBox.Value)
                    app.SimulationViewerScanAngleListBox.Value = angleNames{1};
                end
                
                if isempty(app.SimulationViewerPerAngleTranslationPositionListBox.Value)
                    app.SimulationViewerPerAngleTranslationPositionListBox.Value = positionFileNames{1};
                end
                
                app.SimulationViewerInfoStartDateTimeEditField.Value =  'N/A';%datestr(run.imagingScan.scanTimestamp, 'mmm dd, yyyy HH:MM:SS');
                app.SimulationViewerInfoRunPerformanceEditField.Value = 'N/A';
                app.SimulationViewerInfoGyrfalconVersionEditField.Value = 'N/A';
                app.SimulationViewerInfoRunTimeEditField.Value = 'N/A';
                app.SimulationViewerInfoComputerArchitectureSummaryTextArea.Value = 'N/A';
                app.SimulationViewerInfoNotesTextArea.Value = run.notes;
                
                image = loadImageForScanSimulationViewer(run, app);
                
                minVal = allMin(image);
                maxVal = allMax(image);
                
                app.InvertImageDisplayCheckBox.Value = true;
                app.ImageContrastLowEditField.Value = minVal;
                app.ImageContrastHighEditField.Value = maxVal;
                
                app.InvertImageDisplayCheckBox.Enable = 'on';
                app.ImageContrastLowEditField.Enable = 'on';
                app.ImageContrastHighEditField.Enable = 'on';
                app.SimulationViewerLoopThroughAnglesButton.Enable = 'on';
                
                showSimulationViewImage(app);
            end            
        end
        
        function app = setGUIForReconstructionRun(run, app)
            [scanGeometry, errorMsg] = run.findScanGeometry();
            
            app.SimulationRunInfoLoadPathLabel.Text = run.getPath();
            
            app.SimulationRunInfoStartDateTimeEditField.Value = 'N/A';%datestr(run.simulationRun.startTimestamp, 'mmm dd, yyyy HH:MM:SS');
            app.SimulationRunInfoRunTimeEditField.Value = 'N/A';
            app.SimulationRunInfoGyrfalconVersionEditField.Value = 'N/A';
            app.SimulationRunInfoRunPerformanceEditField.Value = 'N/A';
            
            geometryString = getScanGeometryString(run.imagingScan, scanGeometry, errorMsg);
            
            app.SimulationRunInfoInterpretedScanGeometryTextArea.Value = geometryString;
            app.SimulationRunInfoComputerArchitectureSummaryTextArea.Value = run.imagingScan.getSummaryString();
            app.SimulationRunInfoNotesTextArea.Value = run.notes;
            
            %app.SimulationRunInfoLoadSimulationButton.Enable = 'on'; %TODO
        end
                  
        function [scanGeometry, errorMsg] = findScanGeometry(run)
            [scanGeometry, errorMsg] = boolLogicForFindScanGeometry(run.imagingScan);
        end
        
        function [sliceNames, angleNames, positionNames, positionFileNames] = getFolderNames(run)
            numSlices = length(run.imagingScan.scan.slices);
            
            angles = run.imagingScan.scan.getScanAnglesInDegrees();
            numAngles = length(angles);
            
            positionDims = run.imagingScan.scan.perAngleTranslationDimensions;
            
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
                angleNames{i} = makeAngleFolderName(round(angles(i),2));
            end
            
            isPositionMosiac = false;
            
            for i=1:zNumSteps
                for j=1:xyNumSteps
                    index = (i-1)*zNumSteps + j;
                    
                    positionNames{index} = makePositionName(j,i,isPositionMosiac);
                    positionFileNames{index} = makePositionFileName(positionNames{index});
                end
            end
            
        end
        
        function name = getDefaultFolderName(run)
            typeClass = class(run.imagingScan);
            
            if strcmp(typeClass, class(OpticalCTImagingScan))
                start = ImagingScanTypes.opticalCT.displayString;
            elseif strcmp(typeClass, class(XrayCTImagingScan))
                start = ImagningScanTypes.xrayCT.displayString;
            else
                error('Invalid Scan Type');
            end
            
            name = [start, ' ', Constants.Imaging_Scan_Run_File_Name, Constants.Matlab_File_Extension];
        end
        
        function run = createFromGUI(run, app)            
            run.notes = app.ImagingScanRunNotesTextArea.Value;
            
            run.imagingScan = run.imagingScan.createFromGUI(app);
        end
        
        function run = importDataSet(run)                
            run.importTimestamp = now;
            
            run = run.createSaveDirectory();
            
            run.imagingScan = run.imagingScan.importDataSet(run.importPath, run.savePath);
            
            save(makePath(run.savePath, run.saveFileName), Constants.Imaging_Run_Var_Name); %saving 'run'
        end
        
        function run = createSaveDirectory(run)
            path = run.savePath;
            fileName = run.saveFileName;
            
            folder = removeFileExtension(fileName);
                        
            mkdir(path, folder);            
            run.savePath = makePath(path, folder);
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

