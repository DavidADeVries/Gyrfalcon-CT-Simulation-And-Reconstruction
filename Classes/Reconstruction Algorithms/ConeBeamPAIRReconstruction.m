classdef ConeBeamPAIRReconstruction < Reconstruction
    % ConeBeamPAIRReconstruction
    
    properties
        displayName = 'PAIR Algorithm'
        fullName = 'PAIR Algorithm (CBCT)'

        rayTraceMatricesLoadPath = ''

        rayTraceMatricesSavePath = ''
        rayTraceMatricesSaveFileName = ''

        alphaMatricesLoadPath = ''

        alphaMatricesSavePath = ''
        alphaMatricesSaveFileName = ''
        
        numberPartitions = 64
        numberIterations = 2
        numberAverages = 5
        
        numberOfRaysInBatch = 65536
    end
    
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.ConeBeamPAIR_SettingsTab;
        end
    end
    
    methods
        function string = getNameString(recon)
            string = 'CBCT PAIR';
        end     
        
        function recon = createFromGUIForSubClass(recon, app)
            % no GUI fields yet
            recon.numberPartitions = app.CBCT_PAIR_NumberPartitionsEditField.Value;
            recon.numberIterations = app.CBCT_PAIR_NumberIterationsEditField.Value;
            recon.numberAverages = app.CBCT_PAIR_NumberAveragesEditField.Value;
            
            recon.numberOfRaysInBatch = app.CBCT_PAIR_NumberRaysInBatchEditField.Value;
        end
        
        function app = setGUI(recon, app)
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
            
            % set settings
            if ~isempty(recon.rayTraceMatricesLoadPath)
                app.CBCT_PAIR_RayTraceMatricesSavePathEditField.Value = recon.rayTraceMatricesLoadPath;
            elseif ~isempty(recon.rayTraceMatricesSavePath)
                app.CBCT_PAIR_RayTraceMatricesSavePathEditField.Value = makePath(recon.rayTraceMatricesSavePath, recon.rayTraceMatricesSaveFileName);
            else
                app.CBCT_PAIR_RayTraceMatricesSavePathEditField.Value = 'Ray Trace Matrices will not be saved or loaded';
            end
            
            
            if ~isempty(recon.alphaMatricesLoadPath)
                app.CBCT_PAIR_AlphaMatricesSavePathEditField.Value = recon.alphaMatricesLoadPath;
            elseif ~isempty(recon.alphaMatricesSavePath)
                app.CBCT_PAIR_AlphaMatricesSavePathEditField.Value = makePath(recon.alphaMatricesSavePath, recon.alphaMatricesSaveFileName);
            else
                app.CBCT_PAIR_AlphaMatricesSavePathEditField.Value = 'Alpha and Selection Matrices will not be saved or loaded';
            end
            
            app.CBCT_PAIR_NumberPartitionsEditField.Value = recon.numberPartitions;
            app.CBCT_PAIR_NumberIterationsEditField.Value = recon.numberIterations;
            app.CBCT_PAIR_NumberAveragesEditField.Value = recon.numberAverages;
            app.CBCT_PAIR_NumberRaysInBatchEditField.Value = recon.numberOfRaysInBatch;
        end
        
        function recon = runReconstruction(recon, reconRun, simulationOrImagingScanRun, app)
            
            if isempty(recon.alphaMatricesLoadPath)
                alphaMatrixFolder = removeFileExtension(recon.alphaMatricesSaveFileName);
                mkdir(recon.alphaMatricesSavePath, alphaMatrixFolder);
                
                alphaMatrixPath = makePath(recon.alphaMatricesSavePath, alphaMatrixFolder);
                % projection data is grouped per angle. This may or may not align with how
                % the ray compute batches divided up the work. We'll reorganize the data
                % accordingly, saving it on disk for easy recall. It also orders data to
                % correspond with the proper ray.
               
                divideProjectionAndRayExclusionDataForBatches(simulationOrImagingScanRun, recon, alphaMatrixPath, recon.numberOfRaysInBatch, true, true);
               % numBatches = divideProjectionAndRayExclusionDataForBatches(simulationOrImagingScanRun, recon, alphaMatrixPath, recon.numberOfRaysInBatch, true, false);
                
                rayTraceLoadPath = recon.rayTraceMatricesLoadPath;
                
                rayTraceSavePath = recon.rayTraceMatricesSavePath;
                rayTraceSaveFolder = removeFileExtension(recon.rayTraceMatricesSaveFileName);
                
                % one for top half, one for bottom half
                [alphaMatrixPath, rayTracePath] = createAlphaMatrices_Sparse(...
                    simulationOrImagingScanRun, recon, recon.numberPartitions, recon.numberAverages, recon.numberOfRaysInBatch, ...
                    recon.alphaMatricesSavePath, recon.alphaMatricesSaveFileName,...
                    rayTraceLoadPath, rayTraceSavePath, rayTraceSaveFolder,...
                    true);                
%                 [alphaMatrixPath, rayTracePath] = createAlphaMatrices(...
%                     simulationOrImagingScanRun, recon, recon.numberPartitions, recon.numberAverages, recon.numberOfRaysInBatch, ...
%                     recon.alphaMatricesSavePath, recon.alphaMatricesSaveFileName,...
%                     rayTraceLoadPath, rayTraceSavePath, rayTraceSaveFolder,...
%                     false);
            else
                alphaMatrixPath = recon.alphaMatricesLoadPath;
                rayTracePath = recon.rayTraceMatricesLoadPath;
                
%                 divideProjectionAndRayExclusionDataForBatches(simulationOrImagingScanRun, recon, alphaMatrixPath, recon.numberOfRaysInBatch, true, true);
            end
                        
            folder = reconRun.getCurrentSaveFolder();
            mkdir(simulationOrImagingScanRun.savePath, folder);
            
            reconstruction_Top = performIterativePairReconstruction(...
                simulationOrImagingScanRun, recon, reconRun.savePath, recon.numberPartitions, recon.numberIterations, recon.numberAverages, recon.numberOfRaysInBatch, simulationOrImagingScanRun.getTotalNumberOfRays(),...
                alphaMatrixPath, rayTracePath, true, true);
%             reconstruction_Bottom = performIterativePairReconstruction(...
%                 simulationOrImagingScanRun, recon, recon.numberPartitions, recon.numberIterations, recon.numberAverages,...
%                 alphaMatrixPath, initialSolution_Top, true);
        end
    end
    
end

function rayExclusionMap = loadRayExclusionMap(simulationOrImagingScanRunPath, isConeBeam, createForTopHalf)
    data = load(makePath(simulationOrImagingScanRunPath, Constants.Ray_Exclusion_Map_Directory, [Constants.Ray_Exclusion_Map_File_Name, Constants.Matlab_File_Extension]));
    
    rayExclusionMap = data.(Constants.Ray_Exclusion_Map_Var_Name);
    
    if isConeBeam
        dims = size(rayExclusionMap);
        
        halfHeight = dims(1)/2;
        
        if createForTopHalf
            rayExclusionMap = rayExclusionMap(1:halfHeight,:);
        else
            rayExclusionMap = rayExclusionMap(halfHeight+1:end,:);
        end
    end
end