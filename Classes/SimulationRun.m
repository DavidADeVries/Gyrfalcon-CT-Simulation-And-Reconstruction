classdef SimulationRun < ProcessingRun
    % SimulationRun
    % Holds data from when the simulation in question was run
    %
    % FIELDS:
    % *simulation
    % See Simulation class. Holds the Simulation used during the Simulation
    % Run
    %
    % *startTimestamp
    % Unix timestamp of when the simulation run began
    %
    % *endTimestamp
    % Unix timestamp of when the simulation run ended
    %
    % *displayFreeRun
    % boolean that is true if and only if no display/visualizations were
    % turned on during the simulation run. This would allow for maximum speed
    % in the simulation run. Comparing simulation run speeds from runs with
    % any display/visualizations activated is not recommended, as these
    % would bog down run times
    %
    % *computerInfo
    % string with some notes about the computerArchitectureUsed
    
    
    properties
        simulation
        
        displayFreeRun
        
        data
    end
    
    methods
        function simulationRun = SimulationRun(simulation, displayFreeRun)
            % SimulationRun specific
            simulationRun.simulation = simulation;            
            simulationRun.displayFreeRun = displayFreeRun;
            
            % Set notes and save path at initialization            
            simulationRun = simulationRun.collectNotes();
            simulationRun = simulationRun.collectSavePathAndFilename();
            
            % set by startRun and endRun functions:            
            simulationRun.data = [];
        end
        
        function simulationRun = startRun(simulationRun)
            simulationRun = simulationRun.startProcessingRun();
        end
        
        function simulationRun = endRun(simulationRun, data)
            simulationRun = simulationRun.endProcessingRun();
            
            % SimulationRun specific
            simulationRun.data = data;
        end
        
                
    end
    
end

