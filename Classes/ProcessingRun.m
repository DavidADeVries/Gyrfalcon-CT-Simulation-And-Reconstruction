classdef ProcessingRun
    % ProcessingRun
    
    properties
        
        startTimestamp
        endTimestamp        
        
        computerInfo
        versionUsed
        
        notes
        savePath
        saveFilename
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
            run.saveFilename = [];
        end
                
        function run = collectNotes(run)
            prompt = 'Please enter any needed notes about the processing run:';
            dlg_title = 'Notes Input';
            num_lines = [1,250];
            
            if isempty(run.notes)
                defAns = '';
            else
                defAns = run.notes;
            end
            
            answer = inputdlg(prompt, dlg_title, num_lines, defAns);
            
            if ~isempty(answer)
                run.notes = answer;
            end            
        end
        
        function run = collectSavePathAndFilename(run)
            filterspec = '*.mat';
            dialogTitle = 'Save As';
            
            [filename,pathname] = uiputfile(filterspec, dialogTitle);
            
            if ~isa(filename,'double') % didn't click cancel
                run.savePath = pathname;
                run.saveFilename = filename;
            end
        end
        
        function bool = isValidForSave(run)
            bool = ~isempty(run.savePath) && ~isempty(run.saveFilename);
        end
        
        function run = startProcessingRun(run)
            run.startTimestamp = now;            
        end
        
        function run = endProcessingRun(run)
            run.endTimestamp = now;
        end
        
        function [] = save(run)
            % chance to set save path if needed
            if run.isValidForSave()
                run = run.collectSavePathAndFilename();
            end
            
            % now save
            if run.isValidForSave()
                save(makePath(run.savePath, run.saveFilename), Constants.Processing_Run_Var_Name);
            end
        end
    end
    
end

