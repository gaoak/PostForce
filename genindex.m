function [res] = genindex(xs,xe,det,array)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
res = [];
for x=xs:det:xe
    [~, idx] = min(abs(array-x));
    res = [res; idx];
end
end