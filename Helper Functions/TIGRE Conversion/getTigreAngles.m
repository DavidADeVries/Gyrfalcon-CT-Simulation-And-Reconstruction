function tigreAnglesInRadians = getTigreAngles(gyrfalconScan)
% function tigreAnglesInRadians = getTigreAngles(gyrfalconScan)

anglesInDeg = 180 + (-gyrfalconScan.getScanAnglesInDegrees); % flip and start from opposite side for TIGRE
tigreAnglesInRadians = anglesInDeg .* Constants.deg_to_rad;

end

