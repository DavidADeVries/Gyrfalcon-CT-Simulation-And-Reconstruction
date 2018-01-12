function [imgData] = openOptCtVistaRecon(path)
% [] = openOptCtVistaRecon()

%path = 'C:\Users\MPRadmin\Git Repos\OptCT Data\FSRT1_singlespot\FSRT1_HR.vff';
%path = 'G:\__Gryfalcon Transfer\Flood Field Test (Pre, Post)\Flood Field Test (Pre, Post)_HR.vff';
%path = 'G:\__Gryfalcon Transfer\Flood Field Test (Flood, Pre)\Flood Field Test (Flood, Pre)_HR.vff';
% path = 'G:\__Gryfalcon Transfer\Flood Field Test (Flood, Post)\Flood Field Test (Flood, Post)_HR.vff';

dataSize = [256 256 256];

fid = fopen(path, 'r');
data = fread(fid, inf, '*uint8');
fclose(fid);

offset = size(data,1) - prod(dataSize) * 4 + 1;

imgData = data(offset:end);
imgData = typecast(imgData, 'single');
imgData = swapbytes(imgData);
imgData = reshape(imgData, dataSize);

% figure(30);
% 
% for i=1:dataSize(3)
%     imshow(imgData(:,:,i),[],'InitialMagnification','fit');
%     
%     pause(0.05);
% end


end

