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
            data.angleData = angleData;
            data.slicePosition = slicePosition;
        end
        
        function data = clearBeforeSave(data)
            for i=1:length(data.angleData)
                data.angleData{i} = data.angleData{i}.clearBeforeSave();
            end
        end
    end
    
end

