function [volume, time] = loadGyrfalconVolume(path, reconNumber, usedFloodField)

volumePath = [path, '/Thesis Recon [2] ', num2str(reconNumber), ' (CBCT OSC-TV)/Slices/Slice 1.mat'];
runPath = [path, '/Thesis Recon [2] ', num2str(reconNumber), ' (CBCT OSC-TV)/Thesis Recon [2] ', num2str(reconNumber), ' (CBCT OSC-TV).mat'];

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




function volume = loadVolume(path)
data = load(path);

volume = data.reconData;
end

function run = loadReconRun(path)
data = load(path);

run = data.run;
end