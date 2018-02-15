path = 'G:\5525';

files = dir(path);

sliceLocations = [];
dataSlices = {};

counter = 1;

for i=1:length(files)
    if ~files(i).isdir
        data = dicomread(makePath(path, files(i).name));

        if ~isempty(data)
            dataSlices{counter} = data;

            info = dicominfo(makePath(path, files(i).name));
            sliceLocations(counter) = info.SliceLocation;

            counter = counter + 1;
        end
    end
end

numSlices = length(sliceLocations);

sliceDims = size(dataSlices{1});

dataSet = zeros(sliceDims(1),sliceDims(2),numSlices);

[~,indices] = sort(sliceLocations, 'descend');

for i=1:numSlices
    dataSet(:,:,i) = dataSlices{indices(i)};
end

dataSet = double(dataSet);
dataSet = dataSet - 1024;