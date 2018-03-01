function [nDetector, dDetector, sDetector] = getTigreDetectorValues(gyrfalconDetector)
%function [nDetector, dDetector, sDetector] = getTigreDetectorValues(gyrfalconDetector)

nDetector = (gyrfalconDetector.wholeDetectorDimensions)';
dDetector = (gyrfalconDetector.getSingleDetectorDimensionsInM * Constants.m_to_mm)';
sDetector = nDetector .* dDetector;

end

