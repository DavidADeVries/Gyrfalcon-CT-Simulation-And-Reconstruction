function volume = applyCalibration(volume, cali)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

volume = cali(1) + volume .* cali(2);

end

