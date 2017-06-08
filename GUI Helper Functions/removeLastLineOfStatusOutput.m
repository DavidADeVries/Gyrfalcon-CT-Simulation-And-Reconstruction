function app = removeLastLineOfStatusOutput(app)
% app = removeLastLineOfStatusOutput(app)

text = app.StatusOutputTextArea.Value;

text(end) = []; % bump last entry

app.StatusOutputTextArea.Value = text;


end

