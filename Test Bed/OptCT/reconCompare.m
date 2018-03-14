withCath = openOptCtVistaRecon('G:\CATH 002 With Catheter\CATH 002 With Catheter_HR.vff');
withCath_Data = openOptCtVistaRecon('G:\CATH 002 With Catheter Data\CATH 002 With Catheter Data_HR.vff');
withCath_Ref = openOptCtVistaRecon('G:\CATH 002 With Catheter Ref\CATH 002 With Catheter Ref_HR.vff');
noCath = openOptCtVistaRecon('G:\CATH 002 No Catheter\CATH 002 No Catheter_HR.vff');
noCath_Data = openOptCtVistaRecon('G:\CATH 002 No Catheter Data\CATH 002 No Catheter Data_HR.vff');
noCath_Ref = openOptCtVistaRecon('G:\CATH 002 No Catheter Ref\CATH 002 No Catheter Ref_HR.vff');

slice = 200;

cathMin = min(min(noCath(:,:,slice)));
cathMax = max(max(noCath(:,:,slice)));

dataRefMin = min(min(noCath_Data(:,:,slice)));
dataRefMax = max(max(noCath_Data(:,:,slice)));

figure(40);imshow(noCath_Data(:,:,slice),[dataRefMin, dataRefMax]);
figure(41);imshow(noCath_Ref(:,:,slice),[dataRefMin, dataRefMax]);

figure(42);imshow(withCath_Data(:,:,slice),[dataRefMin, dataRefMax]);
figure(43);imshow(withCath_Ref(:,:,slice),[dataRefMin, dataRefMax]);

figure(44);imshow(noCath(:,:,200),[cathMin, cathMax]);
figure(45);imshow(withCath(:,:,200),[cathMin, cathMax]);