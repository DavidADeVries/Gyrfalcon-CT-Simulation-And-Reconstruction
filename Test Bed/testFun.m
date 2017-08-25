function a = testFun(m)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

len = length(m);

a = zeros(len,1);

for i=1:len
    a(i) = sum(m{i});
end

end

