function tests = solverTest
    tests = functiontests(localfunctions);
end

function fullTest(testCase)
    locationInM = [1, -2, 3];
    voxelDimsInM = [0.1, 0.2, 0.3];
    dims = [3, 4, 5];

    [actX, actY, actZ] = getVoxelEdgeCoordinates(locationInM, voxelDimsInM, dims);
    
    expX = [1, 1.1, 1.2, 1.3];
    expY = [-2, -2.2, -2.4, -2.6, -2.8];
    expZ = [3, 2.7, 2.4, 2.1, 1.8, 1.5];
    
    verifyEqual(testCase,{actX, actY, actZ},{expX, expY, expZ},'AbsTol',1E-9);
end

function smallTest(testCase)
    locationInM = [1, 2, 3];
    voxelDimsInM = [0.1, 0.2, 0.3];
    dims = [1 1 1];

    [actX, actY, actZ] = getVoxelEdgeCoordinates(locationInM, voxelDimsInM, dims);
    
    expX = [1, 1.1];
    expY = [2, 1.8];
    expZ = [3, 2.7];
    
    verifyEqual(testCase,{actX, actY, actZ},{expX, expY, expZ},'AbsTol',1E-9);
end

function noDimTest(testCase)
    locationInM = [1, 2, 3];
    voxelDimsInM = [0.1, 0.2, 0.3];
    dims = [0 0 0];

    [actX, actY, actZ] = getVoxelEdgeCoordinates(locationInM, voxelDimsInM, dims);
    
    expX = [1 1];
    expY = [2 2];
    expZ = [3 3];
    
    verifyEqual(testCase,{actX, actY, actZ},{expX, expY, expZ},'AbsTol',1E-9);
end

function noZDimTest(testCase)
    locationInM = [1, 2, 3];
    voxelDimsInM = [0.1, 0.2, 0.3];
    dims = [1 1 0];

    [actX, actY, actZ] = getVoxelEdgeCoordinates(locationInM, voxelDimsInM, dims);
    
    expX = [1, 1.1];
    expY = [2, 1.8];
    expZ = [3 3];
    
    verifyEqual(testCase,{actX, actY, actZ},{expX, expY, expZ},'AbsTol',1E-9);
end