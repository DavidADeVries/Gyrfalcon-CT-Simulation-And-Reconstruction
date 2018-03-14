classdef AngleData
    % AngleData
    % Holds data for an angle from a simulation run        
    %
    % *PositionData
    % for each angle, there are multiple potential source positions, held
    % in a cell array each holding a PositionData class data type
    %
    % *Angle
    % the angle (in degrees) at which the angle data was collected at
   
    
    properties
        positionData
        angle
    end
    
    methods
        function data = AngleData(positionData, angle)
            if nargin ~= 0
                data.positionData = positionData;
                data.angle = angle;
            end
        end
        
        function data = clearBeforeSave(data)
            dims = size(data.positionData);
            
            for i=1:dims(1)
                for j=1:dims(2)
                    data.positionData{i,j} = data.positionData{i,j}.clearBeforeSave();
                end
            end
        end
        
        function angleData = loadData(angleData, basePath, simulation)
            numPositions = simulation.scan.perAngleTranslationDimensions();
            
            isScanMosiac = simulation.isScanMultiplePositionMosiac();
            
            
            if isScanMosiac
                positionName = makePositionName(0, 0, isScanMosiac);
                positionFileName = makePositionFileName(positionName);
                
                path = makePath(basePath, positionFileName);
                
                data = PositionData;
                
                data = data.loadData(path);
                
                positionData = {data};
            else
                positionData = cell(numPositions);
                
                for xy=1:numPositions(1) %in xy
                    for z=1:numPositions(2) % in z
                        positionName = makePositionName(z, xy, isScanMosiac);
                        
                        path = makePath(basePath, positionName);
                        
                        data = PositionData;
                        
                        data = data.loadData(path);
                        
                        positionData{xy,z} = data;
                    end
                end
            end
            
            angleData.positionData = positionData;
        end
          
        function firstGenDataColumn = compileProjectionDataFor1stGenRecon(data)
            allPositionsData = data.positionData{1};
            
            firstGenDataColumn = (allPositionsData.detectorData)';
        end
    end
    
end

