folders = {'-357.71', '-358.59', '-359.47', '0', '-0.88', '-1.76', '-2.64', '-3.52', '-4.39', '-5.27', '-6.15', '-7.03', '-7.91', '-8.79', '-9.67', '-10.55', '-11.43', '-12.3', '-13.18', '-14.06', '-14.94'};
comp = '0';

root = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 6-4)\Slice 1\Angle ';

ref = load([root, comp, '\Position (1,1) Detector Data.mat']);
ref = imtranslate(ref.detectorData_I0, [-10,0]);

for i=1:length(folders)
    data = load([root, folders{i}, '\Position (1,1) Detector Data.mat']);
    data = data.detectorData_I;
    
    figure(i);
    imshow(log(ref./data),[]);
end