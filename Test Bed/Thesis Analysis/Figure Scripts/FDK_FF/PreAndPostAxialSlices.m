% load-up images
pre1500_cath = loadOpticalCtVistaRecon('E:\Thesis Recon Data\Gel 2-4 (FF-R)\Gel 2-4 (FF-R)_HR.vff');
post1500_cath = loadOpticalCtVistaRecon('E:\Thesis Recon Data\Gel 2-4 (FF-D)\Gel 2-4 (FF-D)_HR.vff');

pre1500_control = loadOpticalCtVistaRecon('E:\Thesis Recon Data\Gel 2-3 (FF-R)\Gel 2-3 (FF-R)_HR.vff');
post1500_control = loadOpticalCtVistaRecon('E:\Thesis Recon Data\Gel 2-3 (FF-D)\Gel 2-3 (FF-D)_HR.vff');

delta_cath = post1500_cath - pre1500_cath;
delta_control = post1500_control - pre1500_control;

gel1500_cath = loadOpticalCtVistaRecon('E:\Thesis Recon Data\Gel 2-4\Gel 2-4_HR.vff');
gel1500_control = loadOpticalCtVistaRecon('E:\Thesis Recon Data\Gel 2-3\Gel 2-3_HR.vff');

diff_cath = gel1500_cath - delta_cath;
diff_control = gel1500_control - delta_control;

% analysis params
slice = 128;

prePostThreshold = [0, 17];
deltaMuThreshold = [0, 9.7];
diffThreshold = [-5E-5,5E-5];

prePostTicks = [];
deltaMuTicks = [];
diffTicks = [-5E-5,0,5E-5];

colourbarLabel = '$\mu$ $[cm^{-1}]$';
deltaColourbarLabel = '$\Delta\mu$ $[cm^{-1}]$';

imageHeightInCm = 2.3;

unitConversion = 1/100; % m-1 to cm-1


%% Write images

root = 'E:\Thesis Figures\Results\FDK_FF\FDK_FF Analysis\';

writeSliceImagesFromFigure(...
    [root, 'Control Pre.png'],...
    pre1500_control(:,:,slice),...
    unitConversion, prePostThreshold,...
    imageHeightInCm, prePostTicks, colourbarLabel,...
    {}, {}, {}, {}, {});

writeSliceImagesFromFigure(...
    [root, 'Control Post.png'],...
    post1500_control(:,:,slice),...
    unitConversion, prePostThreshold,...
    imageHeightInCm, prePostTicks, colourbarLabel,...
    {}, {}, {}, {}, {});

writeSliceImagesFromFigure(...
    [root, 'Cath Pre.png'],...
    pre1500_cath(:,:,slice),...
    unitConversion, prePostThreshold,...
    imageHeightInCm, prePostTicks, colourbarLabel,...
    {}, {}, {}, {}, {});

writeSliceImagesFromFigure(...
    [root, 'Cath Post.png'],...
    post1500_cath(:,:,slice),...
    unitConversion, prePostThreshold,...
    imageHeightInCm, prePostTicks, colourbarLabel,...
    {}, {}, {}, {}, {});

writeSliceImagesFromFigure(...
    [root, 'Control Delta Mu.png'],...
    delta_control(:,:,slice),...
    unitConversion, deltaMuThreshold,...
    imageHeightInCm, deltaMuTicks, deltaColourbarLabel,...
    {}, {}, {}, {}, {});

writeSliceImagesFromFigure(...
    [root, 'Cath Delta Mu.png'],...
    delta_cath(:,:,slice),...
    unitConversion, deltaMuThreshold,...
    imageHeightInCm, deltaMuTicks, deltaColourbarLabel,...
    {}, {}, {}, {}, {});

writeSliceImagesFromFigure(...
    [root, 'Control FDK Diff.png'],...
    diff_control(:,:,slice),...
    unitConversion, diffThreshold,...
    imageHeightInCm, diffTicks, deltaColourbarLabel,...
    {}, {}, {}, {}, {});

writeSliceImagesFromFigure(...
    [root, 'Cath FDK Diff.png'],...
    diff_cath(:,:,slice),...
    unitConversion, diffThreshold,...
    imageHeightInCm, diffTicks, deltaColourbarLabel,...
    {}, {}, {}, {}, {});

