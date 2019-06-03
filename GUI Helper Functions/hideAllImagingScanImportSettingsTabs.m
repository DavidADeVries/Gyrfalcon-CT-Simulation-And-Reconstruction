function app = hideAllImagingScanImportSettingsTabs(app)
%app = hideAllImagingScanImportSettingsTabs(app)

tabHandles = {...
    app.OpticalCTImportSettingsTab,...
    app.XRayCTImportSettingsTab...
    };

for i=1:length(tabHandles)
    tabHandles{i}.Parent = [];
end

end

