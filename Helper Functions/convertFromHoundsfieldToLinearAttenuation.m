function linearAttenuation = convertFromHoundsfieldToLinearAttenuation(data, airLinearAttenuation, waterLinearAttenuation)
%linearAttenuation = convertFromHoundsfieldToLinearAttenuation(data, airLinearAttenuation, waterLinearAttenuation)

 
linearAttenuation = ((data./1000).*(waterLinearAttenuation - airLinearAttenuation)) + waterLinearAttenuation;

min = allMin(linearAttenuation);

if min < 0;
    linearAttenuation = linearAttenuation - min; %can't have 0 value
end
    

end

