classdef Constants
    %Constants
    
    properties (Constant)
        version = '1.0.1';
        
        mm_to_m = (1/1000);
        m_to_mm = (1000/1);
        
        deg_to_rad = (pi/180);
        rad_to_deg = (180/pi);
        
        Detector_Colour = 'r';
        Detector_Back_Colour = [1 0 0] .* 0.75;
        detector_line_height = 0.05; % in M
        
        Source_Colour = 'g';
        Slice_Colour = 'c';
        Per_Angle_Translation_Colour = 'm';
        Per_Angle_Translation_Tick_Length = 1/100; %in m
        Point_Source_Radius = 1/100; %in m's, 10mm
        Phantom_Alpha = 0.5;
        Detector_Raster_Colour = [1,0.6,0.6];
        Detector_Raster_Alpha = 0.5;
        
        Ray_Trace_Colour = 'b';
        Ray_Trace_Point_Colour = 'w';
        
        Detector_Display_Colour = [0.33, 0.33, 0.33]; % a dark grey
        Detector_Display_Title = 'Gyrfalcon - Detector Display';
        
        
        No_File_Name_String = 'No File Selected';
        
        Slash = '\';
        
        Matlab_File_Extension = '.mat';
        
        Default_Workspace_File_Name = 'Workspace';
        
        Default_Phantom_Data_Set_File_Name = 'Phantom Data Set';
        Save_Phantom_Data_Set_Var_Name = 'dataSet';
        
        Save_Workplace_Simulation_Var_Name = 'simulation';
        Save_Workplace_Status_Output_Var_Name = 'statusOutput';
        
        Default_Beam_Characterization_File_Name = 'Photon Beam';
        Save_Beam_Characterization_Var_Name = 'photonBeam';
        
        Processing_Run_Var_Name = 'run';
    end
    
    methods
    end
    
end

