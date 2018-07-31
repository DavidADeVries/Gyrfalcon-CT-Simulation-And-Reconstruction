%% OSC-TV Slices
path = 'E:\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2)\';
usedFloodField = false;

slice = 216/2;

threshold = [0 13.4];
ticks = [];

colourbarLabel = '$\Delta\mu$ $[cm^{-1}]$';


imageHeightInCm = 2.8;


unitConversion = 1/100; % m-1 to cm-1


root = 'E:\Thesis Figures\Results\OSC-TV\Full Optimization\';
%% run
for recon = 26:50
    reconData = loadGyrfalconVolume(path, recon, usedFloodField);
    

    writeSliceImagesFromFigure(...
        [root, 'OSC-TV Recon ', num2str(recon), '.png'],...
        reconData(:,:,slice),...
        unitConversion, threshold,...
        imageHeightInCm, ticks, colourbarLabel,...
        {}, {}, {}, {}, {});
    
end

%% FDKs
slice = 256/2;

gel2000MU_control = loadOpticalCtVistaRecon('E:\Thesis Recon Data\Gel 4-1\Gel 4-1_HR.vff');
gel2000MU_fdk = loadOpticalCtVistaRecon('E:\Thesis Recon Data\Gel 4-2\Gel 4-2_HR.vff');

writeSliceImagesFromFigure(...
        [root, 'FDK Recon.png'],...
        gel2000MU_fdk(:,:,slice),...
        unitConversion, threshold,...
        imageHeightInCm, ticks, colourbarLabel,...
        {}, {}, {}, {}, {});
    
writeSliceImagesFromFigure(...
        [root, 'FDK Recon Control.png'],...
        gel2000MU_control(:,:,slice),...
        unitConversion, threshold,...
        imageHeightInCm, ticks, colourbarLabel,...
        {}, {}, {}, {}, {});
    
    