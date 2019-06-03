function [] = displayAllRecons()
%function [] = displayAllRecons()

path = 'E:\Data Files\Git Repos\Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (CATH 002 With Catheter-Test)';

slice = 70;
figureNumber = 100;

tag = 'Recon';

dirEntries = dir(path);

for i=1:length(dirEntries)
    entry = dirEntries(i);
    
    if entry.isdir && ~isempty(strfind(entry.name, tag))
        name = entry.name;
        
        loadPath = makePath(path, name, 'Slices', 'Slice 1.mat');
        data = load(loadPath);
        reconData = data.reconData;
        
        h = figure(figureNumber);
        h.Name = name;
        imshow(reconData(:,:,slice), []);
        
        figureNumber = figureNumber + 1;
    end
end


end

