function app = updateStatusOutput(app, newString, newLine)
%app = updateStatusOutput(app, newString, newLine)

currentString = app.StatusOutputTextArea.Value;

if newLine
    stringToWrite = [currentString; {newString}];
else
    lastString = currentString{end};
    
    lastString = [lastString, newString];
    
    currentString{end} = lastString;
    
    stringToWrite = currentString;
end

app.StatusOutputTextArea.Value = stringToWrite;

waitfor(app.StatusOutputTextArea, 'Value', stringToWrite);

end

