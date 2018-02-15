function [] = renameFiles()
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

path = 'E:\Data Files\Git Repos\OptCT Data\Two Jar Test (With Cath - Pre)\data\';

oldPrefix = 'Two Jar Test (With Cath)_REF_';
newPrefix = 'Two Jar Test (With Cath - Pre)_DATA_';

for i=1:410
    numString = getNumString(i);
    
    oldFilename = [oldPrefix, numString, '.bmp'];
    newFilename = [newPrefix, numString, '.bmp'];
    
    movefile([path, oldFilename], [path, newFilename]);
end

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