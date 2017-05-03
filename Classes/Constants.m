classdef Constants
    %Constants
    
    properties (Constant)
        version = '1.0.1';
        
        object_save_directory = 'C:\Github Code Repos\Gyrfalcon Saved Objects'
        
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
        
        Phantom_Plot_Z_Slices_Spacing = 0.15; % in m
        
        Ray_Trace_Colour = 'b';
        Ray_Trace_Point_Colour = 'w';
        
        Detector_Display_Colour = [0.33, 0.33, 0.33]; % a dark grey
        Detector_Display_Title = 'Gyrfalcon - Detector Display';
        
        
        No_File_Name_String = 'No File Selected';
        
        Slash = '\';
        
        Matlab_File_Extension = '.mat';
        PNG_File_Extension = '.png';
        MPEG4_File_Extension = '.mp4';
        AVI_File_Extension = '.avi';
                
        Processing_Run_Var_Name = 'run';
        
        Default_Simulation_Name = 'Simulation';
        Default_Phantom_Name = 'Phantom';
        Default_Detector_Name = 'Detector';
        Default_Source_Name = 'Source';
        Default_Scan_Name = 'Scan';
        Default_Photon_Beam_Name = 'Photon Beam';
        Default_Phantom_Data_Set_Name = 'Data Set';
        Default_Workspace_Name = 'Workspace';
        
        Simulation_Display_Name = 'Simulation';
        Phantom_Display_Name = 'Phantom';
        Detector_Display_Name = 'Display';
        Source_Display_Name = 'Source';
        Scan_Display_Name = 'Scan';
        Photon_Beam_Display_Name = 'Photon Beam';
        Phantom_Data_Set_Display_Name = 'Phantom Data Set';
        Workspace_Display_Name = 'Workspace';
        
        Reconstruction_Folder_Name = 'Recon';
        Reconstruction_Run_File_Name = 'Reconstruction Run';
        
        Slice_Folder = 'Slice';
        Angle_Folder = 'Angle';
        Position_Folder = 'Position';
        
        Detector_Data_Filename = 'DetectorData';
        Detector_Data_Var_Name = 'detectorData';
        
        Recon_Slices_Folder_Name = 'Slices';
        Recon_Slices_File_Name = 'Slice';
        
        FBP_Recon_Sinograms_Folder_Name = 'Sinograms';
        FBP_Recon_Sinograms_File_Name = 'Slice Sinogram';
        
        FBP_Recon_Videos_Folder_Name = 'Recon Videos';
        FBP_Recon_Videos_File_Name = 'Slice Video';
        
        Round_Off_Error_Bound = 1E-9; %1nm
    end
    
    methods
    end
    
end

