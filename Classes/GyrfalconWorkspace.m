classdef GyrfalconWorkspace < GyrfalconObject
    % GyrfalconWorkspace
    
    properties
        statusOutput
        
        simulation
    end
    
    methods
        function workspace = GyrfalconWorkspace(statusOutput, simulation)
            if nargin > 0
                workspace.statusOutput = statusOutput;
            
                workspace.simulation = simulation;
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
        end
        
        function workspace = loadFields(workspace)
            workspace.simulation = workspace.simulation.load();
        end        
        
        function name = defaultName(workspace)            
            name = [Constants.Default_Workspace_Name, Constants.Matlab_File_Extension]; 
        end
         
        function bool = equal(workspace1, workspace2)
            b1 = strcmp(workspace1.statusOutput, workspace2.statusOutput);
            b2 = gyrfalconObjectsEqual(workspace1.simulation, workspace2.simulation);
            
            bool = b1 && b2;
        end
        
        function handles = setGUI(workspace, handles)
            setString(handles.statusOutputText, workspace.statusOutput);
            
            path = workspace.getPath();
            
            if isempty(path)
                path = 'Unsaved Workspace';
            end
            
            set(handles.gyrofalconMain, 'Name', ['Gyrfalcon - ', path]);
            
            workspace.simulation.setGUI(handles);
        end
        
        function workspace = createFromGUI(workspace, handles)
            workspace.statusOutput = getString(handles.statusOutputText);
                        
            workspace.simulation = workspace.simulation.createFromGUI(handles);
        end
    end
    
end

