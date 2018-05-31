function [] = bulkVista15ScanRename(path, folderNames)
%Takes in path and folder names of Vista 15 scans (e.g. have a data and
%reference folder in them). It then will rename all files to match the
%folder names and whether they're in a reference or data folder.
%Main use is when mixing different scans (e.g. one reference scan, and then
%a couple of different data scans, flood fields, etc.)

refFolder = 'reference';
dataFolder = 'data';

refTag = '_REF_';
dataTag = '_DATA_';

% used if only a limited number of Flood Fields are taken. If there are
% less flood fields than the number below, it'll copy them sequentially to
% fill up the needed frames.
numOfFrames = 410;
frameFileExtension = '.bmp';

for i=1:length(folderNames)
    folderName = folderNames{i};
    
    % ref file rename
    renameFiles(path, folderName, refTag, dataTag, numOfFrames, frameFileExtension,...
        refTag, refFolder);
    renameFiles(path, folderName, refTag, dataTag, numOfFrames, frameFileExtension,...
        dataTag, dataFolder);
    
end


end

% HELPER FUNCTIONS
function suffix = extractSuffix(filename, refTag, dataTag)
    index = strfind(filename, refTag);
    len = length(refTag);
    
    if isempty(index)
        index = strfind(filename, dataTag);
        len = length(dataTag);
        
        if isempty(index)
            error('Invalid filename');
        end
    end
    
    suffix = filename(index(1)+len : end);
end

function frameNumber = parseFrameNumberFromSuffix(suffix)
    if isstrprop(suffix(1), 'digit')
        frameNumber = str2double(suffix(1:4));
    else
        frameNumber = [];
    end
        
end

function str = makeFrameNumString(num)
    str = num2str(num);
    
    for i=1:4-length(str)
        str = ['0', str];
    end
end

function [] = renameFiles(path, folderName, refTag, dataTag, numOfFrames, frameFileExtension, renameTag, renameFolder)

folderPath = makePath(path, folderName, renameFolder);
files = dir(folderPath);

frameCounter = 0;

for i=1:length(files)
    if ~files(i).isdir
        filename = files(i).name;
        
        suffix = extractSuffix(filename, refTag, dataTag);
        
        frameNumber = parseFrameNumberFromSuffix(suffix);
        
        if ~isempty(frameNumber)
            frameCounter = frameCounter + 1;
        end
        
        oldPath = makePath(folderPath, filename);
        newPath = makePath(folderPath, [folderName, renameTag, suffix]);
        
        if ~strcmp(oldPath, newPath)
            movefile(oldPath, newPath);
        end
    end
end

if frameCounter < numOfFrames % not enough frames (mostly likely a quick flood field acquisition, so copy existing frames to fill out the rest)
    copyCounter = 0;
    
    for i=frameCounter + 1:numOfFrames
        oldPath = makePath(folderPath, [folderName, renameTag, makeFrameNumString(mod(copyCounter, frameCounter)+1), frameFileExtension]);
        newPath = makePath(folderPath, [folderName, renameTag, makeFrameNumString(i), frameFileExtension]);
        
        copyfile(oldPath, newPath);
        
        copyCounter = copyCounter + 1;
    end
end

end