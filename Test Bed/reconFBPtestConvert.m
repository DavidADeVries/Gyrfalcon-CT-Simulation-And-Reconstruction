phantSize = 50;

I = phantom(phantSize);

% I(230:270,330:370) = 1;
% I(247:253,347:353) = 0.3;

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
    projectValues = projectValues;
    
    filteredProjectionValues = projectValues;%filterProjectionValuesRedo(projectValues, 'ram-lak', true, 0.01);
    
    P(:,i) = filteredProjectionValues';
end

figure(2);
imshow(P,[],'InitialMagnification','fit');

recon = zeros(phantSize);

K = length(theta);

projLength = dims(1);
iShift = floor(projLength/2);

figure(3);
tic

display = true;
        
d = (-(phantSize-1)/2):1:((phantSize-1)/2);

[xxI, yyI] = meshgrid(1:phantSize,1:phantSize);

xx = (xxI - 1) - (phantSize-1)/2;
yy = (yyI - 1) - (phantSize-1)/2;

for k = 1:K
    ang = theta(k);
    projValues = P(:,k)';
    dims = size(P);
    projX = (0:1:dims(1)-1) - (dims(1)-1)/2;

    interp = InterpolationTypes.linear;
    interp = interp.createInterpForKnownVals(projX, projValues, true);
    
    t = xx.*cosd(ang) + yy.*sind(ang);

    tVals = ppval(interp, t);
        
    recon = recon + tVals;
    
    if display
        imshow(recon,[],'InitialMagnification','fit');
        drawnow;
    end
end

toc
recon = recon .* (pi/K);

imshow(recon,[],'InitialMagnification','fit');

figure(4);
imshow(recon-I,[],'InitialMagnification','fit');

figure(5);
imshow(recon - iRad(1:phantSize,1:phantSize),[],'InitialMagnification','fit');