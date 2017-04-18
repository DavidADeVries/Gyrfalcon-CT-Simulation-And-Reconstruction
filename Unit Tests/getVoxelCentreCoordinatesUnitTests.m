function tests = solverTest
    tests = functiontests(localfunctions);
end

function fullTest(testCase)
    locationInM = [1, -2, 3];
    voxelDimsInM = [0.1, 0.2, 0.3];
    dims = [3, 4, 5];

    [actX, actY, actZ] = getVoxelCentreCoordinates(locationInM, voxelDimsInM, dims);
    
    expX = [1.05, 1.15, 1.25];
    expY = [-2.1, -2.3, -2.5, -2.7];
    expZ = [2.85, 2.55, 2.25, 1.95, 1.65];
    
    verifyEqual(testCase,{actX, actY, actZ},{expX, expY, expZ},'AbsTol',1E-9);
end

function smallTest(testCase)
    locationInM = [1, 2, 3];
    voxelDimsInM = [0.1, 0.2, 0.3];
    dims = [1 1 1];

    [actX, actY, actZ] = getVoxelCentreCoordinates(locationInM, voxelDimsInM, dims);
    
    expX = 1.05;
    expY = 1.9;
    expZ = 2.85;
    
    verifyEqual(testCase,{actX, actY, actZ},{expX, expY, expZ},'AbsTol',1E-9);
end

function noDimTest(testCase)
    locationInM = [1, 2, 3];
    voxelDimsInM = [0.1, 0.2, 0.3];
    dims = [0 0 0];

    [actX, actY, actZ] = getVoxelCentreCoordinates(locationInM, voxelDimsInM, dims);
    
    expX = 1;
    expY = 2;
    expZ = 3;
    
    verifyEqual(testCase,{actX, actY, actZ},{expX, expY, expZ},'AbsTol',1E-9);
end

function noZDimTest(testCase)
    locationInM = [1, 2, 3];
    voxelDimsInM = [0.1, 0.2, 0.3];
    dims = [1 1 0];

    [actX, actY, actZ] = getVoxelCentreCoordinates(locationInM, voxelDimsInM, dims);
    
    expX = 1.05;
    expY = 1.9;
    expZ = 3;
    
    verifyEqual(testCase,{actX, actY, actZ},{expX, expY, expZ},'AbsTol',1E-9);
end