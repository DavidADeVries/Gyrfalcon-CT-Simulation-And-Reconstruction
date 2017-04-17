% SET DATA

presetSlice = [1 2 3; 4 5 6; 7 8 9];
interpolationType = InterpolationTypes3D.nearestNeighbour; % not too concerned about the interpolation type as Matlab is handling that

equalMargin = 1E-9;

% THICK SLICE TEST, NON INTERLEAVED, SAME SIZE AT DATASET

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

reconDataSet = reconstructDataSetFromReconstructedSlices(...
    reconSlices, sliceCentreLocationsInM,...
    dataSetLocationInM, dataSetVoxelDimsInM, dataSetDims,...
    reconSliceLocationInM, reconSliceVoxelDimsInM, reconSliceDims,...
    InterpolationTypes3D.linear);

reconDataSetExpected = zeros(3,3,9);
reconDataSetExpected(:,:,1:3) = dataSetSlice1;
reconDataSetExpected(:,:,4:6) = dataSetSlice2;
reconDataSetExpected(:,:,7:9) = dataSetSlice3;

testPassed = matricesEqualWithinMargin(reconDataSet, reconDataSetExpected, equalMargin);

disp(['Thick Slice Test, Non-Interleaved, Same Size Test: ', convertBoolToYesNo(testPassed)]);

% THICK SLICE TEST, NON INTERLEAVED, BIGGER SIZE THAN DATASET, NOT CENTRED

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

reconDataSet = reconstructDataSetFromReconstructedSlices(...
    reconSlices, sliceCentreLocationsInM,...
    dataSetLocationInM, dataSetVoxelDimsInM, dataSetDims,...
    reconSliceLocationInM, reconSliceVoxelDimsInM, reconSliceDims,...
    interpolationType);

reconDataSetExpected = zeros(3,3,9);
reconDataSetExpected(:,:,1:3) = dataSetSlice1;
reconDataSetExpected(:,:,4:6) = dataSetSlice2;
reconDataSetExpected(:,:,7:9) = dataSetSlice3;

testPassed = matricesEqualWithinMargin(reconDataSet, reconDataSetExpected, equalMargin);

disp(['Thick Slice Test, Non-Interleaved, Bigger Size Test 1: ', convertBoolToYesNo(testPassed)]);

