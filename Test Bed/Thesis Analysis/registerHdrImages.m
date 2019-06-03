function [] = registerHdrImages()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

path = 'E:\Local Gyrfalcon Data\HDR Irradiations\Gel 6-3b\Slicer Exports\';

data = load([path, 'TPS.mat']);
tps = data.volume;
tps = imresize(tps, 2, 'nearest'); %rescale to 0.5mm

data = load([path, 'FDK.mat']);
fdk = data.volume;

data = load([path, 'OSC-TV.mat']);
osctv = data.volume;

data = load([path, 'OSC-TV_RR.mat']);
osctv_rr = data.volume;

rotTrans = [...
    0.28 0.96 -0.01	0;...
    -0.96 0.28 0 0;...
    0 0.01 1 0;....
    0 0 0 1];

lps2ras=diag([-1 -1 1 1]);
ras2lps=diag([-1 -1 1 1]);
%rotTrans=lps2ras*inv(rotTrans)*ras2lps;  

ra = imref3d(size(fdk),[0.5,128],[0.5,128],[0.5,128]);

translate = [93.204 -258.546 -180.785];

tpsOrigin = [53.361	-56.373	-120.374];

fdk = imwarp(fdk, ra, affine3d(rotTrans));

%fdk = rotateVolume(fdk, rotTrans);
osctv = rotateVolume(osctv, rotTrans);
osctv_rr = rotateVolume(osctv_rr, rotTrans);

gelDims = size(fdk);
tpsDims = size(tps);

tpsFinalVol = zeros(gelDims);


xTrans = (translate(1) - tpsOrigin(1)) ./ 2;

yTrans = (translate(2) - tpsOrigin(2)) ./ 2;
yTrans = yTrans + (gelDims(2) - tpsDims(2));
zTrans = (translate(3) - tpsOrigin(3)) ./ 2;
zTrans = zTrans + (gelDims(3) - tpsDims(3));

tpsShift = imtranslate(tps, [xTrans, -yTrans, zTrans], 'OutputView', 'full');

tpsDims = size(tpsShift);

tpsFinalVol(...
    1:min(tpsDims(1), gelDims(1)),...
    1:min(tpsDims(2), gelDims(2)),...
    1:min(tpsDims(3), gelDims(3))) =...
    tpsShift(....
    1:gelDims(1),...
    1:gelDims(2),...
    1:gelDims(3));

end

function vol = rotateVolume(vol, transMatrix)
    vol = imwarp(vol, affine3d(transMatrix));
end