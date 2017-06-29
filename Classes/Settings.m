classdef Settings
    % Settings
    % Holds Settings that can be changed by the user within the GUI
    % These are different than Constants, because Constants should ideally
    % not be changed by the user
    
    properties
        Simulation_Save_Path
        Simulation_And_Reconstruction_Run_Save_Path
        Imaging_Scan_Run_Save_Path
    end
    
    methods (Static)
        function filePath = getSettingsFilePath()
            filePath = makePath(pwd, ['Gyrfalcon User Settings', Constants.Matlab_File_Extension]);
        end
        
        function [] = load(app)
            fileData = load(Settings.getSettingsFilePath());
            
            settings = fileData.('settings');
            
            app.settings = settings;
            
            settings.setGUI(app);
        end
    end
    
    methods
        function settings = Settings()
            % defaults here!
            settings.Simulation_Save_Path = 'C:\';
            settings.Simulation_And_Reconstruction_Run_Save_Path = 'C:\';
            settings.Imaging_Scan_Run_Save_Path = 'C:\';
        end
        
        function [] = changeSimulationSavePath(settings, app)
            newFolder = uigetdir(settings.Simulation_Save_Path, 'Select Default Simulation Save Folder');
            
            if newFolder ~= 0 % not cancelled
                settings.Simulation_Save_Path = newFolder;
                
                app.settings = settings;
                
                % update GUI
                settings.setGUI(app);
                
                % save settings back to file
                settings.save();
            end
        end
        
        function [] = changeSimulationReconstructionRunSavePath(settings, app)
            newFolder = uigetdir(settings.Simulation_And_Reconstruction_Run_Save_Path, 'Default Simulation/Reconstruction Run Save Folder:');
            
            if newFolder ~= 0 % not cancelled
                settings.Simulation_And_Reconstruction_Run_Save_Path = newFolder;
                
                app.settings = settings;
                
                % update GUI
                settings.setGUI(app);
                
                % save settings back to file
                settings.save();
            end
        end
        
        function [] = changeImagingScanRunSavePath(settings, app)
            newFolder = uigetdir(settings.Imaging_Scan_Run_Save_Path, 'Default Imaging Scan Run Save Folder:');
            
            if newFolder ~= 0 % not cancelled
                settings.Imaging_Scan_Run_Save_Path = newFolder;
                
                app.settings = settings;
                
                % update GUI
                settings.setGUI(app);
                
                % save settings back to file
                settings.save();
            end
        end
        
        function [] = save(settings)
            savePath = Settings.getSettingsFilePath();
            
            save(savePath, 'settings');
        end
        
        function [] = setGUI(settings, app)
            app.SimulationSavePathSettingEditField.Value = settings.Simulation_Save_Path;
            app.SimulationReconstructionRunSavePathSettingEditField.Value = settings.Simulation_And_Reconstruction_Run_Save_Path;
            app.ImagingScanRunSavePathSettingEditField.Value = settings.Imaging_Scan_Run_Save_Path;
        end
        
    end
end

