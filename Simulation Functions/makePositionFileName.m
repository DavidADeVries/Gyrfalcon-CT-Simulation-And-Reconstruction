function filename = makePositionFileName(positionFilename)
% filename = makePositionFileName(positionFilename)
    filename = [positionFilename, ' ', Constants.Detector_Data_Filename, Constants.Matlab_File_Extension];
end