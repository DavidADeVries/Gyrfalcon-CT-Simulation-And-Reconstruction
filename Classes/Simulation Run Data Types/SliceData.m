classdef SliceData
    % SliceData
    % Holds data for the imaging of a slice
    %
    % *angleData
    % a cell array, with each index containing an AngleData class type
    %
    % *slicePosition
    % the position in m (along the z-axis) of the slice. Slice positioning
    % purely gives the z position that source and detector positioning will
    % be based off (z dimensions/positioning) is symmetrical about the
    % xy-plane at the z-position
    
    properties
        angleData
        slicePosition
    end
    
    methods
        function data = SliceData(angleData, slicePosition)
            if nargin ~= 0
                data.angleData = angleData;
                data.slicePosition = slicePosition;
            end
        end
        
        function data = clearBeforeSave(data)
            for i=1:length(data.angleData)
                data.angleData{i} = data.angleData{i}.clearBeforeSave();
            end
        end
        
        function sliceData = loadData(sliceData, basePath, simulation)                         
            angles = simulation.scan.getScanAnglesInDegrees();
            numAngles = length(angles);
                        
            angleData = cell(1, numAngles);
                        
            for i=1:numAngles
                angleFolder = makeAngleFolderName(angles(i));
                
                path = makePath(basePath, angleFolder);
                
                data = AngleData;
                
                data = data.loadData(path, simulation);
                
                angleData{i} = data;
            end
            
            sliceData.angleData = angleData;
                           
        end
          
        function firstGenData = compileProjectionDataFor1stGenRecon(data)
            angles = data.angleData;

            numAngles = length(angles);
            
            if numAngles > 0
                numDetectors = length(angles{1}.positionData{1}.detectorData);
                
                firstGenData = zeros(numDetectors, numAngles);
                
                for i=1:numAngles
                    firstGenData(:,i) = angles{i}.compileProjectionDataFor1stGenRecon();
                end
            else
                firstGenData = [];
            end
        end
    end
    
end

