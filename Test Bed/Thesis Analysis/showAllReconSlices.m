function [] = showAllReconSlices(folderPath, sliceNum, imageDisplayRange, reconCutoff)
%[] = showAllReconSlices(folderPath, sliceNum, imageDisplayRange)

dirList = dir(folderPath);

match = 'Recon';

for i=1:length(dirList)
    entry = dirList(i);
    
    if entry.isdir && strcmp(match, entry.name(1:min(length(match),length(entry.name))))
        splits = strsplit(entry.name, ' ');
        
        reconNum = str2double(splits{2});
        
        if reconNum >= reconCutoff
            h = figure(reconNum);
            h.Name = entry.name;
            
            data = load(makePath(folderPath, entry.name, 'Slices', 'Slice 1.mat'));
            reconData = data.reconData;
            
            imshow(reconData(:,:,sliceNum), imageDisplayRange);
            
            drawnow;
        end
    end
end

end

