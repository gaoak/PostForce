%%
% clear;
%% parameters
aoa = 15/180.*pi;
k=pi/2;
Amp = 0.5;
forcefilename='force.dat';
%% dependent parameters
Fref = 0.5;
Stime = 0;
Tper = pi/k;
mode = 1;
StA = k*Amp/pi
%% load data
% clc;
close all;
setPlotParameters;
nskip = 5;
nvars = 7;
file = loadequispacedtimeseries(forcefilename, nskip, nvars);
Npts = round(Tper/file.dt);
meandata = movmean(file.data, Npts);
save('meanforce.dat', 'meandata', '-ascii', '-double')