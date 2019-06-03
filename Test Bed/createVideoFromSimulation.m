data = load('E:\Data Files\Git Repos\Gyrfalcon Data\Simulation Runs\My Head Final\My Head Final.mat');
run = data.run;

run = run.loadData('E:\Data Files\Git Repos\Gyrfalcon Data\Simulation Runs\My Head Final');

numAngles = 360;

writerObj = VideoWriter('Test Video.avi');

% open the video writer
open(writerObj);

% write the frames to the video
for i=1:numAngles
    % convert the image to a frame
    frame = run.sliceData{1}.angleData{i}.positionData{1,1}.detectorData;
    frame = applyContrastToMaximizeGrayscale(-frame,[-100,-2.93],1);

    for j=1:1
        writeVideo(writerObj, frame);
    end
end

% close the writer object
close(writerObj);