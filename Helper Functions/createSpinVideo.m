function frames = createSpinVideo(simulationRun, windowRange, invert)
    
    if invert
        mult = -1;
        low = -windowRange(2);
        high = -windowRange(1);
        windowRange = [low,high];
    else
        mult = 1;
    end
    
    basePath = 'C:\Github Code Repos\Run Tests\Patient CT 360 3\Slice 1';
        
    %sliceData = simulationRun.data{1};
    
    %anglesData = sliceData.angleData;
    
    %numAngles = length(anglesData);
    
    filename = 'C:\Github Code Repos\Frames\video8.mp4';
    
    frames = zeros(350,500,1,(360/15)+1);
    
    v = VideoWriter(filename, 'MPEG-4');
    open(v);
    
    filenameCounter = 1;
    
    for j=1:3
    for i=0:3:357
        %saveName = [filename, num2str(i), '.png'];
        
        readPath = makePath(basePath, ['Angle ', num2str(i)],'Position (1,1)','detectorData.mat');
                
        loadVars = load(readPath);
        
        data = loadVars.detectorData;
        
        %data = mult*anglesData{i}.positionData{1}.detectorData;
        
        data = mult*data;
        
        data = imrotate(data,180);
        
        adjImage = applyContrastToMaximizeGrayscale(data, windowRange, 1);
        
%         frames(:,:,1,filenameCounter) = adjImage;
%         filenameCounter = filenameCounter + 1;
%         
%         if i == 0
%             frames(:,:,1,25) = adjImage;
%         end
        
        %imwrite(adjImage,saveName);
        
%         for j=1:1
%             frames(:,:,1,((i-1)*1)+j) = adjImage;
%             frames(:,:,2,((i-1)*1)+j) = adjImage;
%             frames(:,:,3,((i-1)*1)+j) = adjImage;
%         end

        writeVideo(v,adjImage);
    end
    end
    
%     for i=90:-3:3
%         %saveName = [filename, num2str(i), '.png'];
%         
%         readPath = makePath(basePath, ['Angle ', num2str(i)],'Position (1,1)','detectorData.mat');
%         
%         loadVars = load(readPath);
%         
%         data = loadVars.detectorData;
%         
%         %data = mult*anglesData{i}.positionData{1}.detectorData;
%         
%         data = mult*data;
%         
%         data = imrotate(data,180);
%         
%         adjImage = applyContrastToMaximizeGrayscale(data, windowRange, 1);
%         
%         %imwrite(adjImage,saveName);
%         
% %         for j=1:1
% %             frames(:,:,1,((i-1)*1)+j) = adjImage;
% %             frames(:,:,2,((i-1)*1)+j) = adjImage;
% %             frames(:,:,3,((i-1)*1)+j) = adjImage;
% %         end
% 
%         writeVideo(v,adjImage);
%         writeVideo(v,adjImage);
%         writeVideo(v,adjImage);
%     end
    
    close(v);
    %mov = immovie(frames);
end