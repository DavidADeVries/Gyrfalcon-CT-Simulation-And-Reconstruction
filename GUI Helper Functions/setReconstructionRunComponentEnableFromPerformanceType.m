function app = setReconstructionRunComponentEnableFromPerformanceType(app, performanceType)
% app = setReconstructionRunComponentEnableFromPerformanceType(app, performanceType)

% enable on/off for numCPUs field
if performanceType == ReconstructionRunPerformanceTypes.highWithMultipleCPUs
    app.ReconstructionRunNumCPUsEditField.Enable = 'on';
else
    app.ReconstructionRunNumCPUsEditField.Enable = 'off';
end

end

