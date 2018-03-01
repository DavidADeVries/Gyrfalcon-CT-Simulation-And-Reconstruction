classdef ConeBeamOS_SARTReconstruction < Reconstruction
    % ConeBeamOS_SARTReconstruction
    
    properties
        displayName = 'OS-SART Algorithm [TIGRE]'
        fullName = 'OS-SART Algorithm (CBCT)'
    end
    
    properties(Constant)
        reconValuesRootDirectory = 'Matrices and Vectors'
        
        projectionValuesSubDirectory = 'Projection Values'
        rayExclusionMapsSubDirectory = 'Ray Exclusion Maps'
        iterationSolutionsSubDirectory = 'Iteration Solutions'
        
        reconIterationDirectory = 'Iteration ';
    end
    
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.ConeBeamOSSARTSettingsTab;
        end
    end
    
    methods
        function string = getNameString(recon)
            string = 'CBCT OS-SART';
        end     
        
        function recon = createFromGUIForSubClass(recon, app)
            % no GUI fields yet
        end
        
        function app = setGUI(recon, app)
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
            
            % set settings
            
        end
                
        function recon = runReconstruction(recon, reconRun, simulationOrImagingScanRun, app)
            forwardProjectionAccuracy = 0.5;
            
            [tigreGeometry, tigreAnglesInRadians] = convertGyrfalconImagingScanAndReconstructionToTigreGeometry(...
                simulationOrImagingScanRun.getImagingSetup(), recon, forwardProjectionAccuracy);
            
            simulationOrImagingScanRun.loadData(simulationOrImagingScanRun.savePath);
            
            % set up projections
            imageDims = fliplr(simulationOrImagingScanRun.getImagingSetup().detector.wholeDetectorDimensions);
            anglesInDeg = simulationOrImagingScanRun.getImagingSetup().scan.getScanAnglesInDegrees();
            
            numAngles = length(anglesInDeg);
            
            projections = zeros(imageDims(1),imageDims(2),numAngles);
            
            for i=1:numAngles
                projections(:,:,numAngles-i+1) = simulationOrImagingScanRun.sliceData{1,1}.angleData{1,i}.positionData{1,1}.detectorData;
            end
            
            % convert projection data to cleaned-up Radon transform data
            projections = simulationOrImagingScanRun.getImagingSetup().convertProjectionDataToRadonSumData(projections);
            projections = correctRadonSumData(projections);
            
            % ray rejection
            rejectionMaps = single(zeros(imageDims(1),imageDims(2),numAngles));
            
            for i=1:numAngles
                [~, rayExclusionMap] = loadProjectionAndRayExclusionMapDataFiles(simulationOrImagingScanRun, 1, anglesInDeg(i), 1, 1);
                
                rejectionMaps(:,:,i) = ~rayExclusionMap;
            end
                       
            
            niter=50;
            imgFDK=FDK(single(projections), tigreGeo, tigreAnglesInRadians);
            reconDataSet = OS_ASD_POCS(...
                single(projections), tigreGeometry, anglesInRad , niter, rejectionMaps,...
                'TViter',25,'alpha',0.002,'lambda',1,'lambda',0.98,'ratio',0.94);
%             reconDataSet = OS_SART(projections, tigreGeo, anglesInRad, niter);
        end
    end
    
end




function [projectionImage, rayExclusionMap] = loadProjectionAndRayExclusionMapDataFiles(simulationOrImagingScanRun, sliceIndex, angle, xyPositionIndex, zPositionIndex)
    path = simulationOrImagingScanRun.savePath;
    
    sliceFolder = makeSliceFolderName(sliceIndex);
    angleFolder = makeAngleFolderName(angle);
    
    isScanPositionMosiac = false;
    name = makePositionName(xyPositionIndex, zPositionIndex,  isScanPositionMosiac);
    
    detectorFileName = makePositionFileName(name);
    rayExclusionMapFileName = makeRayExclusionMapFileName(name);
    
    data = load(makePath(path, sliceFolder, angleFolder, detectorFileName));
    projectionImage = data.(Constants.Detector_Data_Var_Name);
    
    data = load(makePath(path, sliceFolder, angleFolder, rayExclusionMapFileName));
    rayExclusionMap = data.(Constants.Ray_Exclusion_Map_Var_Name);
end