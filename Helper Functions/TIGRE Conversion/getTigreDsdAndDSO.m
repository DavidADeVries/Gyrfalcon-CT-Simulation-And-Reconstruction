function [DSD, DSO] = getTigreDsdAndDSO(gyrfalconSource, gyrfalconDetector)
%function [DSD, DSO] = getTigreDsdAndDSO(gyrfalconSource, gyrfalconDetector)

originToSourceInM = gyrfalconSource.getDistanceBetweenOriginAndSourceCentrePointInM();
originToDetectorInM = gyrfalconDetector.getDistanceBetweenOriginAndDetectorCentrePointInM();

% distances
DSD = (originToSourceInM + originToDetectorInM) * Constants.m_to_mm;
DSO = originToSourceInM * Constants.m_to_mm;

end

