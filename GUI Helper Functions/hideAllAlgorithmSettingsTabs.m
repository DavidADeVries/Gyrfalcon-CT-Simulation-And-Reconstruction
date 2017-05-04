function app = hideAllAlgorithmSettingsTabs(app)
%app = hideAllAlgorithmSettingsTabs(app)

tabHandles = {...
    app.Gen1FBP_SettingsTab,...
    app.Gen1PAIR_SettingsTab...
    };

for i=1:length(tabHandles)
    tabHandles{i}.Parent = [];
end

end

