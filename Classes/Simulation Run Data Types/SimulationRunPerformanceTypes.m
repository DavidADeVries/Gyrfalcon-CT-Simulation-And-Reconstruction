classdef SimulationRunPerformanceTypes
    % SimulationRunPerformanceTypes
    % types of performance levels for computations for sim runs
    
    properties
        displayString
        explanationString
    end
    
    enumeration        
        low (...
            'Low (for Animation)',...
            'Computations are done one after another using multiple nested loops. Time is also allowed for the display to be updated, showing what the simulation is computing. This performance type is not valid for benchmarking.')
        
        high (....
            'High',...
            'Computations are optimizing using MATLAB vectorization and arrayfun. MATLAB may use multiple cores to complete the computations, but no more than one will be used at one time.')
        
        highWithMultipleCPUs (...
            'High with Multiple CPUs',...
            'Computations are performed using the same MATLAB optimizations are with High Performance, though the are distributed between the specified number of CPUs. These CPUs will work in parallel, each using MATLAB optimization. How the work is split between the CPUs is dependent on the number of CPUs, amount of RAM available, and the number of slices, scan angles, per angle translation, and detector size.')
        
        highWithGPU (...
            'High with GPU',...
            'At current, it is unknown how to accelerate the required computation of ray traces with a GPU with MATLAB, and so this functionality is unavailable.') %second derivative not continuous
    end
        
    methods        
        function obj = SimulationRunPerformanceTypes(displayString, explanationString)
            obj.displayString = displayString;
            obj.explanationString = explanationString;
        end
    end
    
end