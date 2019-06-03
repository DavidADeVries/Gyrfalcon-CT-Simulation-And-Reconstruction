function imgData = openOptCtVistaRecon(path)
% [] = openOptCtVistaRecon()



dataSize = [256 256 256];

fid = fopen(path, 'r');
data = fread(fid, inf, '*uint8');
fclose(fid);

offset = size(data,1) - prod(dataSize) * 4 + 1;

imgData = data(offset:end);
imgData = typecast(imgData, 'single');
imgData = swapbytes(imgData);
imgData = reshape(imgData, dataSize);



end

