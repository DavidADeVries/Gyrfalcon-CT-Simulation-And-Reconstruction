function [app, cpuPool] = startCPUPool(app, numCPUs)
%[app, cpuPool] = startCPUPool(app, numCPUs)

% tell the used we're starting up the pool
newString = ['Starting Parallel Worker Pool (', num2str(numCPUs), ' cores)...'];
newLine = true;

app = updateStatusOutput(app, newString, newLine);

% make the pool
delete(gcp('nocreate')); % just to make sure there isn't a pool already
cpuPool = parpool(numCPUs);

% tell the used we're done
newString = 'Complete';
newLine = false;

app = updateStatusOutput(app, newString, newLine);


end

