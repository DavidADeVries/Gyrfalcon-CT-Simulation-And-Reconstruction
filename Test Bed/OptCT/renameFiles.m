function [] = renameFiles()
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

path = 'G:\CATH 002 With Catheter Ref\reference\';

oldPrefix = 'CATH 002 Flood Field_REF_';
newPrefix = 'CATH 002 With Catheter Ref_REF_';

for i=1:410
    numString = getNumString(i);
    
    oldFilename = [oldPrefix, numString, '.bmp'];
    newFilename = [newPrefix, numString, '.bmp'];
    
    movefile([path, oldFilename], [path, newFilename]);
end

movefile([path, oldPrefix, 'Info.xml'], [path, newPrefix, 'Info.xml']);
movefile([path, oldPrefix, 'dark.bmp'], [path, newPrefix, 'dark.bmp']);

end

function str = getNumString(num)
    numStr = num2str(num);
    
    if length(numStr) == 1
        str = ['000', numStr];
    elseif length(numStr) == 2
        str = ['00', numStr];        
    elseif length(numStr) == 3
        str = ['0', numStr];            
    end
end