classdef Phantom < GyrfalconObject
    % Phantom
    % This class contains all the data pertaining to a phantom for the CT
    % simulator.
    % 
    % FIELDS:
    % *data:
    % 2-D or 3-D matrix of values representing whatever is being scanned
    %
    % *voxelDimensions: 
    % for each of the values given in the data, a square/cube is not assumed. Give dimensions as [r,c,s]
    % units are in mm
    %
    % *location: 
    % gives the location of the (1,1,1) index with respect to the origin 
    % (0,0,0) where (0,0,z) is the center of rotation for the gantry for 
    % slice z, and where z > 0 (e.g. z=0 is a head/foot)
    % coords are of the leftmost (x), topmost (y), topmost (z) point
    % units are in mm
    
    
    properties
        dataSet
        
        voxelDimensions
        voxelDimensionUnits = Units.mm
        
        location
        locationUnits = Units.m
    end
    
    methods
        function phantom = Phantom(phantomData, phantomVoxelDimensions, phantomLocation, dataFileName, dataPath)
            if nargin > 0
                % validate phantom parameters, and fill in gaps if needed
                
                % validate data
                dataDims = size(phantomData);
                dataNumDims = length(dataDims);
                
                % validate voxel dims
                voxelNumDims = length(phantomVoxelDimensions);
                
                if voxelNumDims > 3
                    error('Cannot have more than three dimensions for a voxel');
                elseif voxelNumDims == 1
                    error('Cannot have a single dimensional voxel');
                elseif voxelNumDims == 2
                    % must be dealing with 2D data, no problem, just set z
                    % width as 0
                    
                    phantomVoxelDimensions = [phantomVoxelDimensions, 0];
                end
                
                %validate location
                
                locationNumDims = length(phantomLocation);
                
                if locationNumDims > 3
                    error('Cannot place phantom beyond 3D space');
                elseif locationNumDims == 1
                    error('Cannot place phantom in 1D space');
                elseif locationNumDims == 2
                    % must be dealing with 2D data, no problem, set z loc as 0
                    
                    phantomLocation = [phantomLocation, 0];
                end
                
                
                % if we get here, we're good to go, so lets assign the fields
                
                phantom.data = phantomData;
                phantom.voxelDimensions = phantomVoxelDimensions;
                phantom.location = phantomLocation;
                
                phantom.dataFileName = dataFileName;
                phantom.dataPath = dataPath;
            end
        end
        
        function object = createBlankObject(object)
            object = Phantom;
        end
        
        function name = displayName(phantom)
            name = 'Phantom';
        end
        
        function phantom = setDefaultValues(phantom)
            phantom.dataSet = PhantomDataSet;
            
            phantom.voxelDimensions = [1,1,1];
            
            phantom.location = [0,0,0];
        end
        
        function [saved, phantomForGUI, phantomForParent, phantomForSaving] = saveChildrenObjects(phantom, defaultSavePath)
            phantomForGUI = phantom;
            phantomForParent = phantom;
            phantomForSaving = phantom;
            
            if ~isempty(phantom.dataSet)
                [saved, dataSetForGUI, dataSetForParent, ~] = phantom.dataSet.saveAsIfChanged(defaultSavePath);
                
                if saved
                    phantomForGUI.dataSet = dataSetForGUI;
                    phantomForParent.dataSet = dataSetForParent;
                    phantomForSaving.dataSet = dataSetForParent;
                end
            else
                saved = true;
            end
        end
        
        function phantom = loadFields(phantom, defaultLoadPath)
            phantom.dataSet = phantom.dataSet.load(defaultLoadPath);
        end        
        
        function name = defaultName(phantom)
            if isempty(phantom.dataSet)
                string = '';
            else
                dims = size(phantom.dataSet.data);
                
                if length(dims) == 2
                    dims(3) = 1;
                end
                
                string = [' (',num2str(dims(2)),'x',num2str(dims(1)),'x',num2str(dims(3)),')'];
            end
            
            name = [Constants.Default_Phantom_Name, string, Constants.Matlab_File_Extension]; 
        end
         
        function bool = equal(phantom1, phantom2)
            b1 = gyrfalconObjectsEqual(phantom1.dataSet, phantom2.dataSet);
            
            b2 = matricesEqual(phantom1.voxelDimensions, phantom2.voxelDimensions);
            b3 = phantom1.voxelDimensionUnits == phantom2.voxelDimensionUnits;
            b4 = matricesEqual(phantom1.location, phantom2.location);
            b5 = phantom1.locationUnits == phantom2.locationUnits;
            b6 = strcmp(phantom1.savePath, phantom2.savePath);
            b7 = strcmp(phantom1.saveFileName, phantom2.saveFileName);
            
            bool = b1 && b2 && b3 && b4 && b5 && b6 && b7;
        end
        
        function voxelDimsInM = getVoxelDimensionsInM(phant)
            units = phant.voxelDimensionUnits;
            voxelDims = phant.voxelDimensions;
                        
            voxelDimsInM = units.convertToM(voxelDims);
        end
        
        function dims = getDataSetDimensions(phant)
            dims = phant.dataSet.getSize();
        end
        
        function locationInM = getLocationInM(phant)
            units = phant.locationUnits;
            location = phant.location;
            
            locationInM = units.convertToM(location);
        end
        
        function centreLocationInM = getCentreLocationInM(phant)
            % get corner location in m
            units = phant.locationUnits;
            location = phant.location;
            
            cornerLocationInM = units.convertToM(location);
            
            % get size of phantom in m to let us find the centre
            units = phant.voxelDimensionUnits;
            dimensions = phant.voxelDimensions;
            
            voxelDimsInM = units.convertToM(dimensions);
            phantomDims = phant.dataSet.getSize();
            
            phantomDimsInM = phantomDims .* voxelDimsInM;
            
            % to get to centre divide by 2
            shift = phantomDimsInM ./ 2;
            
            % x-coord needs to be added, y,z-coords needed to be subtracted
            shift = shift .* [1 -1 -1];
            
            % final calc
            centreLocationInM = cornerLocationInM + shift;
        end
        
        function data = getData(phantom)
            if isempty(phantom.dataSet)
                data = [];
            else
                data = phantom.dataSet.data;
            end
        end
        
        function [] = plot(phantom, axesHandle)
            phantomDataInHU = phantom.dataSet.data;
            phantomDimsInM = phantom.getVoxelDimensionsInM();
            phantomLocationInM = phantom.getLocationInM();
            
            handles = getPhantomPlotCoords(phantomDataInHU, phantomDimsInM, phantomLocationInM, axesHandle);           
        end
        
        function app = setGUI(phantom, app)
            % set "editable" values
            x = phantom.location(1);
            y = phantom.location(2);
            z = phantom.location(3);
            
            app.PhantomLocationXEditField.Value = x;
            app.PhantomLocationYEditField.Value = y;
            app.PhantomLocationZEditField.Value = z;
            
            x = phantom.voxelDimensions(1);
            y = phantom.voxelDimensions(2);
            z = phantom.voxelDimensions(3);
            
            app.PhantomVoxelDimsXEditField.Value = x;
            app.PhantomVoxelDimsYEditField.Value = y;
            app.PhantomVoxelDimsZEditField.Value = z;
            
            app.PhantomSaveInSeparateFileCheckBox.Value = phantom.saveInSeparateFile;
                        
            if ~phantom.saveInSeparateFile
                app.PhantomFilePathLabel.Text = 'Tied to Simulation';
            elseif isempty(phantom.saveFileName)
                app.PhantomFilePathLabel.Text = 'Not Saved';
            else
                app.PhantomFilePathLabel.Text = phantom.saveFileName;
            end
            
            app = phantom.dataSet.setGUI(app);
        end
        
        function phant = createFromGUI(phant, app)
            % get "editable" values
            
            x = app.PhantomLocationXEditField.Value;
            y = app.PhantomLocationYEditField.Value;
            z = app.PhantomLocationZEditField.Value;
            
            phant.location = [x,y,z];
            
            x = app.PhantomVoxelDimsXEditField.Value;
            y = app.PhantomVoxelDimsYEditField.Value;
            z = app.PhantomVoxelDimsZEditField.Value;
            
            phant.voxelDimensions = [x,y,z];
            
            phant.saveInSeparateFile = app.PhantomSaveInSeparateFileCheckBox.Value;
            
            % phantom data set
            phant.dataSet = phant.dataSet.createFromGUI(app);
        end
    end
    
end

