function folder = makeAngleFolderName(angle)
% folder = makeAngleFolderName(angle)
    folder = [Constants.Angle_Folder, ' ', num2str(round(angle,2))];
end

