classdef ReconstructionRunPerformanceTypes
    % ReconstructionRunPerformanceTypes
    % types of performance levels for computations for sim runs
    
    properties
        displayString
        explanationString
    end
    
    enumeration
        high (....
            'High',...
            'Computations are optimizing using MATLAB vectorization and arrayfun. MATLAB may use multiple cores to complete the computations, but no more than one will be used at one time.')
        
        highWithMultipleCPUs (...
            'High with Multiple CPUs',...
            'Computations are performed using the same MATLAB optimizations are with High Performance, though the are distributed between the specified number of CPUs. These CPUs will work in parallel, each using MATLAB optimization.')
        
        highWithGPU (...
            'High with GPU',...
            'At current, it is unknown how to accelerate the required computation of reconstructions with a GPU with MATLAB, and so this functionality is unavailable.')
    end
        
    methods        
        function obj = ReconstructionRunPerformanceTypes(displayString, explanationString)
            obj.displayString = displayString;
            obj.explanationString = explanationString;
        end
    end
    
end