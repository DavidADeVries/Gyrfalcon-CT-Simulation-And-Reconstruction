classdef Vista16ScannerData
    %Vista15ScannerData
    
    % holds information from a Vista 16 scanner
    
    properties
        seriesName
        
        numImages
        stepSizeInDeg
        
        shutterExposureTimeInMs
        frameRate
        
        sourceToAxisInM
        axisToDetectorInM
        sizeLightInM
        
        axisOfRotationOffsetInPx
        equatorialOffsetInPx
      
    end
    
    methods (Static)
        function dims = getRawImageDimensions()
            dims = [1024, 768]; % x (width) by y (height)
        end
        
        function name = getReferenceFrameFolderName()
            name = 'reference';
        end
        
        function name = getDataFrameFolderName()
            name = 'data';
        end
                
        function num = getNumDigitsInFrameNumbering()
            num = 4;
        end
        
        function label = getDarkFrameLabel()
            label = 'dark';
        end
        
        function label = getXmlLabel()
            label = 'Info';
        end
        
        function label = getCsvLabel()
            label = 'Info';
        end 
    end
    
    methods
        function data = Vista16ScannerData()            
            
        end
        
        function numAngles = getNumAngles(data)
            numAngles = data.numImages;
        end
        
        function spacingInDeg = getAngleSpacingInDeg(data)
            spacingInDeg = data.stepSizeInDeg;
        end
        
        function len = getAxisToSourceInM(data)
            len = data.sourceToAxisInM;
        end
        
        function len = getAxisToDetectorInM(data)
            len = data.axisToDetectorInM;
        end
        
        function dimsInM = getDetectorPixelDimensionsInM(data)
            sizeLightInM = data.sizeLightInM;
            numPixels = data.getRawImageDimensions();
            
            pixelsPerM = numPixels ./ sizeLightInM;
            
            dimsInM = 1 ./ pixelsPerM;
        end
        
        function data = loadData(data, seriesPath)
            pathSections = breakUpPath(seriesPath);
            
            data.seriesName = pathSections{end};

             % load up CSV
             path = makePath(seriesPath, data.getDataFrameFolderName());
             
             fileName = [data.getCsvLabel(), '.csv'];
             
             optCtCsvData = loadOptCtCsv(makePath(seriesPath, fileName));
             
             data = data.setCsvDataProperties(optCtCsvData);
             
            
        end
        
        function data = setCsvDataProperties(data, csvStruct)
            referenceProjections = {csvStruct.Reference_Projections};
            stepSize = {csvStruct.Delta_Theta};
            shutterSpeed = {csvStruct.Shutter_Speed};
            frameRate = {csvStruct.Frame_Rate};
            sourceAxisDis = {csvStruct.Source_Axis_Distance};
            axisDetectorDis = {csvStruct.Axis_Detector_Distance};
            horizontalLightSize = {csvStruct.Horizontal_Light_Size};
            verticalLightSize = {csvStruct.Vertical_Light_Size};
            axisOfRotation = {csvStruct.Axis_of_Rotation_Offset};
            equatorialDistance = {csvStruct.Equatorial_Distance};
            
            data.numImages = str2double(cell2mat(referenceProjections(1)));
            
            data.stepSizeInDeg = str2double(cell2mat(stepSize(1)));
          
            data.shutterExposureTimeInMs = str2double(cell2mat(shutterSpeed(1)));
            data.frameRate = str2double(cell2mat(frameRate(1)));
            
            data.sourceToAxisInM = str2double(cell2mat(sourceAxisDis(1))) .* Constants.cm_to_m;
            data.axisToDetectorInM = str2double(cell2mat(axisDetectorDis(1))) .* Constants.cm_to_m;
            
            data.sizeLightInM = [str2double(cell2mat(horizontalLightSize(1))) , str2double(cell2mat(verticalLightSize(1)))] .* Constants.cm_to_m;
            
            data.axisOfRotationOffsetInPx = str2double(cell2mat(axisOfRotation(1)));
            data.equatorialOffsetInPx = str2double(cell2mat(equatorialDistance(1)));
            
        end 
        
    end
    
end

% HELPER FUNCTIONS

function optCtCsvData = loadOptCtCsv(path)
    T = readtable(path, 'ReadVariableNames', false, 'HeaderLines', 2, 'ReadRowNames', true);
    
    numFields = height(T);
    
    temp = cell2table(table2cell(T)');

    for i = 1:numFields
      str = string(T.Properties.RowNames(i));
      while contains(str, ' ')
          str = strrep(str, ' ', '_');
      end 
      temp.Properties.VariableNames(i) = cellstr(str);
    end 
    
    optCtCsvData = table2struct(temp);
end 
