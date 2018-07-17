folders = {'-76.46', '-77.34', '-78.22', '-79.1', '-79.98', '-80.86'};
comp = '-72.07';

root = 'E:\Data Files\Git Repos\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 7-3)\Slice 1\Angle ';

ref = load([root, comp, '\Position (1,1) Detector Data.mat']);
ref = ref.detectorData_I0;

for i=1:length(folders)
    data = load([root, folders{i}, '\Position (1,1) Detector Data.mat']);
    data = data.detectorData_I;
    
    figure(i);
    imshow(log(ref./data),[]);
end