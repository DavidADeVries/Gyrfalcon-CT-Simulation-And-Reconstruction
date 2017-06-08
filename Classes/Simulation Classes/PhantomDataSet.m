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
        
        function [saved, dataSetForGUI, dataSetForParent, dataSetForSaving] = saveChildrenObjects(dataSet, defaultSavePath)
            dataSetForGUI = dataSet;
            dataSetForParent = dataSet;
            dataSetForSaving = dataSet;
            
            saved = true;
        end
        
        function dataSet = loadFields(dataSet, defaultLoadPath)
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
        
        function app = setGUI(dataSet, app) 
            app.PhantomDataSetSaveInSeparateFileCheckBox.Value = dataSet.saveInSeparateFile;
        
            if ~dataSet.saveInSeparateFile
                app.PhantomDataSetFilePathLabel.Text = 'Tied to Phantom';
            elseif isempty(dataSet.saveFileName)
                app.PhantomDataSetFilePathLabel.Text = 'None Selected';
             else                
                app.PhantomDataSetFilePathLabel.Text = dataSet.saveFileName;
            end
            
            % dimension text
            size = dataSet.getSize();
            
            sizeString = [num2str(size(1)), 'x', num2str(size(2)), 'x', num2str(size(3))];
            
            app.PhantomDataSetDimensionsEditField.Value = sizeString;
        end
        
        function dataSet = createFromGUI(dataSet, app)
            dataSet.saveInSeparateFile = app.PhantomDataSetSaveInSeparateFileCheckBox.Value;
        end
        
        function dims = getSize(dataSet)
            if isempty(dataSet.data)
                dims = [0 0 0];
            else
                dims = size(dataSet.data);
                
                if length(dims) == 2
                    dims = [dims 1]; %if only in x,y, we add a height of 1 (technically, though dimension length in z is 0mm)
                end
                
                numRows = dims(1);
                numCols = dims(2);
                numSlices = dims(3);
                
                dims = [numCols, numRows, numSlices]; %numCols goes to x, numRows is y
            end
        end
    end
    
end

