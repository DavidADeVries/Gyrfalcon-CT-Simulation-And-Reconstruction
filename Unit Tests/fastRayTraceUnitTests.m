function tests = fastRayTraceUnitTests
    tests = functiontests(localfunctions);
end

function miss1Test(testCase)
    pointSourceCoords = [-2 0 0];
    pointDetectorCoords = [0 2.1 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    verifyEqual(testCase,detectorValue,100,'AbsTol',1E-9);
end

function miss2Test(testCase)
    pointSourceCoords = [-2 0 0];
    pointDetectorCoords = [0 -2.1 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    verifyEqual(testCase,detectorValue,100,'AbsTol',1E-9);
end

function miss3Test(testCase)
    pointSourceCoords = [2 0 0];
    pointDetectorCoords = [0 2.1 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    verifyEqual(testCase,detectorValue,100,'AbsTol',1E-9);
end

function miss4Test(testCase)
    pointSourceCoords = [2 0 0];
    pointDetectorCoords = [0 -2.1 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    verifyEqual(testCase,detectorValue,100,'AbsTol',1E-9);
end

function miss5Test(testCase)
    pointSourceCoords = [2 0 0];
    pointDetectorCoords = [0 0 -1.1];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    verifyEqual(testCase,detectorValue,100,'AbsTol',1E-9);
end

function miss6Test(testCase)
    pointSourceCoords = [2 0 0];
    pointDetectorCoords = [0 0 1.1];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    verifyEqual(testCase,detectorValue,100,'AbsTol',1E-9);
end

function miss7Test(testCase)
    pointSourceCoords = [-2 0 0];
    pointDetectorCoords = [0 0 -1.1];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    verifyEqual(testCase,detectorValue,100,'AbsTol',1E-9);
end

function miss8Test(testCase)
    pointSourceCoords = [-2 0 0];
    pointDetectorCoords = [0 0 1.1];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    verifyEqual(testCase,detectorValue,100,'AbsTol',1E-9);
end

function miss9Test(testCase)
    pointSourceCoords = [-2 0 0];
    pointDetectorCoords = [0 0 1.1];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    verifyEqual(testCase,detectorValue,100,'AbsTol',1E-9);
end

% HIT TESTS

function hit_BasicXTraversal_Test(testCase)
    pointSourceCoords = [-2 0.5 0];
    pointDetectorCoords = [2 0.5 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.1*1 + 0.2*1));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_BasicXTraversalOpposite_Test(testCase)
    pointSourceCoords = [2 0.5 0];
    pointDetectorCoords = [-2 0.5 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.1*1 + 0.2*1));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_BasicXTraversalLower_Test(testCase)
    pointSourceCoords = [-2 -0.5 0];
    pointDetectorCoords = [2 -0.5 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.3*1 + 0.4*1));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_BasicXTraversalOnTheLine_Test(testCase)
    pointSourceCoords = [-2 0 0];
    pointDetectorCoords = [2 0 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.1*1 + 0.2*1));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_BasicYTraversal_Test(testCase)
    pointSourceCoords = [-0.5 2 0];
    pointDetectorCoords = [-0.5 -2 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.1*1 + 0.3*1));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_BasicYTraversalOpposite_Test(testCase)
    pointSourceCoords = [-0.5 -2 0];
    pointDetectorCoords = [-0.5 2 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.1*1 + 0.3*1));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_BasicYTraversalRight_Test(testCase)
    pointSourceCoords = [0.5 2 0];
    pointDetectorCoords = [0.5 -2 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.2*1 + 0.4*1));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_BasicYTraversalOnTheLine_Test(testCase)
    pointSourceCoords = [0 2 0];
    pointDetectorCoords = [0 -2 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.2*1 + 0.4*1));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end



function hit_BasicYTraversalJustOverTheLine_Test(testCase)
    pointSourceCoords = [-0.000001 2 0];
    pointDetectorCoords = [-0.000001 -2 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.1*1 + 0.3*1));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end


function hit_BasicZTraversal_Test(testCase)
    pointSourceCoords = [0.5 0.5 2];
    pointDetectorCoords = [0.5 0.5 -2];
    
    phantomLocationInM = [-1 1 1];
    
    phantomDims = [2 2 2];
    voxelDimsInM = [1 1 1];
    
    phantomData = zeros(2,2,2);
    phantomData(:,:,1) = [0.1 0.2; 0.3 0.4];
    phantomData(:,:,2) = [0.5 0.6; 0.7 0.8];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.2*1 + 0.6*1));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_BasicZTraversalOpposite_Test(testCase)
    pointSourceCoords = [0.5 0.5 -2];
    pointDetectorCoords = [0.5 0.5 2];
    
    phantomLocationInM = [-1 1 1];
    
    phantomDims = [2 2 2];
    voxelDimsInM = [1 1 1];
    
    phantomData = zeros(2,2,2);
    phantomData(:,:,1) = [0.1 0.2; 0.3 0.4];
    phantomData(:,:,2) = [0.5 0.6; 0.7 0.8];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.2*1 + 0.6*1));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_BasicZTraversalShifted_Test(testCase)
    pointSourceCoords = [-0.5 0.5 -2];
    pointDetectorCoords = [-0.5 0.5 2];
    
    phantomLocationInM = [-1 1 1];
    
    phantomDims = [2 2 2];
    voxelDimsInM = [1 1 1];
    
    phantomData = zeros(2,2,2);
    phantomData(:,:,1) = [0.1 0.2; 0.3 0.4];
    phantomData(:,:,2) = [0.5 0.6; 0.7 0.8];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.1*1 + 0.5*1));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_BasicZTraversalOnTheLine_Test(testCase)
    pointSourceCoords = [0 0 2];
    pointDetectorCoords = [0 0 -2];
    
    phantomLocationInM = [-1 1 1];
    
    phantomDims = [2 2 2];
    voxelDimsInM = [1 1 1];
    
    phantomData = zeros(2,2,2);
    phantomData(:,:,1) = [0.1 0.2; 0.3 0.4];
    phantomData(:,:,2) = [0.5 0.6; 0.7 0.8];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.2*1 + 0.6*1));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_BasicZTraversalJustOverTheLine_Test(testCase)
    pointSourceCoords = [-0.000001 -0.000001 2];
    pointDetectorCoords = [-0.000001 -0.000001 -2];
    
    phantomLocationInM = [-1 1 1];
    
    phantomDims = [2 2 2];
    voxelDimsInM = [1 1 1];
    
    phantomData = zeros(2,2,2);
    phantomData(:,:,1) = [0.1 0.2; 0.3 0.4];
    phantomData(:,:,2) = [0.5 0.6; 0.7 0.8];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.3*1 + 0.7*1));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

% ON ANGLE TESTS

function hit_XYAngle_1VoxelHit_Test(testCase)
    pointSourceCoords = [0 1.5 0];
    pointDetectorCoords = [1.5 0 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.2*sqrt(0.5)));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end



function hit_XYAngle_1VoxelHit_Opposite_Test(testCase)
    pointSourceCoords = [1.5 0 0];
    pointDetectorCoords = [0 1.5 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.2*sqrt(0.5)));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_XYAngle_1VoxelHit2_Test(testCase)
    pointSourceCoords = [0 -1.5 0];
    pointDetectorCoords = [1.5 0 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.4*sqrt(0.5)));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end



function hit_XYAngle_1VoxelHit2_Opposite_Test(testCase)
    pointSourceCoords = [1.5 0 0];
    pointDetectorCoords = [0 -1.5 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.4*sqrt(0.5)));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_XYAngle_1VoxelHit3_Test(testCase)
    pointSourceCoords = [0 1.5 0];
    pointDetectorCoords = [-1.5 0 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.1*sqrt(0.5)));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end



function hit_XYAngle_1VoxelHit3_Opposite_Test(testCase)
    pointSourceCoords = [-1.5 0 0];
    pointDetectorCoords = [0 1.5 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.1*sqrt(0.5)));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_XYAngle_1VoxelHit4_Test(testCase)
    pointSourceCoords = [0 -1.5 0];
    pointDetectorCoords = [-1.5 0 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.3*sqrt(0.5)));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end



function hit_XYAngle_1VoxelHit4_Opposite_Test(testCase)
    pointSourceCoords = [-1.5 0 0];
    pointDetectorCoords = [0 -1.5 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.3*sqrt(0.5)));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end


function hit_XYAngle_Corner2Corner_Test(testCase)
    pointSourceCoords = [-2 2 0];
    pointDetectorCoords = [2 -2 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.1*sqrt(2)+0.4*sqrt(2)));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_XYAngle_Corner2Corner_Opposite_Test(testCase)
    pointSourceCoords = [2 -2 0];
    pointDetectorCoords = [-2 2 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.1*sqrt(2)+0.4*sqrt(2)));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end


function hit_XYAngle_Corner2Corner2_Test(testCase)
    pointSourceCoords = [-2 -2 0];
    pointDetectorCoords = [2 2 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.2*sqrt(2)+0.3*sqrt(2)));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end

function hit_XYAngle_Corner2Corner2_Opposite_Test(testCase)
    pointSourceCoords = [2 2 0];
    pointDetectorCoords = [-2 -2 0];
    
    phantomLocationInM = [-1 1 0.5];
    
    phantomDims = [2 2 1];
    voxelDimsInM = [1 1 1];
    
    phantomData = [0.1 0.2; 0.3 0.4];
    
    beam = PhotonBeam(0.1, 100);    

    detectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        phantomData, beam);
    
    expected = 100*exp(-(0.2*sqrt(2)+0.3*sqrt(2)));
    
    verifyEqual(testCase,detectorValue,expected,'AbsTol',1E-9);
end