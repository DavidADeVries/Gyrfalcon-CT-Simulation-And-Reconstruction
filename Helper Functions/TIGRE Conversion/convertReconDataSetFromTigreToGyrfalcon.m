function reconDataSet = convertReconDataSetFromTigreToGyrfalcon(reconDataSet)
%reconDataSet = convertReconDataSetFromTigreToGyrfalcon(reconDataSet)

reconDataSet = double(reconDataSet); %first convert to double from single

reconDataSet = reconDataSet .* (1 / Constants.mm_to_m); % convert from mm-1 attenuation units to m-1 attentuation units


end

