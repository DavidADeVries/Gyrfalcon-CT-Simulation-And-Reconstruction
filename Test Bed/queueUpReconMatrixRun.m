function [] = queueUpReconMatrixRun(app)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

numIterList = {10, 15};

subsetsList = {...
    [26 2],...
    [51 3],...
    [103 6],...
    [205 13],...
    [205 41]};

cList = {0.001, 0.005, 0.01, 0.05, 0.1};

for k=1:length(numIterList)
    numIters = numIterList{k};
    
    for j=1:length(subsetsList)
        subsets = subsetsList{j};
        
        for i=1:length(cList)
            c = cList{i};
            
            app.CBCT_OSCTV_NumberOfIterationsEditField.Value = numIters;
            app.CBCT_OSCTV_CEditField.Value = c;
            app.CBCT_OSCTV_InitialBlockSizeEditField.Value = subsets(1);
            app.CBCT_OSCTV_FinalBlockSizeEditField.Value = subsets(2);
            
            uiwait(msgbox('Ready 1?'));
            
            dataSetReconAddToQueueButtonCallback(app);            
        end
    end
end

end

