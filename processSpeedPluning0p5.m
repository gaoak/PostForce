%%
% clear;
%% parameters
forcefilename='force.dat';
freq=0.666667;
Tper = 1/freq;
Amp = 0.3;
%% dependent parameters
Stime = 0;
mode = 1;
%% load data
% clc;
close all;
setPlotParameters;
nskip = 1;
nvars = 7;
file = loadequispacedtimeseries(forcefilename, nskip, nvars);
t = file.data(:, 1);
speed = file.data(:,4);
%%
[periodicity4, totalenergy4, dominantfrequency4, meanv4, sigmamean4, maxv4, minv4, dominantamp] = showp(forcefilename, 4, Stime, file, Tper, mode)
result = [1/Tper Amp meanv4, sigmamean4, maxv4, minv4,...
    periodicity4, dominantfrequency4]
%%
save('result.txt', 'result', '-ascii', '-double')
meanv4*2