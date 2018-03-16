function [nDetector, dDetector, sDetector] = getTigreDetectorValues(gyrfalconReconstruction)
%function [nDetector, dDetector, sDetector] = getTigreDetectorValues(gyrfalconReconstruction)

nDetector = (gyrfalconReconstruction.processingWholeDetectorDimensions)';
dDetector = (gyrfalconReconstruction.getSingleDetectorDimensionsInM() * Constants.m_to_mm)';
sDetector = nDetector .* dDetector;

end

