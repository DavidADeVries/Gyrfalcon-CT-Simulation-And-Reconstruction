function [reconData, voxelDimsInMM] = loadOpticalCtVistaRecon(path)
% [reconData, voxelDimsInMM] = loadOpticalCtVistaRecon(path)

filename = getLastItemFromPath(path);

resolutionTag = filename(end-5:end-4);

switch resolutionTag
    case 'LR'
        dataSize = [64 64 64];
        voxelDimsInMM = [2 2 2];
    case 'MR'
        dataSize = [128 128 128];
        voxelDimsInMM = [1 1 1];        
    case 'HR'
        dataSize = [256 256 256];
        voxelDimsInMM = [0.5 0.5 0.5];
    case 'ER'
        dataSize = [512 512 512];
        voxelDimsInMM = [0.25 0.25 0.25];
end

fid = fopen(path, 'r');
data = fread(fid, inf, '*uint8');
fclose(fid);

offset = size(data,1) - prod(dataSize) * 4 + 1;

reconData = data(offset:end);
reconData = typecast(reconData, 'single');
reconData = swapbytes(reconData);
reconData = reshape(reconData, dataSize);

reconData = double(reconData);

% do some transforms to align with Gyrfalcon geometry
reconData = flip(reconData, 3); % top slice becomes bottom slice

% rotate 180 degree about z
% use two flips to avoid any interpolation

reconData = flip(flip(reconData, 1), 2);

% convert units from cm-1 to m-1

reconData = reconData .* (1 ./ Constants.cm_to_m);


end

