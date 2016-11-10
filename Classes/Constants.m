classdef Constants
    %Constants
    
    properties (Constant)
        mm_to_m = (1/1000);
        m_to_mm = (1000/1);
        
        deg_to_rad = (pi/180);
        rad_to_deg = (180/pi);
        
        Detector_Colour = 'r';
        Detector_Back_Colour = [1 0 0] .* 0.75;
        
        Source_Colour = 'g';
        Slice_Colour = 'b';
        Per_Angle_Translation_Colour = 'm';
        Per_Angle_Translation_Tick_Length = 1/100; %in m
        Point_Source_Radius = 1/100; %in m's, 10mm
        Phantom_Alpha = 0.5;
        
        No_File_Name_String = 'No File Selected';
        
        Slash = '\';
        
        Matlab_File_Extension = '.mat';
        
        Default_Workspace_File_Name = 'Workspace';
        
        Default_Phantom_Data_Set_File_Name = 'Phantom Data Set';
        Save_Phantom_Data_Set_Var_Name = 'dataSet';
        
        Save_Workplace_Simulation_Var_Name = 'simulation';
        Save_Workplace_Status_Output_Var_Name = 'statusOutput';
    end
    
    methods
    end
    
end

