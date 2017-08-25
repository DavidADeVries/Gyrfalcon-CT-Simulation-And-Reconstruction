function filename = makeRayExclusionMapFileName(positionFilename)
% filename = makeRayExclusionMapFileName(positionFilename)
    filename = [positionFilename, ' ', Constants.Ray_Exclusion_Map_File_Name, Constants.Matlab_File_Extension];
end