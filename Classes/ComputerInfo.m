classdef ComputerInfo
    % ComputerInfo
    
    properties
        systemName
        cpuClockSpeed
        cpuCacheSize
        cpuNumCores
        osType
        osVersion
        
        gpuDevice % MATLAB object
        
        userMemory
        systemMemory
    end
    
    methods
        function info = ComputerInfo()
            tempInfo = cpuinfo();
            
            info.systemName = tempInfo.Name;
            info.cpuClockSpeed = tempInfo.Clock;
            info.cpuCacheSize = tempInfo.Cache;
            info.cpuNumCores = tempInfo.NumProcessors;
            info.osType = tempInfo.OSType;
            info.osVersion = tempInfo.OSVersion;
            
            if parallelComputingToolboxInstalled()
                info.gpuDevice = gpuDevice;
            else
                info.gpuDevice = [];
            end
            
            [user,system] = memory;
            
            info.userMemory = user;
            info.systemMemory = system;
        end
    end
    
end

