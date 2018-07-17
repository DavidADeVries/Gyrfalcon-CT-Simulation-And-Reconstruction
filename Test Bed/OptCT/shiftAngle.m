function [] = shiftAngle()

from = 'F:\Thesis Raw Data\Gel 7-3\data\Gel 7-3_DATA_';
to = 'F:\Thesis Recon Data\Gel 7-3\data\Gel 7-3_DATA_';

shift = 6;

for i=1:410
    j = i + shift; 
    
    if j > 410
       j = j - 410; 
    end
    
    fromFile = [from, getNumStr(j), '.bmp'];
    toFile = [to, getNumStr(i), '.bmp'];
    
    copyfile(fromFile, toFile);
end

end

function str = getNumStr(num)
    str = num2str(num);
    
    len = length(str);
    
    for i=1:4-len
        str = ['0', str];
    end
end