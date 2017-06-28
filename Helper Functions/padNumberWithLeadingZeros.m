function string = padNumberWithLeadingZeros(number, numLeadingZeros)
%string = padNumberWithLeadingZeros(number, numLeadingZeros)

string = num2str(number);

strLen = length(string);

for i=1:numLeadingZeros - strLen
    string = ['0', string];
end


end

