classdef AnalysisRun
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    
    
    properties
        gelName = '';
        reconAlgorithm = ''; %'FDK' or 'OSC-TV'
        
        usedFloodFields = false;
        usedCatheterReject = false;
        
        catheterCoordsFile = '';
        
        reconNumberStart = 1
        
        numIterationsValues = {};
        numSubsetsValues = {};
        cValues = {};

        botRoiMask
        midRoiMask
        topRoiMask
        
        botSlices
        midSlices
        topSlices

        cathMask
        
        d1ProfileCoords
        d2ProfileCoords
        
        controlVolume
        
        readPath = ''
        controlPath = ''
    end
    
    methods
        function num = numRows(obj)
            switch obj.reconAlgorithm
                case 'FDK'
                    num = 1;
                case 'OSC-TV'
                    num = length(obj.numIterationsValues) * length(obj.numSubsetsValues) * length(obj.cValues);
            end
        end
    end
    
end

