classdef GyrfalconObject
    %GyrfalconObject
    
    properties
        savePath
        saveFileName
        saveInSeparateFile = true
    end
    
    methods
        function object = clearBeforeSave(object)
            
            if isempty(object.savePath) || isempty(object.saveFileName)
                object.savePath = [];
                object.saveFileName = [];
                
                object = object.clearBeforeSaveFields();
            else
                savedDetector = object.load();
                
                if savedDetector.equal(object)
                    cache = object;
                    
                    object = object.createBlankObject();
                    
                    object.savePath = cache.savePath;
                    object.saveFileName = cache.saveFileName;
                else
                    path = makePath(object.savePath, object.saveFileName);
                    
                    className = class(object);
                    
                    question = ['The current settings of the ', className, ' differ from the saved version at: ', path];
                    title = [className, ' Settings Changed'];
                    
                    choice1 = 'Overwrite';
                    choice2 = 'Save New';
                    choice3 = 'Don''t Save';
                    
                    default = choice1;
                    
                    choice = questdlg(question, title, choice1, choice2, choice3 , default);
                    
                    switch choice
                        case choice1 % Overwrite
                            object.save();
                            
                            object = object.clearBeforeSave();
                        case choice2 % Save New
                            [saved, object] = object.saveAs();
                            
                            if saved
                                object = object.clearBeforeSave();
                            else
                                object.savePath = [];
                                object.saveFileName = [];
                                
                                object = object.clearBeforeSaveFields();
                            end
                            
                        case choice3 % Don't Save
                            object.savePath = '';
                            object.saveFileName = '';
                    end
                end
            end
        end
        
        function path = getPath(object)
            if isempty(object.savePath) || isempty(object.saveFileName)
                path = '';
            else
                path = makePath(object.savePath, object.saveFileName);
            end
        end
        
        function [object, objectForSaving, cancelled] = saveBeforeClearIfNeeded(object)
            objectForSaving = object;
            cancelled = false;
            
            if object.saveInSeparateFile
                clearBeforeSave = true;
                [object, objectForSaving] = object.clearBeforeSaveFields(clearBeforeSave);
                    
                if object.hasChanges()
                    clearBeforeSave = false;
                    
                    [saved, object, objectForSaving] = object.saveAs(clearBeforeSave);
                    
                    if ~saved
                        cancelled = true;
                    end
                end
            else
                objectForSaving.savePath = '';
                objectForSaving.saveFileName = '';
            end
        end
        
        function bool = hasChanges(object)
            path = object.getPath();
            
            if isempty(path)
                bool = true;
            else
                if exist(path, 'file')
                    data = load(path);
                    
                    if isfield(data, 'object')
                        loadObject = data.object;
                        
                        if strcmp(class(loadObject), class(object))
                            bool = ~loadObject.equal(object);
                        else
                            bool = true;
                        end
                    else
                        bool = true;
                    end
                else
                    bool = true;
                end
            end
              
        end
        
        function [saved, objectForGUI, objectForParent, objectForSaving] = save(object, defaultSavePath)            
            if object.saveInSeparateFile
                if isempty(object.getPath())
                    [saved, objectForGUI, objectForParent] = saveAs(object, defaultSavePath);
                else
                    [saved, objectForGUI, objectForParent, objectForSaving] = object.saveChildrenObjects(defaultSavePath);
                    
                    if saved
                        % set objectForParent
                        objectForParent = object.createBlankObject();
                        
                        objectForParent.savePath = objectForGUI.savePath;
                        objectForParent.saveFileName = objectForGUI.saveFileName;
                        objectForParent.saveInSeparateFile = true;
                        
                        % save object
                        object = objectForSaving;
                        save(object.getPath(), 'object');
                    end
                end
            else
                [saved, objectForGUI, objectForParent, objectForSaving] = object.saveChildrenObjects(defaultSavePath);
                
                if saved
                    % set objectForParent
                    objectForParent.savePath = '';
                    objectForParent.saveFileName = '';
                    
                    % set objectForGUI
                    objectForGUI.savePath = '';
                    objectForGUI.saveFileName = '';
                end
            end
        end
        
        function object = load(object, defaultLoadPath)
            path = object.getPath();
            
            error = false;
            
            if ~isempty(path)
                if exist(path, 'file')
                    data = load(path);
                    
                    if isfield(data, 'object')
                        newObject = data.object;
                        
                        if strcmp(class(newObject), class(object))
                            object = newObject;
                            
                            object = object.loadFields(defaultLoadPath);
                        else
                            string = ['File found at:', path, ' does not contain a ', class(object), ' object. Please find the proper file.'];
                            title = 'Invalid File Found';
                            
                            h = errordlg(string, title, 'modal');
                            uiwait(h);
                            
                            error = true;
                        end
                    else % invalid file
                        string = ['Invalid file found at:', path, ' Please find the proper file.'];
                        title = 'Invalid File Found';
                        
                        h = errordlg(string, title, 'modal');
                        uiwait(h);
                        
                        error = true;
                    end
                else % invalid file path
                    string = ['No file found at:', path, ' Please find the matching file.'];
                    title = 'No File Found';
                    
                    h = errordlg(string, title, 'modal');
                    uiwait(h);
                    
                    error = true;
                end
            else
                if ~object.saveInSeparateFile
                    % no error, just linked up with parent object
                    object = object.loadFields(defaultLoadPath);
                    
                    error = false;
                else
                    error = true;
                end
            end
            
            if error
                filterSpec = '*.mat';
                
                className = class(object);
                dialogTitle = ['Find ', className, ' File'];
                defaultName = defaultLoadPath;
                
                [fileName, pathName, ~] = uigetfile(filterSpec, dialogTitle, defaultName);
                
                if ~all(fileName == 0)
                    object.savePath = pathName;
                    object.saveFileName = fileName;
                    
                    object = object.load(defaultLoadPath);
                else
                    object = [];
                end
            end
        end
        
        function [saved, objectForGUI, objectForSaving, objectForParent] = saveAs(object, defaultSavePath)
            if object.saveInSeparateFile()
                className = class(object);
                
                filterSpec = '*.mat';
                dialogTitle = ['Save ', className, '...'];
                defaultName = makePath(defaultSavePath, object.defaultName());
                
                [fileName, pathName] = uiputfile(filterSpec, dialogTitle, defaultName);
                
                if ~all(fileName == 0)
                    object.savePath = pathName;
                    object.saveFileName = fileName;
                    object.saveInSeparateFile = true;
                    
                    [saved, objectForGUI, objectForSaving, objectForParent] = object.save(defaultSavePath);
                else
                    objectForGUI = object;
                    objectForSaving = [];
                    objectForParent = [];
                    
                    saved = false;
                end
            else
                [saved, objectForGUI, objectForSaving, objectForParent] = object.save(defaultSavePath);
            end
        end
        
        function [saved, objectForGUI, objectForSaving, objectForParent] = saveAsIfChanged(object, defaultSavePath)
            if object.hasChanges()
                [saved, objectForGUI, objectForSaving, objectForParent] = saveAs(object, defaultSavePath);
            else
                [saved, objectForGUI, objectForSaving, objectForParent] = save(object, defaultSavePath);
            end
        end
    end
    
    
    
end

