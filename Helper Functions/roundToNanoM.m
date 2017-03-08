function roundedVal = roundToNanoM(valInM)
% roundedVal = roundToNanoM(valInM)
   roundOff = 10^8; % within 1nm
   
   roundedVal = round(valInM .* roundOff) ./ roundOff;
end

