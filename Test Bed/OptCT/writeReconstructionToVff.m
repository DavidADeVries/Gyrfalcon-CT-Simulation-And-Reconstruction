function [] = writeReconstructionToVff()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

data_invCm = [];

dims = size(data_invCm);

voxelDims_mm = [];

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
fprintf(fid, 'spacing=%d %d %d;\n', voxelDims_mm);
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


% close file
fclose(fid);

end

