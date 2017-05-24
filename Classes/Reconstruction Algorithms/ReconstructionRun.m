classdef ReconstructionRun < ProcessingRun
    %ReconstructionRun
    
    properties
        reconstruction
        
        simulationRun
        
        reconPhantomDataSet %reconDataSet but interpolated to size of phantom data set (NaN at voxels if reconDataSet smaller than phantom)
        
    end
    
    methods
        function run = createFromGUI(run, handles)
            
        end
        
        function app = setGUI(run, app)
            [scanGeometry, errorMsg] = run.getScanGeometry();
                
            % simulationRun 
            if isempty(run.simulationRun)
                app.SimulationRunInfoLoadPathLabel.Text = 'Simulation Run Not Loaded';
                
                app.SimulationRunInfoStartDateTimeEditField.Value = '';
                app.SimulationRunInfoRunTimeEditField.Value = '';
                app.SimulationRunInfoGyrfalconVersionEditField.Value = '';
                app.SimulationRunInfoRunPerformanceEditField.Value = ''; 
                
                app.SimulationRunInfoInterpretedScanGeometryTextArea.Value = {''};
                app.SimulationRunInfoComputerArchitectureSummaryTextArea.Value = {''};
                app.SimulationRunInfoNotesTextArea.Value = {''};
                
                app.SimulationRunInfoLoadSimulationButton.Enable = 'off';
            else                
                app.SimulationRunInfoLoadPathLabel.Text = run.simulationRun.getPath();
                
                app.SimulationRunInfoStartDateTimeEditField.Value = datestr(run.startTimestamp, 'mmm dd, yyyy HH:MM:SS');
                app.SimulationRunInfoRunTimeEditField.Value = run.getRunTimeString();
                app.SimulationRunInfoGyrfalconVersionEditField.Value = ['v', run.versionUsed];
                app.SimulationRunInfoRunPerformanceEditField.Value = run.performanceType.displayString; 
                
                app.SimulationRunInfoInterpretedScanGeometryTextArea.Value = simulation.getScanGeometryString(scanGeometry, errorMsg);
                app.SimulationRunInfoComputerArchitectureSummaryTextArea.Value = run.computerInfo.getSummaryString();
                app.SimulationRunInfoNotesTextArea.Value = run.notes;
                
                %app.SimulationRunInfoLoadSimulationButton.Enable = 'on'; %TODO
            end
            
            % reconstructionRun
            savePath = run.getPath();
            
            if isempty(savePath)
                app.ReconstructionRunSavePathLabel.Text = 'Select path...';
            else
                app.ReconstructionRunSavePathLabel.Text = savePath;
            end
            
            if isempty(scanGeometry)
                app.ReconstructionRunAlgorithmDropDown.Enable = 'off';
                app.ReconstructionRunAlgorithmDropDown.Items = {'Invalid Scan Geometry'};
                app.ReconstructionRunAlgorithmDropDown.ItemsData = {};
                
                app.DataSetReconRunReconstructionButton.Enable = 'off';
                
                % clear out tabs
                hideAllAlgorithmSettingsTabs(app);
            else
                app.ReconstructionRunAlgorithmDropDown.Enable = 'on';
                
                setAlgorithmSelectionPopupMenu(...
                    app.ReconstructionRunAlgorithmDropDown,...
                    scanGeometry,...
                    run.reconstruction)
                
                app.DataSetReconRunReconstructionButton.Enable = 'on';
                
                % set visible tab
                hideAllAlgorithmSettingsTabs(app);
                
                tabHandle = run.reconstruction.getSettingsTabHandle(app);
                tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
                
                app = run.reconstruction.setGUI(app);
            end
            
            % recon settings
            app.ReconstructionRunSliceDimsXEditField.Value = run.reconstruction.reconSliceDimensions(1);
            app.ReconstructionRunSliceDimsYEditField.Value = run.reconstruction.reconSliceDimensions(2);
            
            % convert to mm
            pixelDimsInMM = Units.mm.convertFromM(run.reconstruction.reconSliceVoxelDimensionsInM);
            
            app.ReconstructionRunSlicePixelDimsXEditField.Value = pixelDimsInMM(1);
            app.ReconstructionRunSlicePixelDimsYEditField.Value = pixelDimsInMM(2);
            
            app.ReconstructionRunDataSetDimsXEditField.Value = run.reconstruction.reconDataSetDimensions(1);
            app.ReconstructionRunDataSetDimsYEditField.Value = run.reconstruction.reconDataSetDimensions(2);
            app.ReconstructionRunDataSetDimsZEditField.Value = run.reconstruction.reconDataSetDimensions(3);
            
            % convert to mm
            voxelDimsInMM = Units.mm.convertFromM(run.reconstruction.reconDataSetVoxelDimensionsInM);
            
            app.ReconstructionRunDataSetVoxelDimsXEditField.Value = voxelDimsInMM(1);
            app.ReconstructionRunDataSetVoxelDimsYEditField.Value = voxelDimsInMM(2);
            app.ReconstructionRunDataSetVoxelDimsZEditField.Value = voxelDimsInMM(3);
            
            % interpolation type drop-down
            app.ReconstructionRun3DInterpolationTypeDropDown.Value = run.reconstruction.reconDataSetInterpolationType;
            
            % set computerInfo
            
            % use GPU checkbox
            app.ReconstructionRunUseGPUCheckBox.Value = run.computerInfo.gpuUsed;
            
            if isempty(run.computerInfo.gpuDevice)
                app.ReconstructionRunUseGPUCheckBox.Enable = 'off';
            else
                app.ReconstructionRunUseGPUCheckBox.Enable = 'on';
            end
            
            % number of CPUs
            app.ReconstructionRunNumCPUsEditField.Value = run.computerInfo.numCoresUsed;
            app.ReconstructionRunNumCPUsEditField.Limits = [1 run.computerInfo.cpuNumCores];
            
            numCPUsAvailableString = ['/' num2str(run.computerInfo.cpuNumCores)];
            app.ReconstructionRunNumCPUsAvailableLabel.Text = numCPUsAvailableString;
            
            % notes
            app.ReconstructionRunNotesTextArea.Value = run.notes;
        end
        
        function [scanGeometry, errorMsg] = getScanGeometry(run)
            if isempty(run.simulationRun) || isempty(run.simulationRun.simulation)
                scanGeometry = [];
                errorMsg = 'No Simulation Selected';
            else
                [scanGeometry, errorMsg] = run.simulationRun.simulation.findScanGeometry();
            end
        end
        
        function run = setDefaultValues(run)
            run.reconstruction = Reconstruction();
            run.simulationRun = [];
            
            run.notes = '';
        end
        
        function [] = runReconstruction(run, app)
            % get save path
            savePath = run.simulationRun.savePath;
            
            lastReconNumber = getLastReconNumber(savePath);
            numStr = num2str(lastReconNumber+1);
            algoStr = run.reconstruction.getNameString();
            
            defaultName = [Constants.Reconstruction_Folder_Name, ' ', numStr, ' (', algoStr, ')'];
            
            answer = {''}; % this is NOT empty
            validFolder = false;
            folderName = '';
            
            while ~isempty(answer) && ~validFolder % keep looping till folder found or cancelled
                prompt = ...
                    {['The reconstruction results will be save with the Simulation Run at ',...
                    savePath,...
                    '. Please enter the name of the subdirectory to save the reconstruction to.']};
                dialogTitle = 'Reconstruction Title';
                numLines = 1;
                defaultAns = {defaultName};
                
                answer = inputdlg(prompt, dialogTitle, numLines, defaultAns);
                
                if ~isempty(answer) % not cancelled
                    folderName = answer{1};
                    
                    validFolder = ~isStrInCellArray(getFolders(savePath), folderName);
                end
            end
            
            if ~isempty(answer) && validFolder
                
                reconSavePath = makePath(savePath, folderName);
                run.savePath = reconSavePath;
                run.saveFileName = [Constants.Reconstruction_Run_File_Name, Constants.Matlab_File_Extension];
                
                % set run conditions (CPU, GPU, notes)
                [cancel, run] = run.collectSettings();
                
                if ~cancel
                    % set status string with recon running
                    
                    newString = ['Reconstruction Run Start (', convertTimestampToString(now), ')'];
                    newLine = true;
                    
                    app = updateStatusOutput(app, newString, newLine);
                    
                    % run the recon
                    run = run.startProcessingRun(); % set start time
                    run.reconstruction = ...
                        run.reconstruction.runReconstruction(run.simulationRun, app);
                    run = run.endProcessingRun(); % set end time
                    
                    % set status string complete
                    
                    newString = ['Reconstruction Run Complete (', convertTimestampToString(now), ')'];
                    newLine = true;
                    
                    app = updateStatusOutput(app, newString, newLine);
                    
                    
                    % perform the recon of the 3D data-set from recon'ed
                    % slices
                    
                    run.reconstruction = run.reconstruction.reconFullDataSet(run.simulationRun.simulation);
                    
                    % compare to the original phantom
                    
                    run = run.calculateReconPhantomDataSet();
                    
                    % save files
                    run.saveReconstructionValues();
                end
            end
        end
        
        function run = calculateReconPhantomDataSet(run)
            interpolationType = run.reconstruction.reconDataSetInterpolationType;
            
            recon = run.reconstruction;
            phantom = run.simulationRun.simulation.phantom;
            
            reconCompareSet = interpolateDataSetToNewCooords(...
                recon.reconDataSet, recon.reconDataSetLocationInM, recon.reconDataSetVoxelDimensionsInM, recon.reconDataSetDimensions,...
                phantom.getLocationInM(), phantom.getVoxelDimensionsInM(), phantom.getDataSetDimensions(),...
                interpolationType);
            
            run.reconPhantomDataSet = reconCompareSet;
        end
        
        function [] = saveReconstructionValues(run)
            % clear out simulationRun projection data
            run.simulationRun.sliceData = {};
            
            % have reconstruction save any extra outputs
            run.reconstruction.saveOuput(run.savePath);
            
            % save this, the reconstruction run
            save(makePath(run.savePath, run.saveFileName), Constants.Processing_Run_Var_Name);
            
        end
        
    end
    
end


function [] = setAlgorithmSelectionPopupMenu(handle, scanGeometry, choice)
    [algorithmChoiceStrings, choices] = scanGeometry.getReconAlgorithmChoices();
    
    numChoices = length(choices);
    
    index = 1;
    
    choiceClass = class(choice);
    
    for i=1:numChoices
        if isa(choices{i}, choiceClass)
            index = i;
            break;
        end
    end
    
    handle.Items = algorithmChoiceStrings;
    handle.ItemsData = choices;
    handle.Value = choices{index};
end

function [choice] = getChoiceFromAlgorithmSelectionPopupMenu(handle, scanGeometry)
    choice = handle.Value;
end

function lastReconNumber = getLastReconNumber(path)
    
folders = getFolders(path);

lastReconNumber = 0;

prefixLen = length(Constants.Reconstruction_Folder_Name);

for i=1:length(folders)
    folderName = folders{i};
    
    indices = strfind(folderName, Constants.Reconstruction_Folder_Name);
    
    if ~isempty(indices)
        index = indices(1);
        
        searchStart = index + prefixLen;
        
        num = searchStringForNumber(folderName(searchStart:end));
        
        if ~isempty(num) && num > lastReconNumber
            lastReconNumber = num;
        end
    end
end

end

function num = searchStringForNumber(string)

num = [];

digits = [];
digitCounter = 1;
started = false;

for i=1:length(string)
    c = string(i);
    
    if isstrprop(c, 'digit')
        digits(digitCounter) = str2double(c);
        
        digitCounter = digitCounter + 1;
        started = true;
    elseif started
        break;
    end
end

if digitCounter > 1
    num = 0;
    power = 0;
    
    for i=length(digits):-1:1
        num = num + digits(i)*10^power;
        
        power = power + 1;
    end
end

end