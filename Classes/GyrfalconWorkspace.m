classdef GyrfalconWorkspace < GyrfalconObject
    % GyrfalconWorkspace
    
    properties
        statusOutput
        
        simulation       
        simulationRun
        
        reconstructionRun
    end
    
    methods
        function workspace = GyrfalconWorkspace(statusOutput, simulation, simulationRun)
            if nargin > 0
                workspace.statusOutput = statusOutput;
            
                workspace.simulation = simulation;
                workspace.simulationRun = simulationRun;
            end
        end
        
        function object = createBlankObject(object)
            object = GyrfalconWorkspace;
        end
        
        function name = displayName(workspace)
            name = 'Workspace';
        end
        
        function workspace = setDefaultValues(workspace)
            workspace.statusOutput = '';
            
            sim = Simulation;
            sim = sim.setDefaultValues();
            
            workspace.simulation = sim;
            
            simRun = SimulationRun;
            simRun = simRun.setDefaultValues();
            
            workspace.simulationRun = simRun;
            
            reconRun = ReconstructionRun;
            reconRun = reconRun.setDefaultValues();
            
            workspace.reconstructionRun = reconRun;
        end
        
        function [saved, workspaceForGUI, workspaceForParent, workspaceForSaving] = saveChildrenObjects(workspace)
            workspaceForGUI = workspace;
            workspaceForParent = workspace;
            workspaceForSaving = workspace;
            
            if ~isempty(workspace.simulation)
                [saved, simulationForGUI, simulationForParent, ~] = workspace.simulation.saveAsIfChanged();
                
                if saved
                    workspaceForGUI.simulation = simulationForGUI;
                    workspaceForParent.simulation = simulationForParent;
                    workspaceForSaving.simulation = simulationForParent;
                end
            else
                saved = true;
            end
            
            % simulationRun
            if ~isempty(workspace.simulationRun.savePath)
                simRunForSaving = SimulationRun;
                
                simRunForSaving.savePath = workspace.simulationRun.savePath;
                simRunForSaving.saveFileName = workspace.simulationRun.saveFileName;
                
                workspaceForParent.simulationRun = simRunForSaving;
                workspaceForSaving.simulationRun = simRunForSaving;
            end
            
            % reconstructionRun
            % save everything with workspace, are not saved independently
        end
        
        function workspace = loadFields(workspace)
            workspace.simulation = workspace.simulation.load();
            
            if ~isempty(workspace.simulationRun.savePath)
                loadPath = makePath(workspace.simulationRun.savePath, workspace.simulationRun.saveFileName);
                
                loadedData = load(loadPath);
                
                workspace.simulationRun = get(loadedData, Constants.Processing_Run_Var_Name);
            end
        end        
        
        function name = defaultName(workspace)            
            name = [Constants.Default_Workspace_Name, Constants.Matlab_File_Extension]; 
        end
         
        function bool = equal(workspace1, workspace2)
            b1 = strcmp(workspace1.statusOutput, workspace2.statusOutput);
            b2 = gyrfalconObjectsEqual(workspace1.simulation, workspace2.simulation);
            
            bool = b1 && b2;
        end
        
        function app = setGUI(workspace, app)
            app.StatusOutputTextArea.Value = workspace.statusOutput;
            
            path = workspace.getPath();
            
            if isempty(path)
                path = 'Unsaved Workspace';
            end
            
            app.GyrfalconUIFigure.Name = ['Gyrfalcon - ', path];
            
            app = workspace.simulation.setGUI(app);
            app = workspace.simulationRun.setGUIForScanSimulation(app);
            app = workspace.reconstructionRun.setGUI(app);
        end
        
        function workspace = createFromGUI(workspace, app)
            workspace.statusOutput = app.StatusOutputTextArea.Value;
                        
            workspace.simulation = workspace.simulation.createFromGUI(app);
            
            workspace.simulationRun = workspace.simulationRun.createFromGUI(app);
            
            workspace.reconstructionRun = workspace.reconstructionRun.createFromGUI(app);
        end
    end
    
end

