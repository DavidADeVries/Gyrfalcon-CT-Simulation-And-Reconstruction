function folder = makeSliceFolderName(index)
%function folder = makeSliceFolderName(index)
    folder = [Constants.Slice_Folder, ' ', num2str(index)];
end