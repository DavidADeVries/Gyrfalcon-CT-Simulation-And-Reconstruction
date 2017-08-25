function [] = opticalCTimport()
% [] = opticalCTimport()

loadPath = 'C:\Users\MPRadmin\Git Repos\OptCT Data\Brachy_with_cath';

dataPath = makePath(loadPath, 'data');
refPath = makePath(loadPath, 'reference');

[dataFrames, dataDarkFrame, dataXmlData] = loadOptCtFolder(dataPath);
[refFrames, refDarkFrame, refXmlData] = loadOptCtFolder(refPath);

% sub out dark frames
dataFrames = applyDarkFrame(dataFrames, dataDarkFrame);
refFrames = applyDarkFrame(refFrames, refDarkFrame);

% convert to \sigma(delta_attenuation .* distance)
deltaAttenuationFrames = -log(refFrames ./ dataFrames); % log = ln is matlab

% correct for axis of rotation (AOR) error

correction = dataXmlData.aor_offset;

deltaAttenuationFrames = applyAxisOfRotationCorrection(deltaAttenuationFrames, correction);

% interpolate to get projection data set needed for recon

% what we're aiming for
targetDetectorSize = [256, 256];
targetPixelDimsInM = [0.5/1000, 0.5/1000];

% the current configuration

% NOT NEEDED:
%ccdPixelDimsInM = [dataXmlData.ccd_horz_pixel_size, dataXmlData.ccd_vert_pixel_size];

dims = size(deltaAttenuationFrames);
detectorSize = [dims(2), dims(1)];

H_r = dataXmlData.vert_size_light;
W_r = dataXmlData.horz_size_light;

pixelsPerCm = [1024/W_r, 768/H_r];
pixelsPerM = pixelsPerCm ./ Constants.cm_to_m;

detectorPixelDimsInM = 1 ./ pixelsPerM;

sourceToAxisInCm = dataXmlData.source_to_axis;
sourceToAxisInM = sourceToAxisInCm .* Constants.cm_to_m;

axisToDetectorInCm = dataXmlData.axis_to_detector;
axisToDetectorInM = axisToDetectorInCm .* Constants.cm_to_m;

numAngles = dataXmlData.num_images;
stepSizeInDegrees = dataXmlData.stepsize;

anglesInDeg = 0:stepSizeInDegrees:(numAngles-1)*stepSizeInDegrees;

% interpolate/average to get projection data set
projectionDataSet = interpolateOptCtImagesToProjectionDataSet(...
    deltaAttenuationFrames, detectorPixelDimsInM, ...
    targetDetectorSize, targetPixelDimsInM);

end

function projectionDataSet = interpolateOptCtImagesToProjectionDataSet(frames, detectorPixelDimsInM, targetDetectorSize, targetPixelDimsInM)

frameDims = size(frames);
detectorSize = [frameDims(2), frameDims(1)];

originalLocationInM = [0 0]; %top-left corner [x,y]
originalDimsInM = detectorSize .* detectorPixelDimsInM;

targetDimsInM = targetDetectorSize .* targetPixelDimsInM;
targetLocationInM = (originalDimsInM - targetDimsInM) ./ 2; % centre it

projectionDataSet = zeros(targetDetectorSize(2), targetDetectorSize(1));

for x=1:targetDetectorSize(1)
    for y=1:targetDetectorSize(2)
        shift = [x,y];
        
        topLeftLoc = targetLocationInM + (shift-1).*targetDimsInM;
        topRightLoc = topLeftLoc + [1 0].*targetDimsInM;
        bottomLeftLoc = topLeftLoc + [0 1].*targetDimsInM;
        bottomRightLoc = topLeftLoc + [1 1].*targetDimsInM;
        
        lowestXLattice = ceil(topLeftLoc(1) ./ originalDimsInM(1));
        greatestXLattice = floor(topRightLoc(1) ./ originalDimsInM(1));
        
        lowestYLattice = ceil(topRightLoc(2) ./ originalDimsInM(2));
        greatestYLattice = floor(bottomRightLoc(2) ./ originalDimsInM(2));
        
        xPoints = (lowestXLattice:1:greatestXLattice).*originalDimsInM(1);
        
        if xPoints(1) > topLeftLoc(1)
            xPoints = [topLeftLoc(1), xPoints];
            lowestXLattice = lowestXLattice - 1;
        end
        if xPoints(end) < topRightLoc(1)
            xPoints = [xPoints, topRightLoc(1)];
            greatestXLattice = greatestXLattice + 1;
        end
          
        yPoints = (lowestYLattice:1:greatestYLattice).*originalDimsInM(2);
        
        if yPoints(1) > topRightLoc(2)
            yPoints = [topRightLoc(2), xyPoints];
            lowestYLattice = lowestYLattice - 1;
        end
        if yPoints(end) < bottomRightLoc(2)
            yPoints = [yPoints, bottomRightLoc(2)];
            greatestYLattice = greatestYLattice + 1;
        end
        
        numXPoints = length(xPoints);
        numYPoints = length(yPoints);
        
        xSideLengths = zeros(1,numXPoints-1);
        ySideLengths = zeros(1,numYPoints-1);
        
        for i=1:numXPoints-1
            xSideLengths(i) = xPoints(i+1) - xPoints(i);
        end
        for i=1:numYPoints-1
            ySideLengths(i) = yPoints(i+1) - yPoints(i);
        end
        
        [xSide,ySide] = meshgrid(xSideLengths,ySideLengths);
        
        areas = xSide .* ySide;
        
        xIndices = (lowestXLattice:1:greatestXLattice) + 1;
        yIndices = (lowestYLattice:1:greatestYLattice) + 1;
        
        [colIndex,rowIndex] = meshgrid(xIndices,yIndices);
        
        frameSelect = sub2ind(frameDims, rowIndex, colIndex);
        
        pixelVals = frames(frameSelect);
        
        totalArea = sum(sum(areas));
        
        areasNorm = totalArea ./ totalArea;
        
        weightedPixelVals = pixelVals .* areasNorm;
        
        projectionDataSet(y,x) = sum(sum(weightedPixelVals));        
    end
end


end

function frames = applyAxisOfRotationCorrection(frames, correction)

    %correction gives number of pixels to shift by, correction is negative
    %to shift to the right, positive to shift to the left
    
    if correction < 0
       frames = frames(:,1:end-correction-1,:);
    elseif correction > 0
       frames = frames(:,correction+1:end,:);
    end

end


function [frames, darkFrame, xmlData] = loadOptCtFolder(path)
    allFilesAndFolders = dir(path);
    
    numEntries = length(allFilesAndFolders);
    
    prefix = '';
    
    for i=1:numEntries
        entry = allFilesAndFolders(i);
        
        if ~entry.isdir
            indices = strfind(entry.name, '_');
            
            prefix = entry.name(1:indices(end));
            break;
        end
    end
    
    xmlData = loadOptCtXmlData2(makePath(path,[prefix,'Info.xml']));
    
    numFrames = xmlData.num_images;
    
    % load up frames
    frames = zeros(768,1024,numFrames);
    
    for i=1:numFrames
        filename = [prefix, padNumberWithLeadingZeros(i,4), '.bmp'];
        
        raw = readOptCtFrameBmp(makePath(path, filename));
        
        frames(:,:,i) = double(raw(:,:,1)); % grab just the red channel
    end
    
    % load dark frame
    
    filename = [prefix, 'dark', '.bmp'];
    
    raw = readOptCtFrameBmp(makePath(path, filename));
    
    darkFrame = double(raw(:,:,1)); % grab just the red channel
end

function image = readOptCtFrameBmp(path)
    fid = fopen(path);
    
    data = fread(fid, inf, 'uint16');
    
    fclose(fid);
    
    data = data(28:end); %strip header
    
    image = imrotate(reshape(data, [1024,768]), 90);
end

function optCtXmlData = loadOptCtXmlData(path)
    rawXml = xml2struct(path);
    
    children = rawXml.Children;
    
    optCtXmlData = struct; 
    
    for i=1:length(children)
        child = children(i);
        
        if ~isempty(child.children)
            fieldName = lower(child.Name); % lower case
            data = child.children.Data;
            
            dataAsDouble = str2double(data);
            
            if ~isnan(dataAsDouble)
                data = dataAsDouble;
            end
            
            optCtXmlData.(fieldName) = data;
        end
    end
end

function optCtXmlData = loadOptCtXmlData2(path)
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

function frames = applyDarkFrame(frames, darkFrame)
    dims = size(frames);
    
    frames = frames - repmat(darkFrame, [1,1,dims(3)]);
end