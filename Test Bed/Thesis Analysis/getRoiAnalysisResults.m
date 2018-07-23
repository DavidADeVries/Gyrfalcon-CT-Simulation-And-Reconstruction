function results = getRoiAnalysisResults(run, numColumns)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% ROIs
botMask = run.botRoiMask;
midMask = run.midRoiMask;
topMask = run.topRoiMask;

cathMask = run.cathMask;

botSlices = run.botSlices;
midSlices = run.midSlices;
topSlices = run.topSlices;

d1ProfileCoords = run.d1ProfileCoords;
d2ProfileCoords = run.d2ProfileCoords;

% allocate output
numRows = run.numRows;

results = cell(numRows, numColumns);

% run analysis and set rows
switch run.reconAlgorithm
    case 'FDK'
        disp([run.gelName, ' (FDK)']);
        
        results{1,1} = run.gelName;
        results{1,2} = run.reconAlgorithm;
        results{1,3} = boolToString(run.usedFloodFields);
        results{1,4} = boolToString(run.usedCatheterReject);
        results(1,5:7) = {'-','-','-'};
        results{1,8} = 38; % FDK recon time (from Gyrfalcon, not Vista)
        
        % load volume and calculate metrics
        volume = loadVffVolume(run.readPath, run.usedFloodFields);
        
        results(1,9:end) = getMetricsForRoi(...
            volume, run.controlVolume,...
            botMask, midMask, topMask, cathMask,...
            botSlices, midSlices, topSlices,...
            d1ProfileCoords, d2ProfileCoords);
    case 'OSC-TV'
        numIterList = run.numIterationsValues;
        subsetsList = run.numSubsetsValues;
        cList = run.cValues;
        
        counter = 1;
        
        for k=1:length(numIterList)
            numIters = numIterList{k};
            
            for j=1:length(subsetsList)
                subsets = subsetsList{j};
                
                for i=1:length(cList)
                    c = cList{i};
                    
                    reconNum = run.reconNumberStart + counter - 1;
                    
                    disp([run.gelName, ' (OSC-TV): ', num2str(reconNum)]);
                    
                    % set params
                    results{counter,1} = run.gelName;
                    results{counter,2} = run.reconAlgorithm;
                    results{counter,3} = boolToString(run.usedFloodFields);
                    results{counter,4} = boolToString(run.usedCatheterReject);
                    results{counter,5} = numIters;
                    results{counter,6} = subsets;
                    results{counter,7} = c;
                    
                    % load volumes and run times
                    [volume, timeInS] = loadGyrfalconVolume(run.readPath, reconNum, run.usedFloodFields);
                    results{counter,8} = timeInS;
                    
                    % compute metrics
                    results(counter,9:end) = getMetricsForRoi(...
                        volume, run.controlVolume,...
                        botMask, midMask, topMask, cathMask,...
                        botSlices, midSlices, topSlices,...
                        d1ProfileCoords, d2ProfileCoords);
                    
                    %update counter
                    counter = counter + 1;
                end
            end
        end     
end
end

function volume = loadVolume(path)
data = load(path);

volume = data.reconData;
end

function run = loadReconRun(path)
data = load(path);

run = data.run;
end

function volume = loadVffVolume(readPath, usedFloodFields)
if usedFloodFields
    preVolume = loadOpticalCtVistaRecon(readPath);
    postVolume = loadOpticalCtVistaRecon(strrep(readPath, 'FF-R', 'FF-D'));
    
    volume = postVolume - preVolume;
else
    volume = loadOpticalCtVistaRecon(readPath);
end
end

function string = boolToString(bool)
if bool
    string = 'Y';
else
    string = 'N';
end
end


end