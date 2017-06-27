function [] = opticalCTimport()
% [] = opticalCTimport()

loadPath = 'C:\Users\MPRadmin\Git Repos\OptCT Data\FSRT1_singlespot';

dataPath = makePath(loadPath, 'data');
refPath = makePath(loadPath, 'reference');

[dataFrames, dataDarkFrame, dataXmlData] = loadOptCtFolder(dataPath);
[refFrames, refDarkFrame, refXmlData] = loadOptCtFolder(refPath);

% sub out dark frames
dataFrames = applyDarkFrame(dataFrames, dataDarkFrame);
refFrames = applyDarkFrame(refFrames, refDarkFrame);

% convert to \sigma(delta_attenuation .* distance)
deltaAttenuationFrames = log(refFrames ./ dataFrames); % log = ln is matlab



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
    
    xmlData = loadOptCtXmlData(makePath(path,prefix,'Info.xml'));
    
    numFrames = xmlData.num_images;
    
    % load up frames
    frames = cell(numFrames,1);
    
    for i=1:numFrames
        filename = [prefix, padNumberWithLeadingZeros(i,4), '.bmp'];
        
        raw = imread(makePath(path, filename));
        
        frames{i} = raw(:,:,1); % grab just the red channel
    end
    
    % load dark frame
    
    filename = [prefix, 'dark', '.bmp'];
    
    raw = imread(makePath(path, filename));
    
    darkFrame = raw(:,:,1); % grab just the red channel
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

function frames = applyDarkFrame(frames, darkFrame)
    for i=1:length(frames)
        frames{i} = frames{i} - darkFrame;
    end
end