phantSize = 501;

I = phantom(phantSize);


figure(1);
imshow(I,[]);

theta = 0:1:179;

R = radon(I,theta);
tic
iRad = iradon(R,theta,'ram-lak','linear');
toc
P = zeros(size(R));

dims = size(R);

for i=1:dims(2)
    projectValues = R(:,i);
    projectValues = projectValues';
    
    filteredProjectionValues = filterProjectionValuesRedo(projectValues, 'ram-lak', true, 0.01);
    
    P(:,i) = filteredProjectionValues';
end

figure(2);
imshow(P,[],'InitialMagnification','fit');

K = length(theta);

projLength = dims(1);
iShift = floor(projLength/2);

figure(3);
tic

display = false;

recon = zeros(phantSize,phantSize,K);

% compute

d = (-phantSize/2 + 0.5):1:(phantSize/2 - 0.5);

[x,y,theta] = meshgrid(d,d,theta);

t = x.*cosd(theta) + y.*sind(theta);

i = projLength/2 + t;
iLow = floor(projLength/2 + t);
iHigh = ceil(projLength/2 + t);

iX = floor(x+(phantSize/2))+1;
iY = floor(y+(phantSize/2))+1;

validCoord = ...
    iLow < projLength & iHigh < projLength &...
    iLow > 0 & iHigh > 0 & iX > 0 &...
    iX <= phantSize & iY > 0 & iY <= phantSize;

clear iX;
clear iY;

iLow(~validCoord) = 1;
iHigh(~validCoord) = 1;

dims = size(validCoord);
len = dims(1)*dims(2);

linearIndexShift = projLength * repmat(0:K-1,len,1);
linearIndexShift = reshape(linearIndexShift,1,len*dims(3),1);

lowVals = reshape(P(reshape(iLow,1,len*dims(3),1)+linearIndexShift),dims(1),dims(2),dims(3));
highVals = reshape(P(reshape(iHigh,1,len*dims(3),1)+linearIndexShift),dims(1),dims(2),dims(3));

clear linearIndexShift;
% get vals not requiring interpolation

recon(validCoord & (iHigh == iLow)) = lowVals(validCoord & (iHigh == iLow));

% get vals requiring interpolation

temp = lowVals + (i - iLow).*((highVals - lowVals)./(iHigh - iLow));

recon(validCoord & ~(iHigh == iLow)) = temp(validCoord & ~(iHigh == iLow));
    
recon = sum(recon,3) .* (pi/K);

clear lowVals;
clear highVals;
clear iLow;
clear iHigh;
clear temp;
clear validCoord;

%end compute


toc

imshow(recon,[],'InitialMagnification','fit');

figure(4);
imshow(recon-flipud(I),[],'InitialMagnification','fit');

figure(5);
imshow(iRad,[],'InitialMagnification','fit');