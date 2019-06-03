function filename = makeDetectorDataFileName(positionFilename)
% filename = makeDetectorDataFileName(positionFilename)
    filename = [positionFilename, ' ', Constants.Detector_Data_Filename, Constants.Matlab_File_Extension];
end