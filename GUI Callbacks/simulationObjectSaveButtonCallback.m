function [] = simulationObjectSaveButtonCallback(hObject, eventdata, handles, className)
% [] = simulationObjectSaveButtonCallback(hObject, eventdata, handles, className)

workspace = handles.workspace;

workspace = workspace.createFromGUI(handles);

if strcmp(className, 'Simulation')
    object = workspace.simulation;
elseif strcmp(className, 'Phantom');
    object = workspace.simulation.phantom;
elseif strcmp(className, 'Detector');
    object = workspace.simulation.detector;
elseif strcmp(className, 'Source');
    object = workspace.simulation.source;
elseif strcmp(className, 'Scan');
    object = workspace.simulation.scan;
elseif strcmp(className, 'PhotonBeam');
    object = workspace.simulation.scan.beamCharacterization;    
elseif strcmp(className, 'PhantomDataSet');
    object = workspace.simulation.phantom.dataSet;
end

clearBeforeSave = true;

[saved,object] = object.saveAs(clearBeforeSave);

if saved && ~isempty(object)        
    if strcmp(className, 'Simulation')
        workspace.simulation = object;
    elseif strcmp(className, 'Phantom');
        workspace.simulation.phantom = object;
    elseif strcmp(className, 'Detector');
        workspace.simulation.detector = object;
    elseif strcmp(className, 'Source');
        workspace.simulation.source = object;
    elseif strcmp(className, 'Scan');
        workspace.simulation.scan = object;
    elseif strcmp(className, 'PhotonBeam');
        workspace.simulation.scan.beamCharacterization = object;
    elseif strcmp(className, 'PhantomDataSet');
        workspace.simulation.phantom.dataSet = object;
    end
    
    % update handles
    
    handles = workspace.setGUI(handles);
    handles.workspace = workspace;
    
    guidata(hObject, handles);
end

end