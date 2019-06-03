function [projectionData] = correctProjectionData(projectionData)
%[projectionData] = correctProjectionData(projectionData)

projectionData(projectionData < 1) = 1;

end

