function [] = runUnitTests()
%runUnitTests()

%% getVoxelCentreCoordinates
testFiles = {...
    'getVoxelCentreCoordinatesUnitTests.m',...
    'getVoxelEdgeCoordinatesUnitTests.m',...
    'getVoxelCentreAndEndEdgeCoordinatesUnitTests.m'...
    };

runtests(testFiles)


end

