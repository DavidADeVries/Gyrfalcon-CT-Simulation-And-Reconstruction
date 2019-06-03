classdef PositionData
    % PositionData
    % holds the simulation run data for each position of the
    % source/detector
    
    % *detectorData
    % matrix of intensity values measured by the detectors
    %
    % *distancesAcrossVoxels
    % cell array, with an matrix for each detector containing the distance
    % across the voxels traversed by the ray to get to the detector.
    % Voxel distance encountered first from the source are at the top of
    % the matrix
    %
    % *voxelPhantomCoords
    % cell array, with a matrix for each detector containing the coords in
    % the phantom data set that are traversed by the ray to get to the
    % detector, again in order from the first traversed at the top
    
    properties
        detectorData
        rayRejectionMap
        
        attenuationCoords
        attenuationDistances
        detectorCornerCoords
        sourceStartBoxCoords
        sourceEndBoxCoords
    end
    
    methods
        function data = PositionData(detectorData, rayRejectionMap, attenuationCoords, attenuationDistances, detectorCornerCoords, sourceStartBoxCoords, sourceEndBoxCoords)
            if nargin ~= 0
                data.detectorData = detectorData;
                data.rayRejectionMap = rayRejectionMap;
                data.attenuationCoords = attenuationCoords;
                data.attenuationDistances = attenuationDistances;
                data.detectorCornerCoords = detectorCornerCoords;
                data.sourceStartBoxCoords = sourceStartBoxCoords;
                data.sourceEndBoxCoords = sourceEndBoxCoords;
            end
        end
        
        function data = clearBeforeSave(data)
            data.detectorData = [];
            data.rayRejectionMap = [];
            data.attenuationCoords = [];
            data.attenuationDistances = [];
            data.detectorCornerCoords = [];
        end
        
        function data = saveBigData(data, savePath)
            detectorData = data.detectorData;
            
            filename = [Constants.Detector_Data_Filename, Constants.Matlab_File_Extension];
            
            save(makePath(savePath,filename),Constants.Detector_Data_Var_Name);
            
%             dims = size(data.distancesAcrossVoxels);
%             
%             for i=1:dims(1)
%                 for j=1:dims(2)
%                     fileSavePath = makePath(savePath, ['Detector (',num2str(i),',',num2str(j),')']);
%                     
%                     distancesAcrossVoxels = data.distancesAcrossVoxels{i,j};
%                     voxelPhantomCoords = data.voxelPhantomCoords{i,j};
%                     detectorCornerCoords = data.detectorCornerCoords{i,j};
%                     
%                     saveDetectorData(fileSavePath, distancesAcrossVoxels, voxelPhantomCoords, detectorCornerCoords)
%                 end
%             end
        end
        
        function positionData = loadData(positionData, loadPath)            
            % detector data
            loadedData = load(makeDetectorDataFileName(loadPath));

            positionData.detectorData = loadedData.(Constants.Detector_Data_Var_Name);
            
            % ray rejection map
            loadedData = load(makeRayExclusionMapFileName(loadPath));
            positionData.rayRejectionMap = loadedData.(Constants.Ray_Exclusion_Map_Var_Name);
        end
    end
    
end

