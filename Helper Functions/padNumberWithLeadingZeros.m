function string = padNumberWithLeadingZeros(number, numLeadingZeros)
%string = padNumberWithLeadingZeros(number, numLeadingZeros)

string = num2str(number);

strLen = length(numStr);

for i=1:strLen - numLeadingZeros
    string = ['0', string];
end


end

