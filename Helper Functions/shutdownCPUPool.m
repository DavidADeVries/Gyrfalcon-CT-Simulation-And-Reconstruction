function app = shutdownCPUPool(app, cpuPool)
%app = shutdownCPUPool(app, cpuPool)

% tell the user what's going on
newString = 'Closing Parallel Worker Pool...';
newLine = true;

app = updateStatusOutput(app, newString, newLine);

% delete the pool
delete(cpuPool);

% tell the user we're done
newString = 'Complete';
newLine = false;

app = updateStatusOutput(app, newString, newLine);

end

