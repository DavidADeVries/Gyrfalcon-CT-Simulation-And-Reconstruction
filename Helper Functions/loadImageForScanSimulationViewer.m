function image = loadImageForScanSimulationViewer(run, app)
% get selected folders/files
sliceFolder = app.SimulationViewerSliceListBox.Value;
angleFolder = app.SimulationViewerScanAngleListBox.Value;
positionDetectorDataFilename = app.SimulationViewerPerAngleTranslationPositionListBox.Value; %ItemData used to the filename

loadPath = makePath(run.savePath,...
    sliceFolder,...
    angleFolder,...
    positionDetectorDataFilename);

fileData = load(loadPath);

image = fileData.(Constants.Detector_Data_Var_Name);

% map = load(makePath(run.savePath, sliceFolder, angleFolder, 'Position (1,1) Ray Exclusion Map.mat'));
% map = map.rayExclusionMap;
% 
% image(map) = 0;

end

