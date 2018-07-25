folders = {'-256.64', '-257.52', '-258.4', '-259.28', '-260.16', '-261.04'};
comp = '-252.25';

root = 'E:\Data Files\Git Repos\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 7-3 Offset Finder)\Slice 1\Angle ';

ref = load([root, comp, '\Position (1,1) Detector Data.mat']);
ref = ref.detectorData_I0;

for i=1:length(folders)
    data = load([root, folders{i}, '\Position (1,1) Detector Data.mat']);
    data = data.detectorData_I;
    
    figure(i);
    imshow(log(ref./data),[]);
end