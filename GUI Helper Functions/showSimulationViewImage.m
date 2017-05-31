function [] = showSimulationViewImage(app)
% [] = showSimulationViewImage(app)

[invert, contrastBounds] = getSimulationViewerImageDisplaySettings(app);

run = app.workspace.simulationRunForViewing;
simulation = run.simulation;

detectorDims = simulation.detector.wholeDetectorDimensions;
detectorDimsInM = simulation.detector.getSingleDetectorDimensionsInM();

stepDims = simulation.scan.perAngleTranslationDimensions;
stepDimsInM = simulation.scan.getPerAngleTranslationResolutionInM();

if all(detectorDims == 1) && any(stepDims > 1) % create image from single detectors at multiple positions
    app.SimulationViewerPerAngleTranslationPositionListBox.Enable = 'off';
    
    sliceFolder = app.SimulationViewerSliceListBox.Value;
    angleFolder = app.SimulationViewerScanAngleListBox.Value;
    
    toAnglePath = makePath(run.savePath, sliceFolder, angleFolder);
        
    xyDim = stepDims(1);
    xyDimInM = stepDimsInM(1);
    
    zDim = stepDims(2);
    zDimInM = stepDimsInM(2);
    
    image = zeros(stepDims(2),stepDims(1));
     
     for xy = 1:stepDims(1)
         for z = 1:stepDims(2)
             positionFolder = app.SimulationViewerPerAngleTranslationPositionListBox.ItemsData{(xy-1)*stepDims(1) + z};
             loadPath = makePath(toAnglePath, positionFolder);
             
             fileData = load(loadPath);
             
             detectorData = fileData.(Constants.Detector_Data_Var_Name);
             image(z,xy) = detectorData; % will be a 1x1 matrix
         end
     end
elseif detectorDims(1) == 1 && stepDims(2) == 1 % have fans in the z direction at multiple xy positions
    app.SimulationViewerPerAngleTranslationPositionListBox.Enable = 'off';
    
    sliceFolder = app.SimulationViewerSliceListBox.Value;
    angleFolder = app.SimulationViewerScanAngleListBox.Value;
    
    toAnglePath = makePath(run.savePath, sliceFolder, angleFolder);
        
    xyDim = stepDims(1);
    xyDimInM = stepDimsInM(1);
    
    zDim = detectorDims(2);
    zDimInM = detectorDimsInM(2);
    
    image = zeros(detectorDims(2), stepDims(1));
    
    for xy = 1:stepDims(1)
        positionFolder = app.SimulationViewerPerAngleTranslationPositionListBox.ItemsData{xy};
        loadPath = makePath(toAnglePath, positionFolder);
        
        fileData = load(loadPath);
        
        detectorData = fileData.(Constants.Detector_Data_Var_Name);
        
        image(:,xy) = detectorData; %will be a column vector
    end
elseif detectorDims(2) == 1 && stepDims(1) == 1 % have fans in the xy direction at multiple z positions
    app.SimulationViewerPerAngleTranslationPositionListBox.Enable = 'off';
    
    sliceFolder = app.SimulationViewerSliceListBox.Value;
    angleFolder = app.SimulationViewerScanAngleListBox.Value;
    
    toAnglePath = makePath(run.savePath, sliceFolder, angleFolder);
        
    xyDim = detectorDims(1);
    xyDimInM = detectorDimsInM(1);
    
    zDim = stepDims(2);
    zDimInM = stepDimsInM(2);
      
    image = zeros(stepDims(2), detectorDims(1));
    
    for z = 1:stepDims(2)
        positionFolder = app.SimulationViewerPerAngleTranslationPositionListBox.ItemsData{z};
        loadPath = makePath(toAnglePath, positionFolder);
        
        fileData = load(loadPath);
        
        detectorData = fileData.(Constants.Detector_Data_Var_Name);
        
        image(z,:) = detectorData; % will be a row vector
    end
else %% have either a cone beam detector, or fans in the same direction as position movement, so can't put them together, we'll just display one position at a time
    app.SimulationViewerPerAngleTranslationPositionListBox.Enable = 'on';
        
    xyDim = detectorDims(1);
    xyDimInM = detectorDimsInM(1);
    
    zDim = detectorDims(2);
    zDimInM = detectorDimsInM(2);
    
    image = app.workspace.simulationRunForViewing.loadImageForScanSimulationViewer(app);
end

% if the image is just 1 pixel wide or high, pad it out to make it more
% visible
dims = size(image);

if dims(1) == 1 && dims(2) > 1
   image = repmat(image, [dims(2)/2, 1]);
   
   zDim = zDim * dims(2)/2;
elseif dims(2) == 1 && dims(1) > 1
   image = repmat(image, [1, dims(1)/2]);  
   
   xyDim = xyDim * dims(1)/2;
end
         
if invert
    image = -image;
    contrastBounds = -contrastBounds;
    contrastBounds = fliplr(contrastBounds);    
end

% calculate the bounds (in m) that the image should cover. This ensures
% that images are not stretched/shrunk for non-square pixels, detector
% movements larger than the detector size, etc.

xData = [0, (xyDim-1)*xyDimInM]; % gives locations of pixel centres
xLim = xData + [-xyDimInM/2, +xyDimInM/2]; % goes to boundary of outside pixels

yData = [0, (zDim-1)*zDimInM];
yLim = yData + [-zDimInM/2, +zDimInM/2];

imshow(image, contrastBounds,...
    'Parent', app.SimulationViewerAxes,...
    'XData', xData, 'YData', yData);

app.SimulationViewerAxes.XLim = xLim;
app.SimulationViewerAxes.YLim = yLim;
app.SimulationViewerAxes.BackgroundColor = [0 0 0];

end

