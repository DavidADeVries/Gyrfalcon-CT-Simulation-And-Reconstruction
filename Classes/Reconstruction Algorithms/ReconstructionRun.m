classdef ReconstructionRun < ProcessingRun
    %ReconstructionRun
    
    properties
        reconstructionAlgorithm
        
        simulationRun
    end
    
    methods
        function run = createFromGUI(run, handles)
            
        end
        
        function handles = setGUI(run, handles)
            [scanGeometry, errorMsg] = run.getScanGeometry();
                            
            if isempty(scanGeometry)
                % set simulationRunScanGeometryText
                setString(handles.simulationRunScanGeometryText, errorMsg);
                
                % set reconstructionAlgorithmSelectionPopupMenu
                set(handles.reconstructionAlgorithmSelectionPopupMenu,...
                    'Enable','inactive',...
                    'String',{'None'});
                
                % set reconstructionAlgorithmSettingsText
                setString(handles.reconstructionAlgorithmSettingsText, '');
                
                % set reconstructionAlgorithmSettingsEditButton
                set(handles.reconstructionAlgorithmSettingsEditButton, 'Enable', 'off');
                
                % set controlPanelRunReconstructionButton
                set(handles.controlPanelRunReconstructionButton, 'Enable', 'off');
            else
                % set simulationRunScanGeometryText
                numSlices = num2str(length(run.simulationRun.simulation.scan.slices));
                numAngles = num2str(length(run.simulationRun.simulation.scan.scanAngles));
                
                geometryString = {...
                    scanGeometry.displayString,...
                    scanGeometry.shortDescriptionString,...
                    [numAngles, ' Angles, ', numSlices, ' Slices']};
                
                setString(handles.simulationRunScanGeometryText, geometryString);
                
                % set reconstructionAlgorithmSelectionPopupMenu
                setAlgorithmSelectionPopupMenu(...
                    handles.reconstructionAlgorithmSelectionPopupMenu,...
                    scanGeometry,...
                    run.reconstructionAlgorithm);
                
                set(handles.reconstructionAlgorithmSelectionPopupMenu, 'Enable','on');
                
                % set reconstructionAlgorithmSettingsText
                set(handles.reconstructionAlgorithmSettingsText,...
                    'String', run.reconstructionAlgorithm.getSettingsString());
                
                % set reconstructionAlgorithmSettingsEditButton
                set(handles.reconstructionAlgorithmSettingsEditButton, 'Enable', 'on');
                
                % set controlPanelRunReconstructionButton
                set(handles.controlPanelRunReconstructionButton, 'Enable', 'on');
            end
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
            run.reconstructionAlgorithm = [];
            run.simulationRun = [];
        end
        
        function [] = runReconstruction(run, handles)
            % get save path
            savePath = run.simulationRun.savePath;
            
            lastReconNumber = getLastReconNumber(savePath);
            numStr = num2str(lastReconNumber+1);
            algoStr = run.reconstructionAlgorithm.getNameString();
            
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
                    
                    baseString = getString(handles.statusOutputText);
                    
                    baseString = [baseString; {['Reconstruction Run Start (', convertTimestampToString(now), ')']}];
                    
                    setString(handles.statusOutputText, baseString);
                    
                    % run the recon
                    run = run.startProcessingRun(); % set start time
                    run.reconstructionAlgorithm = ...
                        run.reconstructionAlgorithm.runReconstruction(run.simulationRun, handles);
                    run = run.endProcessingRun(); % set end time
                    
                    % set status string complete
                    
                    setString(handles.statusOutputText, [baseString; {['Reconstruction Run Complete (', convertTimestampToString(now), ')']}]);
                    
                    % save files
                    run.saveReconstructionValues();
                end
            end
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
    
    set(handle,...
        'String', algorithmChoiceStrings,...
        'Value', index);
end

function [choice] = getChoiceFromAlgorithmSelectionPopupMenu(handle, scanGeometry)
    [~, choices] = scanGeometry.getReconAlgorithmChoices();
    
    index = get(handle, 'Value');
    
    choice = choices{index};
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