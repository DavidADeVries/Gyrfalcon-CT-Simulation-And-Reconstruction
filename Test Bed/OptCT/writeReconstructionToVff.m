function [] = writeReconstructionToVff(data_invM, path, additionalFlips)
%[] = writeReconstructionToVff(reconRun, path)

data_invCm = data_invM .* (1 ./ Constants.m_to_cm); %convert from 1/m to 1/cmn (for vff)

% rotate 180 degree about z
% use two flips to avoid any interpolation
if ~additionalFlips(1)
    data_invCm = flip(data_invCm, 1);
end

if ~additionalFlips(2)
    data_invCm = flip(data_invCm, 2);
end

if ~additionalFlips(3)
    data_invCm = flip(data_invCm, 3); % top slice becomes bottom slice
end

dims = size(data_invCm);

voxelDims_mm = [0.5 0.5 0.5];

% open file
fid = fopen(path, 'w');

% write header information
fprintf(fid, 'ncaa;\n');
fprintf(fid, 'rank=3;\n');
fprintf(fid, 'type=raster;\n');
fprintf(fid, 'format=slice;\n');
fprintf(fid, 'bits=32;\n');
fprintf(fid, 'bands=1;\n');
fprintf(fid, 'size=%d %d %d;\n', dims);
fprintf(fid, 'spacing=0.5 0.5 0.5;\n');
fprintf(fid, 'origin=0 0 0;\n');
fprintf(fid, 'rawsize=%d;\n', 4*prod(dims)); %size of data is 4 bytes per value * number of values in 3D data set
fprintf(fid, 'data_scale=1;\n');
fprintf(fid, 'data_offset=0;\n');
fprintf(fid, 'HandleScatter=Factor;\n');
fprintf(fid, 'ReferenceScatterFactor=1;\n');
fprintf(fid, 'DataScatterFactor=1;\n');
fprintf(fid, 'filter = 0');
fprintf(fid, 'cos param A = 0.54;\n');
fprintf(fid, 'cos param B = 0.46;\n');
fprintf(fid, 'title=%s;\n', path);
fprintf(fid, 'date=%s;\n', datestr(now));
fprintf(fid,'\f\n');

% write data
writeData = single(data_invCm); % ensure data is in single format
writeData = reshape(writeData, [numel(writeData),1]); %single vector (no 3D)
writeData = swapbytes(writeData); %little/big endian switch
writeData = typecast(writeData, 'uint8'); % split 32 bit single, into 4x8bit uint8s for writing to file

fwrite(fid, writeData);


% close file
fclose(fid);

end

