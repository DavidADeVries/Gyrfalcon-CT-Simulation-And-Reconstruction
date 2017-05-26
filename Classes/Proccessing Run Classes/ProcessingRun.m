classdef ProcessingRun
    % ProcessingRun
    
    properties
        
        startTimestamp
        endTimestamp        
        
        computerInfo
        versionUsed
        
        notes
        savePath
        saveFileName
    end
    
    methods
        function run = ProcessingRun()
            run.computerInfo = ComputerInfo();
            run.versionUsed = Constants.version;
            
            % should be set by other functions before saving
            run.startTimestamp = [];
            run.endTimestamp = [];
            run.notes = [];
            run.savePath = [];
            run.saveFileName = [];
        end
        
        function [cancel, run] = collectSavePathAndFilename(run, defaultPath)
            filterspec = '*.mat';
            dialogTitle = 'Save As';
            
            [filename,pathname] = uiputfile(filterspec, dialogTitle, defaultPath);
            
            if ~isa(filename,'double') % didn't click cancel
                run.savePath = pathname(1:end-1); %slice off last '/'
                run.saveFileName = filename;
                
                cancel = false;
            else
                cancel = true;
            end
        end
        
        function bool = isValidForSave(run)
            bool = ~isempty(run.savePath) && ~isempty(run.saveFileName);
        end
        
        function run = startProcessingRun(run)
            run.startTimestamp = now;            
        end
        
        function run = endProcessingRun(run)
            run.endTimestamp = now;
        end
        
        function path = getPath(run)
            path = makePath(run.savePath, run.saveFileName);
        end
        
        function [hours, minutes, seconds] = getRunTime(run)
            numHours = (run.endTimestamp - run.startTimestamp) * 24;
            
            hours = floor(numHours);
            
            numMinutes = (numHours - hours) * 60;
            
            minutes = floor(numMinutes);
            
            numSeconds = (numMinutes - minutes) * 60;
            
            seconds = floor(numSeconds);
        end
        
        function string = getRunTimeString(run)
            [hours, minutes, seconds] = run.getRunTime();
            
            hourStr = convertToTimeString(hours);
            minStr = convertToTimeString(minutes);
            secStr = convertToTimeString(seconds);
            
            string = [hourStr, ':', minStr, ':', secStr];
        end
        
        function [] = save(run)
            % chance to set save path if needed
            if ~run.isValidForSave()
                run = run.collectSavePathAndFilename();
            end
            
            % now save
            if run.isValidForSave()
                save(makePath(run.savePath, run.saveFileName), Constants.Processing_Run_Var_Name);
            end
        end
        
        
    end
    
end

function str = convertToTimeString(time)
    str = num2str(time);
    
    if length(str) == 1
        str = ['0', str];
    end
end