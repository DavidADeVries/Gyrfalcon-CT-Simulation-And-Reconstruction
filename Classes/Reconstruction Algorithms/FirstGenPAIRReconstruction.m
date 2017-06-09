classdef FirstGenPAIRReconstruction < Reconstruction
    % FirstGenPAIRReconstruction
    
    properties
        displayName = 'PAIR'
        fullName = 'PAIR (1st Gen)'
        
        usePrecomputedAlphaMatrix
        alphaMatrixSavePath
        alphaMatrixSaveFileName
        
        useNonPartialWeighting
        nonPartialWeightingCutoff
    end
    
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.Gen1PAIR_SettingsTab;
        end
    end
    
    methods
        
        function app = setGUI(recon, app)            
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
        end
        
        function string = getNameString(recon)
            string = '1st Gen. PAIR';
        end
              
        function recon = createFromGUIForSubClass(recon, app)
            recon.useNonPartialWeighting = app.Gen1PAIR_UseNonPartialVoxelWeightingCheckBox.Value;
            recon.nonPartialWeightingCutoff = app.Gen1PAIR_NonPartialVoxelWeightingCutoffEditField.Value;
        end
        
        function recon = runReconstruction(recon, simulationRun, app)
            recon = firstGenPAIRAlgorithm(recon, simulationRun);
        end
        
        function [alphaMatrix, betaVector] = computeAlphaAndBetaValues(reconstruction, simulationRun, projectionData)            
            phantomDims = [reconstruction.reconSliceDimensions, 1];
            voxelDimsInM = [reconstruction.reconSliceVoxelDimensionsInM, 0];
            
            % centre recon slices about origin
            coords = phantomDims .* voxelDimsInM ./ 2;
            phantomLocationInM = [-coords(1), coords(2), 0];
            
            numVoxels = prod(phantomDims);
            maxLength = norm(voxelDimsInM);
            
            % prep source/detector positions to run ray traces to calc
            % alpha matrix
            
            simulation = simulationRun.simulation;
            source = simulation.source;
            detector = simulation.detector;
            scan = simulation.scan;
            
            slices = scan.getSlicesInM();
            angles = scan.getScanAnglesInDegrees();
            
            % calculate indices for calculation
            numSlices = length(slices);
            numAngles = length(angles);
            numXYSteps = scan.perAngleTranslationDimensions(1);
            numZSteps = scan.perAngleTranslationDimensions(2);
            numXYDetector = detector.wholeDetectorDimensions(1);
            numZDetector = detector.wholeDetectorDimensions(2);
            
            indexingLevels = [numSlices, numAngles, numZSteps, numXYSteps, numZDetector, numXYDetector];
            
            numTraces = prod(indexingLevels);
            
            traceIndices = 1:numTraces;
            
            indices = zeros(numTraces, length(indexingLevels));
            
            [indices(:,6), indices(:,5), indices(:,4), indices(:,3), indices(:,2), indices(:,1)] = ...
                ind2sub(fliplr(indexingLevels), traceIndices);            
                    
            detectorDims = detector.wholeDetectorDimensions;
            detectorPixelDims = detector.singleDetectorDimensions;
            
            [pointSourceCoords, pointDetectorCoords, pointDetectorWithinSourceBeam] = calculateSourceAndDetectorCoords(...
                indices, source.getLocationInM(), detector.getLocationInM(),...
                slices', angles',...
                scan.getPerAngleTranslationResolutionInM(), scan.perAngleTranslationDimensions,...
                detectorDims, detectorPixelDims, detector.getAngularDetectorRadiusInM(),...
                detector.movesWithScanAngle, detector.movesWithPerAngleTranslation, source.getBeamAngleInDegrees()+1);
            
            dims = size(indices);
            numRays = dims(1);
            
            alphaMatrix = zeros(numVoxels, numVoxels);
            smearMatrix = zeros(phantomDims(2), phantomDims(1), phantomDims(3));
            betaVector = zeros(numVoxels, 1);
            
            for i=1:numRays
                disp(i);
                if pointDetectorWithinSourceBeam(i)
                    projectionValue = projectionData(end-indices(i,4)+1, indices(i,2));
                    
                    hitMatrix = fastRayTraceForPAIRAlphaMatrix(...
                        pointSourceCoords(i,:), pointDetectorCoords(i,:),...
                        phantomLocationInM, phantomDims, voxelDimsInM);
                    
                    lengthSum = sum(sum(hitMatrix));
                    weighting = hitMatrix ./ lengthSum;
                    applyTo = hitMatrix ~= 0;
                    smearMatrix(applyTo) = smearMatrix(applyTo) + projectionValue .* weighting(applyTo);
                    
%                     hitVector = reshape(hitMatrix, [numVoxels, 1]);
%                     
%                     hitVector = hitVector ./ maxLength; %normalized between 0 and 1
%                     
%                     if reconstruction.useNonPartialWeighting % ray is classified as hitting or not
%                         hitVector = hitVector >= reconstruction.nonPartialWeightingCutoff;
%                     end
%                     
%                     alphaMatrix = alphaMatrix + 2.*(repmat(hitVector, [1, numVoxels]) .* repmat(hitVector', [numVoxels, 1]));
%                     betaVector = betaVector + 2 .* hitVector .* projectionValue;
                end
            end
            
            disp('Done!');
        end
        
    end
    
end

