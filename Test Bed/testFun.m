function s = testFun(m)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

m = m{1};

l = length(m);

s = 0;

for i=1:l-1
    s = s + m(i); 
end

s = s ./ m(end);

end

