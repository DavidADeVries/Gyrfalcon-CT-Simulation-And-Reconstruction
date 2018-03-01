classdef Constants
    %Constants
    
    properties (Constant)
        version = '2.1.0';
                
        mm_to_m = (1/1000);
        m_to_mm = (1000/1);
        
        cm_to_m = (1/100);
        m_to_cm = (100/1);
        
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
        XML_File_Extension = '.xml';
        BMP_File_Extension = '.bmp';
                
        Processing_Run_Var_Name = 'run';
        Imaging_Run_Var_Name = 'run';
        
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
        Position_Filename = 'Position';
        All_Positions_Filename = 'All Positions';
        
        Detector_Data_Filename = 'Detector Data';
        Detector_Data_Var_Name = 'detectorData';
        
        Recon_Slices_Folder_Name = 'Slices';
        Recon_Slices_File_Name = 'Slice';
        Recon_Slice_Data_Var_Name = 'reconData';
        
        FBP_Recon_Sinograms_Folder_Name = 'Sinograms';
        FBP_Recon_Sinograms_File_Name = 'Slice Sinogram';
        
        FBP_Recon_Videos_Folder_Name = 'Recon Videos';
        FBP_Recon_Videos_File_Name = 'Slice Video';
        
        Imaging_Scan_Run_File_Name = 'Imaging Scan Run';
        
        Default_Ray_Trace_Matrices_File_Name = 'Ray Trace Hit Matrices';
        Default_Alpha_Matrices_File_Name = 'Alpha Matrices';      
        
        
        Temporary_Gyrfalcon_Directory = 'Gyrfalcon-Data'
        
        Alpha_Matrix_File_Name_Prefix = 'Alpha Matrix';
        Quick_Load_Alpha_Matrix_File_Name_Prefix = 'Alpha Matrix Quick';
        
        Selection_Matrices_File_Name = 'Selection Matrices';
        
        Alpha_Matrix_CT_Suffix = 'CT';
        Alpha_Matrix_Average_Suffix = 'Aver';
        Alpha_Matrix_Zero_Average_Suffix = 'Zero';
        
        Alpha_Matrix_CT_Var_Name = 'alphaMatrix_CT';
        Alpha_Matrix_Aver_Var_Name = 'alphaMatrix_Aver';
        Alpha_Matrix_Zero_Var_Name = 'alphaMatrix_Zero';
        
        Alpha_Matrix_Var_Name = 'alphaMatrix';
        Selection_Matrices_Var_Name = 'selectionMatrices';
        
        Number_Of_Voxels_In_Partitions_File_Name = 'Number of Voxels in Partitions';
        Number_Of_Voxels_In_Partitions_Var_Name = 'numVoxelsInPartitions';
        
        Hit_Vector_File_Name_Prefix = 'Hit Vector';
        Condensed_Hit_Vector_File_Name_Prefix = 'Cond Hit Vector';
        Hit_Vector_Indices_Var_Name = 'hitIndices';
        Hit_Vector_Lengths_Var_Name = 'hitLengths';
        
        Ray_Exclusion_Map_Directory = 'Ray Exclusion Maps';
        Ray_Exclusion_Map_File_Name = 'Ray Exclusion Map';
        Ray_Exclusion_Map_For_Batch_File_Name = 'Ray Exclusion Map';
        
        Ray_Exclusion_Map_Var_Name = 'rayExclusionMap';
        
        Partition_Hit_Vectors_File_Name = 'Partition Hit Vectors';
        Condensed_Partition_Hit_Vectors_File_Name = 'Cond_Partition Hit Vectors';
        
        Partition_Original_Hit_Indices_Vector_Var_Name = 'originalHitIndices';
        Partition_Hit_Indices_Vector_Var_Name = 'hitIndices';
        Partition_Hit_Lengths_Vector_Var_Name = 'hitLengths';
        Partition_Num_Hits_Vector_Var_Name = 'numHits';
        
        PAIR_Zero_Bound_File_Name = 'Zero Bound';
        PAIR_Zero_Bound_Var_Name = 'zeroBound';
        
        Projection_Values_For_Batch_File_Name = 'Batch Projection Values';
        Projection_Values_For_Batch_Var_Name = 'projectionValues';
        
        Rapid_Beta_Vector_Calculation_File_Name = 'Rapid Calculation Vectors';
        
        Rapid_Beta_Vector_Calculation_Hit_Indices_Var_Name = 'allHitIndices';
        Rapid_Beta_Vector_Calculation_Hit_Lengths_Var_Name = 'allHitLengths';
        Rapid_Beta_Vector_Calculation_Num_Hits_Var_Name = 'allNumHits';
        Rapid_Beta_Vector_Calculation_Projection_Values_Var_Name = 'allProjectionValues';
        Rapid_Beta_Vector_Calculation_Total_Num_Rays_Var_Name = 'totalNumValidRays';
        
        Full_Alpha_Matrix_File_Name = 'Full Alpha Matrix';
        Full_Alpha_Matrix_Var_Name = 'alphaMatrix';
                
        Round_Off_Error_Bound = 1E-9; %1nm
        Round_Off_Level = 10;
        
        Infinite_Radon_Sum_Approximation = 1E10;
    end
    
    methods
    end
    
end

