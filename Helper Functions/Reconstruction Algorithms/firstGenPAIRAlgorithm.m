function reconDataSetSlices = firstGenPAIRAlgorithm(reconstruction, simulationRun)
% reconDataSetSlices = firstGenPAIRAlgorithm(reconstruction, simulationRun)

firstGenData = simulationRun.compileProjectionDataFor1stGenRecon();

originalIntensity = simulationRun.simulation.scan.beamCharacterization.rawIntensity();

numSlices = length(firstGenData);

radonProjectionData = cell(size(firstGenData));

for i=1:numSlices
    sliceData = firstGenData{i};
    
    radonProjectionData{i} = - reallog(sliceData ./ originalIntensity);
end 

reconDataSetSlices = cell(size(firstGenData));

sliceDims = reconstruction.reconSliceDimensions;

for i=1:numSlices
    if reconstruction.usePrecomputedAlphaMatrix
        alphaMatrix = reconstruction.loadAlphaMatrix();
    else
        [alphaMatrix, betaVector] = computeAlphaAndBetaValues(reconstruction, simulationRun, radonProjectionData{1});
        
        %reconstruction.saveAlphaMatrix(alphaMatrix);
    end
    
    attenuationValues = alphaMatrix \ betaVector;
    
    reconDataSetSlices{i} = reshape(attenuationValues, [sliceDims(2), sliceDims(1)]);
end

end

