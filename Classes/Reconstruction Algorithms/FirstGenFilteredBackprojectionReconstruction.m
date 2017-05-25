classdef FirstGenFilteredBackprojectionReconstruction < Reconstruction
    % FirstGenFilteredBackprojectionReconstruction
    
    properties
        displayName = 'Filtered Backprojection'
        fullName = 'Filtered Backprojection (1st Gen)'
        
        filterType = FirstGenFilterTypes.none % these filters (Shepp-Logan, cosine, Hann, etc.) are all noise reduction filters NOT for frequency space weighting
        applyRampFilter = true % boolean of whether to use a ramp (Ram-Lak) filter. This weights the data in frequency space accordingly
        
        applyBandlimiting = true % bandlimiting based on detector widths
        
        interpolationType = InterpolationTypes.linear;
        
        % Data Sets to Save
        
        % reconDataSet (in Reconstruction class)
        sinograms        
        reconVideosFrames
        
        saveSinogramsAndVideos = false
    end
    
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.Gen1FBP_SettingsTab;
        end
    end
    
    methods        
        function recon = FirstGenFilteredBackprojectionReconstruction()
            
        end
        
        function recon = createFromGUIForSubClass(recon, app)
            recon.filterType = app.Gen1FBP_FilterTypeDropDown.Value;
            recon.applyRampFilter = app.Gen1FBP_ApplyRampRamLakFilterCheckBox.Value;
            recon.applyBandlimiting = app.Gen1FBP_ApplyBandlimitingofHighFrequenciesCheckBox.Value;
            recon.saveSinogramsAndVideos = app.Gen1FBP_SaveSinogramsandReconstructionVideosCheckBox.Value;
            recon.interpolationType = app.Gen1FBP_InterpolationTypeDropDown.Value;
        end
        
        function app = setGUI(recon, app)
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
            
            % set settings
            app.Gen1FBP_FilterTypeDropDown.Value = recon.filterType;
            app.Gen1FBP_ApplyRampRamLakFilterCheckBox.Value = recon.applyRampFilter;
            app.Gen1FBP_ApplyBandlimitingofHighFrequenciesCheckBox.Value = recon.applyBandlimiting;
            app.Gen1FBP_SaveSinogramsandReconstructionVideosCheckBox.Value = recon.saveSinogramsAndVideos;
            app.Gen1FBP_InterpolationTypeDropDown.Value = recon.interpolationType;
        end
        
        function [filterTypes, filterTypeStrings] = getFilterTypes(recon)
            [filterTypes, filterTypeStrings] = enumeration(FirstGenFilterTypes);
        end
        
        function recon = changeSettings(recon)
            recon = firstGenFilteredBackprojectionReconSettingsGUI(recon);
        end
        
        function string = getNameString(recon)
            string = '1st Gen. FBP';
        end
        
        function recon = runReconstruction(recon, simulationRun, app)
            firstGenData = simulationRun.compileProjectionDataFor1stGenRecon();
            
            simulation = simulationRun.simulation;
            phantom = simulation.phantom;
            
            photonBeam = simulationRun.simulation.scan.beamCharacterization;
            
            scanAngles = simulation.scan.getScanAnglesInDegrees();
            sourceStartingLocationInM = simulation.source.getLocationInM();
            
            reconSliceDimensions = recon.reconSliceDimensions;
            reconSliceDimensions = reconSliceDimensions(1:2); % just need x,y
            
            reconSliceVoxelDimsInM = recon.reconSliceVoxelDimensionsInM;
            reconSliceVoxelDimsInM  = reconSliceVoxelDimsInM(1:2); % just need x,y
                        
            slicePhantomLocationInM = calculateNewPhantomLocationForReconstruction(...
                phantom.getLocationInM(), phantom.getVoxelDimensionsInM(), phantom.dataSet.getSize(),...
                recon.reconSliceVoxelDimensionsInM, recon.reconSliceDimensions);

            detectorWidthInM = simulation.detector.getSingleDetectorDimensionsInM();
            detectorWidthInM = detectorWidthInM(1);
            
            filterType = recon.filterType;
            applyRampFilter = recon.applyRampFilter;
            applyBandlimiting = recon.applyBandlimiting;
            interpolationType = recon.interpolationType;
            
            [reconDataSetSlices, sinograms, reconVideosFrames] = firstGenFilteredBackProjectionAlgorithm(...
                firstGenData, photonBeam,...
                scanAngles, sourceStartingLocationInM,...
                reconSliceDimensions, reconSliceVoxelDimsInM, slicePhantomLocationInM, detectorWidthInM,...
                filterType, applyRampFilter, applyBandlimiting, interpolationType);
                            
            recon.reconDataSetSlices = reconDataSetSlices;
            recon.sinograms = sinograms;
            recon.reconVideosFrames = reconVideosFrames;
            
            recon.reconSliceLocationInM = slicePhantomLocationInM;
        end
        
        function [] = saveOutputSubclass(recon, savePath)
            if recon.saveSinogramsAndVideos
                % make folders
                sinogramFolder = Constants.FBP_Recon_Sinograms_Folder_Name;
                videoFolder = Constants.FBP_Recon_Videos_Folder_Name;
                
                mkdir(savePath, sinogramFolder);
                mkdir(savePath, videoFolder);
                
                % save sinograms
                for i=1:length(recon.sinograms)
                    sino = recon.sinograms{i};
                    
                    window = [allMin(sino) allMax(sino)];
                                        
                    adjSino = applyContrastToMaximizeGrayscale(sino, window, 1); % rescale for png
                    
                    filename = [Constants.FBP_Recon_Sinograms_File_Name, ' ', num2str(i), Constants.PNG_File_Extension];
                    
                    imwrite(adjSino, makePath(savePath, sinogramFolder, filename));
                end
                
                % save recon videos
                for i=1:length(recon.reconVideosFrames)
                    frames = recon.reconVideosFrames{i};
                    
                    dims = size(frames);
                    
                    numFrames = dims(3);
                    
                    filename = [Constants.FBP_Recon_Videos_File_Name, ' ', num2str(i), Constants.AVI_File_Extension];
                    
                    v = VideoWriter(makePath(savePath, videoFolder, filename), 'Uncompressed AVI');
                    open(v);
                    
                    for j=1:numFrames
                        frame = frames(:,:,j);
                        
                        dims = size(frame);
                        
                        if dims(1) < 64 || dims(2) < 64 % minimum size
                            frame = imresize(frame, 2); %make twice as big
                        end
                        
                        window = [allMin(frame) allMax(frame)];
                                        
                        adjFrame = applyContrastToMaximizeGrayscale(frame, window, 1);
                        
                        frameRepeat = 2; %write every frame this many time to slow it down if need
                        
                        for k=1:frameRepeat
                            writeVideo(v, adjFrame);
                        end
                    end
                    
                    close(v);
                end
            end
        end
    end
    
end

