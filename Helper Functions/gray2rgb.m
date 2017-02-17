function rgbData = gray2rgb(imData)
%rgbData = gray2rgb(imData)

dims = size(imData);

rgbData = zeros(dims(1),dims(2),3);

rgbData(:,:,1) = imData;
rgbData(:,:,2) = imData;
rgbData(:,:,3) = imData;


end

