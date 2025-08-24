function [v2] = transform(v1, angle)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
cs = cos(angle);
si = sin(angle);
v2(:,1) = cs .* v1(:,1) - si .* v1(:,2);
v2(:,2) = si .* v1(:,1) + cs .* v1(:,2);
end