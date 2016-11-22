classdef Phantom
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
    % units are in mm
    
    
    properties
        data
        
        voxelDimensions
        voxelDimensionUnits = Units.mm
        
        location
        locationUnits = Units.m
        
        dataPath
        dataFileName
                
        savePath
        saveFileName
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
        
        function voxelDimsInM = getVoxelDimensionsInM(phant)
            units = phant.voxelDimensionUnits;
            voxelDims = phant.voxelDimensions;
            
            voxelDimsInM = units.convertToM(voxelDims);
        end
        
        function locationInM = getLocationInM(phant)
            units = phant.locationUnits;
            location = phant.location;
            
            locationInM = units.convertToM(location);
        end
        
        function [] = plot(phantom, axesHandle)
            data = phantom.data;
            
            less = data >= 0;
            
            data = data .* less; 
            
           
            locationInM = phantom.locationUnits.convertToM(phantom.location);
            voxelDimsInM = phantom.voxelDimensionUnits.convertToM(phantom.voxelDimensions);
            
            
            dataDims = size(data);
            
            if length(dataDims) == 2 % if 2D
                dataDims = [dataDims, 1];
            end
            
            [vertices, faces, cData, alphaData] = createVerticesAndFaces(locationInM, voxelDimsInM, dataDims, data);
            
            patch('Faces', faces, 'Vertices', vertices, 'FaceVertexCData', cData, 'FaceVertexAlphaData', alphaData, 'FaceAlpha','flat','FaceColor', 'flat', 'EdgeColor','none');
                   
        end
        
        function handles = setGUI(phantom, handles)            
            x = phantom.location(1);
            y = phantom.location(2);
            z = phantom.location(3);
            
            setDoubleForHandle(handles.phantomStartingLocationXEdit, x);
            setDoubleForHandle(handles.phantomStartingLocationYEdit, y);
            setDoubleForHandle(handles.phantomStartingLocationZEdit, z);
            
            x = phantom.voxelDimensions(1);
            y = phantom.voxelDimensions(2);
            z = phantom.voxelDimensions(3);
            
            setDoubleForHandle(handles.phantomVoxelDimensionsXEdit, x);
            setDoubleForHandle(handles.phantomVoxelDimensionsYEdit, y);
            setDoubleForHandle(handles.phantomVoxelDimensionsZEdit, z);
            
            handles.phantomDataSet = phantom.data;
            
            if ~isempty(phantom.dataFileName)
                setString(handles.phantomDataSetFileNameText, phantom.dataFileName);
            end
            
            if isempty(phantom.saveFileName)
                setString(handles.phantomFileNameText, 'Not Saved');
            else
                setString(handles.phantomFileNameText, phantom.saveFileName);
            end
            
            % set hidden handles
            handles.phantomSavePath = phantom.savePath;
            handles.phantomSaveFileName = phantom.saveFileName;
            
            handles.phantomDataPath = phantom.dataPath;
            handles.phantomDataFileName = phantom.dataFileName;
        end
        
        function phant = createFromGUI(phant, handles)
            x = getDoubleFromHandle(handles.phantomStartingLocationXEdit);
            y = getDoubleFromHandle(handles.phantomStartingLocationYEdit);
            z = getDoubleFromHandle(handles.phantomStartingLocationZEdit);
            
            phant.location = [x,y,z];
            
            x = getDoubleFromHandle(handles.phantomVoxelDimensionsXEdit);
            y = getDoubleFromHandle(handles.phantomVoxelDimensionsYEdit);
            z = getDoubleFromHandle(handles.phantomVoxelDimensionsZEdit);
            
            phant.voxelDimensions = [x,y,z];
            
            phant.data = handles.phantomDataSet;
            
            phant.dataPath = handles.phantomDataPath;            
            phant.dataFileName = handles.phantomDataFileName;
            
            phant.savePath = handles.phantomSavePath;
            phant.saveFileName = handles.phantomSaveFileName;
        end
    end
    
end


function [vertices, faces, cData, alphaData] = createVerticesAndFaces(locationInM, voxelDimsInM, dataDims, data)
    x = locationInM(1);
    y = locationInM(2);
    z = locationInM(3);
    
    xScale = voxelDimsInM(1);
    yScale = voxelDimsInM(2);
    zScale = voxelDimsInM(3);

    numCols = dataDims(2);
    numRows = dataDims(1);
    numSlices = dataDims(3);
    
    numVertices = (numCols + 1) * (numRows + 1) * numSlices;
    numFaces = (numCols * numRows * numSlices);
    
    vertices = zeros(numVertices, 3);
    faces = zeros(numFaces, 4);
    cData = zeros(numFaces, 3);
    alphaData = zeros(numFaces, 1);
        
    % set faces
    for k=1:numSlices
        for i=1:numRows % run through rows
            for j=1:numCols % run through columns
                faceNum = ((i-1)*(numCols)) + ((k-1)*(numRows*numCols)) + j;
                
                pixelTopStart = ((i-1)*(numCols+1)) + ((k-1)*(numRows+1)*(numCols+1)) + j;
                pixelBottomStart = pixelTopStart + (numCols+1);
                
                faces(faceNum,1) = pixelTopStart; % Top-Left Vertex
                faces(faceNum,2) = pixelTopStart + 1; % Top-Right Vertex
                faces(faceNum,3) = pixelBottomStart + 1; %Bottom-Left Vertex
                faces(faceNum,4) = pixelBottomStart; % Bottom-Right Vertex
                
                dataVal = data(i,j,k);
                
                cData(faceNum,:) = [dataVal, dataVal, dataVal];
                
                if dataVal == 0
                    alphaVal = 0;
                else
                    alphaVal = Constants.Phantom_Alpha;
                end
                
                alphaData(faceNum,:) = alphaVal;
            end
        end
    end
    
    % set vertices
    for k=0:numSlices
        for i=0:numRows
            for j=0:numCols
                vertexNum = (i*(numCols+1)) + (k*(numRows+1)*(numCols+1)) + j + 1;
                
                vertices(vertexNum,1) = x + j * xScale;
                vertices(vertexNum,2) = y - i * yScale;
                vertices(vertexNum,3) = z - (k * zScale) - (zScale / 2); % -(zScale/2) centres slice in the voxel
            end
        end
    end
    
end

