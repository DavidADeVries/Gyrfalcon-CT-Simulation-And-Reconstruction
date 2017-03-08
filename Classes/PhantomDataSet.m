classdef PhantomDataSet < GyrfalconObject
    %PhantomDataSet
    
    properties
        data
    end
    
    methods
        function dataSet = PhantomDataSet(data)
            if nargin > 0
                dataSet.data = data;
            end
        end
        
        function dataSet = createBlankObject(dataSet)
            dataSet = PhantomDataSet;
        end
                
        function name = displayName(dataSet)
            name = 'Phantom Data Set';
        end
        
        function dataSet = setDefaultValues(dataSet)
            dataSet.data = [];
        end
        
        function [saved, dataSetForGUI, dataSetForParent, dataSetForSaving] = saveChildrenObjects(dataSet)
            dataSetForGUI = dataSet;
            dataSetForParent = dataSet;
            dataSetForSaving = dataSet;
            
            saved = true;
        end
        
        function dataSet = loadFields(dataSet)
        end
        
        
        function name = defaultName(dataSet)
            if isempty(dataSet.data)
                string = '';
            else
                dims = size(dataSet.data);
                
                if length(dims) == 2
                    dims(3) = 1;
                end
                
                string = [' (',num2str(dims(2)),'x',num2str(dims(1)),'x',num2str(dims(3)),')'];
            end
            
            name = [Constants.Default_Phantom_Data_Set_Name, string, Constants.Matlab_File_Extension]; 
        end
         
        function bool = equal(dataSet1, dataSet2)
            
            b1 = matricesEqual(dataSet1.data, dataSet2.data);
            
            bool = b1;
        end
        
        function handles = setGUI(dataSet, handles) 
            set(handles.phantomDataSetSaveInSeparateFileCheckbox, 'Value', dataSet.saveInSeparateFile);            
        
            if ~dataSet.saveInSeparateFile
                setString(handles.phantomDataSetFileNameText, 'Tied to Phantom');
            elseif isempty(dataSet.saveFileName)
                setString(handles.phantomDataSetFileNameText, 'None Selected');
             else                
                setString(handles.phantomDataSetFileNameText, dataSet.saveFileName);
            end
        end
        
        function dataSet = createFromGUI(dataSet, handles)
            dataSet.saveInSeparateFile = get(handles.phantomDataSetSaveInSeparateFileCheckbox,'Value');
        end
    end
    
end
