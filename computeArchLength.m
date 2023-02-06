function s = computeArchLength(x, y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
s = 0*x;
len = length(x);
for ii=2:1:len
    s(ii) = s(ii-1) + sqrt((x(ii)-x(ii-1))^2+(y(ii)-y(ii-1))^2);
end
end

