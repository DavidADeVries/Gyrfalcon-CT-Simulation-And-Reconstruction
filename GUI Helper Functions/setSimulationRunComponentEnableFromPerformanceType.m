function app = setSimulationRunComponentEnableFromPerformanceType(app, performanceType)
% app = setSimulationRunComponentEnableFromPerformanceType(app, performanceType)

% enable on/off for numCPUs field
if performanceType == SimulationRunPerformanceTypes.highWithMultipleCPUs
    app.SimulationRunNumCPUsEditField.Enable = 'on';
else
    app.SimulationRunNumCPUsEditField.Enable = 'off';
end

% enable on/off for display checkboxs
if performanceType == SimulationRunPerformanceTypes.low
    app.SimulationRunShowDetectorValuesCheckBox.Enable = 'on';
    app.SimulationRunShowDetectorRayTracesCheckBox.Enable = 'on';
    
    app.SimulationRunShowSlicesCheckBox.Enable = 'on';
    app.SimulationRunShowAnglesCheckBox.Enable = 'on';
    app.SimulationRunShowPerAngleRasterCheckBox.Enable = 'on';
    app.SimulationRunShowDetectorRasterCheckBox.Enable = 'on';
else
    app.SimulationRunShowDetectorValuesCheckBox.Enable = 'off';
    app.SimulationRunShowDetectorRayTracesCheckBox.Enable = 'off';
    
    app.SimulationRunShowSlicesCheckBox.Enable = 'off';
    app.SimulationRunShowAnglesCheckBox.Enable = 'off';
    app.SimulationRunShowPerAngleRasterCheckBox.Enable = 'off';
    app.SimulationRunShowDetectorRasterCheckBox.Enable = 'off';
end

end

