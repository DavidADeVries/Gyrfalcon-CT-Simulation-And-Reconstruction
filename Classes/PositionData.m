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
        distancesAcrossVoxels
        voxelPhantomCoords
        detectorCornerCoords
        sourceStartBoxCoords
        sourceEndBoxCoords
    end
    
    methods
        function data = PositionData(detectorData, distancesAcrossVoxels, voxelPhantomCoords, detectorCornerCoords, sourceStartBoxCoords, sourceEndBoxCoords)
            data.detectorData = detectorData;
            data.distancesAcrossVoxels = distancesAcrossVoxels;
            data.voxelPhantomCoords = voxelPhantomCoords;
            data.detectorCornerCoords = detectorCornerCoords;
            data.sourceStartBoxCoords = sourceStartBoxCoords;
            data.sourceEndBoxCoords = sourceEndBoxCoords;
        end
    end
    
end

