function [botMask, midMask, topMask, botSlices, midSlices, topSlices, d1ProfileCoords, d2ProfileCoords] = getRoiVolumeMasks()
%[botMask, midMask, topMask] = getRoiVolumeMasks()

imageTemplate = zeros(256);

botMask = false(256,256,216);
midMask = false(256,256,216);
topMask = false(256,256,216);

topSlices = 13:77;
midSlices = 78:142;
botSlices = 143:207;

squareRowCoords = [85,122,171,134]-1;
squareColCoords = [124,173,135,86]-1;

sliceRoiMask = roipoly(imageTemplate, squareColCoords, squareRowCoords);

for i=1:64
    botMask(:,:,botSlices(i)) = sliceRoiMask;
    midMask(:,:,midSlices(i)) = sliceRoiMask;
    topMask(:,:,topSlices(i)) = sliceRoiMask;
end

d1ProfileCoords = [112, 114; 80, 90];
d2ProfileCoords = [115, 145; 90, 177];

end

