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
Stime = Tper*41;
mode = 1;
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
[periodicity4, totalenergy4, dominantfrequency4, meanv4,...
    sigmamean4, maxv4, minv4, dominantamp] = ...
    showp(forcefilename, 4, Stime, file, Tper, mode);
[periodicity7, totalenergy7, dominantfrequency7, meanv7,...
    sigmamean7, maxv7, minv7, dominantamp] = ...
    showp(forcefilename, 7, Stime, file, Tper, mode);
result = [meanv4/Fref, maxv4/Fref, minv4/Fref, sigmamean4/Fref; ...
    meanv7/Fref, maxv7/Fref, minv7/Fref, sigmamean7/Fref; ...
    k, Amp, Stime, 1. ]
%%
save('result.txt', 'result', '-ascii', '-double');
