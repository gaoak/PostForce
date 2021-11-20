function [phases] = getfileDividers(file, Tper, n)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
phases = {};
tstart = file.data(1, 1);
nlen = length(file.data(:, 1));
Nskip = round(Tper/file.dt);
for ii=1:1:n
    Nstart = 1 + mod(round((Tper*(ii-1)/n - tstart)/file.dt), Nskip);
    phases{ii}=[Nstart:Nskip:nlen]';
end
end