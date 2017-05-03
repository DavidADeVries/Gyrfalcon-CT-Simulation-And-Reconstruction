function tests = solverTest
    tests = functiontests(localfunctions);
end

function thickSliceNonInterleavedSameSizeTest(testCase)
    presetSlice = [1 2 3; 4 5 6; 7 8 9];
    dataSetSlice1 = zeros(3,3,3);

    dataSetSlice1(:,:,1) = presetSlice;
    dataSetSlice1(:,:,2) = presetSlice + 9;
    dataSetSlice1(:,:,3) = presetSlice + 2*9;

    dataSetSlice2 = dataSetSlice1 + 3*9;
    dataSetSlice3 = dataSetSlice1 + 2*3*9;

    % set data for test
    reconSlices = {dataSetSlice1, dataSetSlice2, dataSetSlice3};
    sliceCentreLocationsInM = [0.3 0 -0.3];

    dataSetLocationInM = [-0.15 0.15 0.45];
    dataSetVoxelDimsInM = [0.1 0.1 0.1];
    dataSetDims = [3 3 9];

    reconSliceLocationInM = [-0.15 0.15 0];
    reconSliceVoxelDimsInM = [0.1 0.1 0.1];
    reconSliceDims = [3 3 3];

    act = reconstructDataSetFromReconstructedSlices(...
        reconSlices, sliceCentreLocationsInM,...
        dataSetLocationInM, dataSetVoxelDimsInM, dataSetDims,...
        reconSliceLocationInM, reconSliceVoxelDimsInM, reconSliceDims,...
        InterpolationTypes3D.linear);

    exp = zeros(3,3,9);
    exp(:,:,1:3) = dataSetSlice1;
    exp(:,:,4:6) = dataSetSlice2;
    exp(:,:,7:9) = dataSetSlice3;
    
    verifyEqual(testCase,act,exp,'AbsTol',1E-9);
end

function thickSliceNonInterleavedBiggerSizeNotCenteredTest(testCase)
    presetSlice = [1 2 3; 4 5 6; 7 8 9];
    dataSetSlice1 = zeros(3,3,3);

    dataSetSlice1(:,:,1) = presetSlice;
    dataSetSlice1(:,:,2) = presetSlice + 9;
    dataSetSlice1(:,:,3) = presetSlice + 2*9;

    dataSetSlice2 = dataSetSlice1 + 3*9;
    dataSetSlice3 = dataSetSlice1 + 2*3*9;

    % set data for test
    reconSlices = {dataSetSlice1, dataSetSlice2, dataSetSlice3};
    sliceCentreLocationsInM = [0.3 0 -0.3];

    dataSetLocationInM = [-0.15 0.15 0.45];
    dataSetVoxelDimsInM = [0.1 0.1 0.1];
    dataSetDims = [5 5 12];

    reconSliceLocationInM = [-0.15 0.15 0];
    reconSliceVoxelDimsInM = [0.1 0.1 0.1];
    reconSliceDims = [3 3 3];

    act = reconstructDataSetFromReconstructedSlices(...
        reconSlices, sliceCentreLocationsInM,...
        dataSetLocationInM, dataSetVoxelDimsInM, dataSetDims,...
        reconSliceLocationInM, reconSliceVoxelDimsInM, reconSliceDims,...
        InterpolationTypes3D.linear);

    exp = ones(5,5,12) * NaN;
    exp(1:3,1:3,1:3) = dataSetSlice1;
    exp(1:3,1:3,4:6) = dataSetSlice2;
    exp(1:3,1:3,7:9) = dataSetSlice3;
    
    verifyEqual(testCase,act,exp,'AbsTol',1E-9);
end

function thickSliceNonInterleavedBiggerSizeCenteredTest(testCase)
    presetSlice = [1 2 3; 4 5 6; 7 8 9];
    dataSetSlice1 = zeros(3,3,3);

    dataSetSlice1(:,:,1) = presetSlice;
    dataSetSlice1(:,:,2) = presetSlice + 9;
    dataSetSlice1(:,:,3) = presetSlice + 2*9;

    dataSetSlice2 = dataSetSlice1 + 3*9;
    dataSetSlice3 = dataSetSlice1 + 2*3*9;

    % set data for test
    reconSlices = {dataSetSlice1, dataSetSlice2, dataSetSlice3};
    sliceCentreLocationsInM = [0.3 0 -0.3];

    dataSetLocationInM = [-0.25 0.25 0.55];
    dataSetVoxelDimsInM = [0.1 0.1 0.1];
    dataSetDims = [5 5 12];

    reconSliceLocationInM = [-0.15 0.15 0];
    reconSliceVoxelDimsInM = [0.1 0.1 0.1];
    reconSliceDims = [3 3 3];

    act = reconstructDataSetFromReconstructedSlices(...
        reconSlices, sliceCentreLocationsInM,...
        dataSetLocationInM, dataSetVoxelDimsInM, dataSetDims,...
        reconSliceLocationInM, reconSliceVoxelDimsInM, reconSliceDims,...
        InterpolationTypes3D.linear);

    exp = ones(5,5,12) * NaN;
    exp(2:4,2:4,2:4) = dataSetSlice1;
    exp(2:4,2:4,5:7) = dataSetSlice2;
    exp(2:4,2:4,8:10) = dataSetSlice3;
    
    verifyEqual(testCase,act,exp,'AbsTol',1E-9);
end

function thickSliceNonInterleavedSmallerSizeCenteredTest(testCase)
    presetSlice = [1 2 3; 4 5 6; 7 8 9];
    dataSetSlice1 = zeros(3,3,3);

    dataSetSlice1(:,:,1) = presetSlice;
    dataSetSlice1(:,:,2) = presetSlice + 9;
    dataSetSlice1(:,:,3) = presetSlice + 2*9;

    dataSetSlice2 = dataSetSlice1 + 3*9;
    dataSetSlice3 = dataSetSlice1 + 2*3*9;

    % set data for test
    reconSlices = {dataSetSlice1, dataSetSlice2, dataSetSlice3};
    sliceCentreLocationsInM = [0.3 0 -0.3];

    dataSetLocationInM = [-0.15 0.15 0.15];
    dataSetVoxelDimsInM = [0.15 0.15 0.15];
    dataSetDims = [2 2 2];

    reconSliceLocationInM = [-0.15 0.15 0];
    reconSliceVoxelDimsInM = [0.1 0.1 0.1];
    reconSliceDims = [3 3 3];

    act = reconstructDataSetFromReconstructedSlices(...
        reconSlices, sliceCentreLocationsInM,...
        dataSetLocationInM, dataSetVoxelDimsInM, dataSetDims,...
        reconSliceLocationInM, reconSliceVoxelDimsInM, reconSliceDims,...
        InterpolationTypes3D.nearestNeighbour);

    exp = zeros(2,2,2);
    exp(1,1,1) = dataSetSlice2(1,1,1);
    exp(1,2,1) = dataSetSlice2(1,3,1);
    exp(2,1,1) = dataSetSlice2(3,1,1);
    exp(2,2,1) = dataSetSlice2(3,3,1);
    exp(1,1,2) = dataSetSlice2(1,1,3);
    exp(1,2,2) = dataSetSlice2(1,3,3);
    exp(2,1,2) = dataSetSlice2(3,1,3);
    exp(2,2,2) = dataSetSlice2(3,3,3);
    
    verifyEqual(testCase,act,exp,'AbsTol',1E-9);
end

function thickSliceNonInterleavedXValueTest(testCase)
    presetSlice = [1 2 3; 4 5 6; 7 8 9];
    dataSetSlice1 = zeros(3,3,3);

    dataSetSlice1(:,:,1) = presetSlice;
    dataSetSlice1(:,:,2) = presetSlice + 9;
    dataSetSlice1(:,:,3) = presetSlice + 2*9;

    dataSetSlice2 = dataSetSlice1 + 3*9;
    dataSetSlice3 = dataSetSlice1 + 2*3*9;

    % set data for test
    reconSlices = {dataSetSlice1, dataSetSlice2, dataSetSlice3};
    sliceCentreLocationsInM = [0.3 0 -0.3];

    dataSetLocationInM = [-0.2 0 0];
    dataSetVoxelDimsInM = [0.05 0 0];
    dataSetDims = [8 1 1];

    reconSliceLocationInM = [-0.15 0.15 0];
    reconSliceVoxelDimsInM = [0.1 0.1 0.1];
    reconSliceDims = [3 3 3];

    act = reconstructDataSetFromReconstructedSlices(...
        reconSlices, sliceCentreLocationsInM,...
        dataSetLocationInM, dataSetVoxelDimsInM, dataSetDims,...
        reconSliceLocationInM, reconSliceVoxelDimsInM, reconSliceDims,...
        InterpolationTypes3D.nearestNeighbour);

    exp = zeros(1,8,1);
    exp(1,1,1) = NaN;
    exp(1,2,1) = dataSetSlice2(2,1,2);
    exp(1,3,1) = dataSetSlice2(2,1,2);
    exp(1,4,1) = dataSetSlice2(2,2,2);
    exp(1,5,1) = dataSetSlice2(2,2,2);
    exp(1,6,1) = dataSetSlice2(2,3,2);
    exp(1,7,1) = dataSetSlice2(2,3,2);
    exp(1,8,1) = NaN;
    
    verifyEqual(testCase,act,exp,'AbsTol',1E-9);
end

function thickSliceNonInterleavedYValueTest(testCase)
    presetSlice = [1 2 3; 4 5 6; 7 8 9];
    dataSetSlice1 = zeros(3,3,3);

    dataSetSlice1(:,:,1) = presetSlice;
    dataSetSlice1(:,:,2) = presetSlice + 9;
    dataSetSlice1(:,:,3) = presetSlice + 2*9;

    dataSetSlice2 = dataSetSlice1 + 3*9;
    dataSetSlice3 = dataSetSlice1 + 2*3*9;

    % set data for test
    reconSlices = {dataSetSlice1, dataSetSlice2, dataSetSlice3};
    sliceCentreLocationsInM = [0.3 0 -0.3];

    dataSetLocationInM = [0 0.2 0];
    dataSetVoxelDimsInM = [0 0.05 0];
    dataSetDims = [1 8 1];

    reconSliceLocationInM = [-0.15 0.15 0];
    reconSliceVoxelDimsInM = [0.1 0.1 0.1];
    reconSliceDims = [3 3 3];

    act = reconstructDataSetFromReconstructedSlices(...
        reconSlices, sliceCentreLocationsInM,...
        dataSetLocationInM, dataSetVoxelDimsInM, dataSetDims,...
        reconSliceLocationInM, reconSliceVoxelDimsInM, reconSliceDims,...
        InterpolationTypes3D.nearestNeighbour);

    exp = zeros(8,1,1);
    exp(1,1,1) = NaN;
    exp(2,1,1) = dataSetSlice2(1,2,2);
    exp(3,1,1) = dataSetSlice2(1,2,2);
    exp(4,1,1) = dataSetSlice2(2,2,2);
    exp(5,1,1) = dataSetSlice2(2,2,2);
    exp(6,1,1) = dataSetSlice2(3,2,2);
    exp(7,1,1) = dataSetSlice2(3,2,2);
    exp(8,1,1) = NaN;
    
    verifyEqual(testCase,act,exp,'AbsTol',1E-9);
end

function thickSliceNonInterleavedZValueTest(testCase)
    presetSlice = [1 2 3; 4 5 6; 7 8 9];
    dataSetSlice1 = zeros(3,3,3);

    dataSetSlice1(:,:,1) = presetSlice;
    dataSetSlice1(:,:,2) = presetSlice + 9;
    dataSetSlice1(:,:,3) = presetSlice + 2*9;

    % set data for test
    reconSlices = {dataSetSlice1};
    sliceCentreLocationsInM = 0;

    dataSetLocationInM = [0 0 0.2];
    dataSetVoxelDimsInM = [0 0 0.05];
    dataSetDims = [1 1 8];

    reconSliceLocationInM = [-0.15 0.15 0];
    reconSliceVoxelDimsInM = [0.1 0.1 0.1];
    reconSliceDims = [3 3 3];

    act = reconstructDataSetFromReconstructedSlices(...
        reconSlices, sliceCentreLocationsInM,...
        dataSetLocationInM, dataSetVoxelDimsInM, dataSetDims,...
        reconSliceLocationInM, reconSliceVoxelDimsInM, reconSliceDims,...
        InterpolationTypes3D.nearestNeighbour);

    exp = zeros(1,1,8);
    exp(1,1,1) = NaN;
    exp(1,1,2) = dataSetSlice1(2,2,1);
    exp(1,1,3) = dataSetSlice1(2,2,1);
    exp(1,1,4) = dataSetSlice1(2,2,2);
    exp(1,1,5) = dataSetSlice1(2,2,2);
    exp(1,1,6) = dataSetSlice1(2,2,3);
    exp(1,1,7) = dataSetSlice1(2,2,3);
    exp(1,1,8) = NaN;
    
    verifyEqual(testCase,act,exp,'AbsTol',1E-9);
end

function thickSliceInterleavedTest(testCase)
    presetSlice = [1 2 3; 4 5 6; 7 8 9];
    dataSetSlice1 = zeros(3,3,3);

    dataSetSlice1(:,:,1) = presetSlice;
    dataSetSlice1(:,:,2) = presetSlice + 9;
    dataSetSlice1(:,:,3) = presetSlice + 2*9;

    dataSetSlice2 = dataSetSlice1 + 3*9;
    dataSetSlice3 = dataSetSlice1 + 2*3*9;

    % set data for test
    reconSlices = {dataSetSlice1, dataSetSlice2, dataSetSlice3};
    sliceCentreLocationsInM = [0.15 0 -0.45];

    dataSetLocationInM = [-0.15 0.15 0.525];
    dataSetVoxelDimsInM = [0.1 0.1 0.15];
    dataSetDims = [3 3 9];

    reconSliceLocationInM = [-0.15 0.15 0.45];
    reconSliceVoxelDimsInM = [0.1 0.1 0.3];
    reconSliceDims = [3 3 3];

    act = reconstructDataSetFromReconstructedSlices(...
        reconSlices, sliceCentreLocationsInM,...
        dataSetLocationInM, dataSetVoxelDimsInM, dataSetDims,...
        reconSliceLocationInM, reconSliceVoxelDimsInM, reconSliceDims,...
        InterpolationTypes3D.linear);

    exp = zeros(3,3,9);
    exp(:,:,1) = dataSetSlice1(:,:,1);
    exp(:,:,2) = dataSetSlice2(:,:,1);
    exp(:,:,3) = dataSetSlice1(:,:,2);
    exp(:,:,4) = dataSetSlice2(:,:,2);
    exp(:,:,5) = (dataSetSlice1(:,:,3) + dataSetSlice3(:,:,1))./2; %due to overlapping slices
    exp(:,:,6) = dataSetSlice2(:,:,3);
    exp(:,:,7) = dataSetSlice3(:,:,2);
    exp(:,:,8) = (dataSetSlice3(:,:,2) + dataSetSlice3(:,:,3))./2; %due to linear interpolation between data slices
    exp(:,:,9) = dataSetSlice3(:,:,3);
    
    verifyEqual(testCase,act,exp,'AbsTol',1E-9);
end