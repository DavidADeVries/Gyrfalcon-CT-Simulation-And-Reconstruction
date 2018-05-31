function image = readOptCtFrameBmp(path)
    fid = fopen(path);
    
    data = fread(fid, inf, 'uint16');
    
    fclose(fid);
    
    data = data(28:end); %strip header
    
    image = imrotate(reshape(data, [1024,768]), 90);
end
