classdef Vista15ScannerData
    %Vista15ScannerData
    
    % holds information from a Vista 15 scanner
    
    properties
        scanDate
        scanTime
        
        numImages
        numBlackImages
        
        stepSizeInDeg
        totalAngleInDeg
        
        shutterExposureTimeInMs
        cameraGain
        frameRate
        
        sourceToAxisInM
        axisToDetectorInM
        
        sizeLightInM
        
        ccdPixelSize
        
        axisOfRotationOffsetInPx
        equatorialOffsetInPx
        
        doseSensitivity
        
        acquisitionVersion
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
    end
    
    methods
        function data = Vista15ScannerData()            
            
        end
        
        function len = getAxisToDetectorInM(data)
            len = data.axisToDetectorInM;
        end
        
        function data = loadData(data, seriesPath)
            pathSections = breakUpPath(seriesPath);
            
            data.seriesName = pathSections{end};
            
            % load-up xml
            path = makePath(seriesPath, data.getDataFrameFolderName());
            
            prefix = getFilePrefix(path);
            
            fileName = [prefix, data.getXmlLabel(), XML_File_Extension];
            
            optCtXmlData = loadOptCtXml(makePath(path, fileName));
            
            data = data.setXmlDataProperties(optCtXmlData);           
            
        end
        
        function data = setXmlDataProperties(data, xmlStruct)
            data.scanDate = xmlStruct.date;
            data.scanTime = xmlStruct.time;
            
            data.numImages = xmlStruct.num_images;
            data.numBlackImages = xmlStruct.num_blackimages;
            
            data.stepSizeInDeg = xmlStruct.stepsize;
            data.totalAngleInDeg = xmlStruct.totalangle;
            
            data.shutterExposureTimeInMs = xmlStruct.shutter_exposure_time;
            data.cameraGain = xmlStruct.camera_gain;
            data.frameRate = xmlStruct.frame_rate;
            
            data.sourceToAxisInM = xmlStruct.source_to_axis .* Constants.cm_to_m;
            data.axisToDetectorInM = xmlStruct.axis_to_detector .* Constants.cm_to_m;
            
            data.sizeLightInM = [xmlStruct.horiz_size_light, xmlStruct.vert_size_light] .* Constants.cm_to_m;
            
            data.ccdPixelSize = [xmlStruct.ccd_horiz_pixel_size, xmlStruct.ccd_vert_pixel_size];
            
            data.axisOfRotationOffsetInPx = xmlStruct.aor_offset;
            data.equatorialOffsetInPx = xmlStruct.equatorial_offset;
            
            data.doseSensitivity = xmlStruct.dose_sensitivity;
            
            data.acquisitionVersion = xmlStruct.acquisition_version;
        end
    end
    
end

% HELPER FUNCTIONS

function optCtXmlData = loadOptCtXml(path)
    rawXml = xml2struct(path);
    
    names = fieldnames(rawXml.SCANDATA);
    
    numFields = length(names);
    
    optCtXmlData = struct; 
    
    for i=1:numFields        
        fieldName = names{i};
        data = rawXml.SCANDATA.(fieldName).Text;
        
        dataAsDouble = str2double(data);
        
        if ~isnan(dataAsDouble)
            data = dataAsDouble;
        end
        
        optCtXmlData.(lower(fieldName)) = data;
    end
end