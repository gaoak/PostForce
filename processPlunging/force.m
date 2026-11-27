%%
% clear;
clc;
close all;
%% parameters
Amp = 0.5;
k=2;
%% for static case only
%  k=-1
%  Amp=0
%%
Fref = 0.5*5;
Tper = pi/k;
Stime = Tper*30;
mode = 0;
%%
% clc;
close all;
setPlotParameters;
forcefilename='force.dat';
nskip = 5;
nvars = 7;
file = loadequispacedtimeseries(forcefilename, nskip, nvars);
%%
t = file.data(:, 1);
fx = file.data(:,4);
fy = file.data(:,7);
%%
[periodicity7, totalenergy7, dominantfrequency7, meanv7, ...
    sigmamean7, maxv7, minv7, dominantamp, ~, ~, ~, nperiod] = ...
    showp(forcefilename, 7, Stime, file, Tper, mode);
result = [meanv7/Fref, maxv7/Fref, minv7/Fref, sigmamean7/Fref, 3.*sigmamean7/Fref; ...
    k, Amp, Stime/Tper, nperiod, 20261127 ]
%%
save('result.txt', 'result', '-ascii', '-double');
