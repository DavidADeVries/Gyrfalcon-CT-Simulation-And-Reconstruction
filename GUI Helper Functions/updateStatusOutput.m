function app = updateStatusOutput(app, newString, newLine)
%app = updateStatusOutput(app, newString, newLine)

currentString = app.StatusOutputTextArea.Value;

if newLine
    app.StatusOutputTextArea.Value = [currentString; {newString}];
else
    lastString = currentString{end};
    
    lastString = [lastString, newString];
    
    currentString{end} = lastString;
    
    app.StatusOutputTextArea.Value = currentString;
end

drawnow;

end

