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
            volume,...
            botMask, midMask, topMask, cathMask,...
            botSlices, midSlices, topSlices,...
            d1ProfileCoords, d2ProfileCoords);
    case 'OSC-TV'
        numIterList = run.numIterationsValues;
        subsetsList = run.numSubsetsValues;
        cList = run.cValues;
        
        counter = run.reconNumberStart;
        
        for k=1:length(numIterList)
            numIters = numIterList{k};
            
            for j=1:length(subsetsList)
                subsets = subsetsList{j};
                
                for i=1:length(cList)
                    c = cList{i};
                    
                    disp([run.gelName, ' (OSC-TV): ', num2str(counter)]);
                    
                    % set params
                    results{1,1} = run.gelName;
                    results{1,2} = run.reconAlgorithm;
                    results{1,3} = boolToString(run.usedFloodFields);
                    results{1,4} = boolToString(run.usedCatheterReject);
                    results{1,5} = numIters;
                    results{1,6} = subsets;
                    results{1,7} = c;
                    
                    % load volumes and run times
                    [volume, timeInS] = loadGyrfalconVolume(run.readPath, counter, run.usedFloodFields);
                    results{1,8} = timeInS;
                    
                    % compute metrics
                    results(1,9:end) = getMetricsForRoi(...
                        volume,...
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

function [volume, time] = loadGyrfalconVolume(path, reconNumber, usedFloodField)

volumePath = [path, '/Thesis Recon ', num2str(reconNumber), ' (CBCT OSC-TV)/Slices/Slice 1.mat'];
runPath = [path, '/Thesis Recon ', num2str(reconNumber), ' (CBCT OSC-TV)/Thesis Recon ', num2str(reconNumber), ' (CBCT OSC-TV).mat'];

if ~usedFloodField
    volume = loadVolume(volumePath);
    run = loadReconRun(runPath);
    
    time = run.getRunTimeInSeconds();
else
    volumePre = loadVolume(volumePath);
    volumePost = loadVolume(strrep(volumePath, 'FF-R', 'FF-D'));
    
    runPre = loadReconRun(runPath);
    runPost = loadReconRun(strrep(runPath, 'FF-R', 'FF-D'));
    
    volume = volumePost - volumePre;
    time = runPre.getRunTimeInSeconds() + runPost.getRunTimeInSeconds();
end
end