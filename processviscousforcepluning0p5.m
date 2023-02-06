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
Cx = 3;
Cy = 6;
%% statistic data, can only run onetime
[periodicity4, totalenergy4, dominantfrequency4, meanv4, sigmamean4, maxv4, minv4, dominantamp] = showp(forcefilename, Cx, Stime, file, Tper, mode)
dragforce=[periodicity4, meanv4]
[periodicity7, totalenergy7, dominantfrequency7, meanv7, sigmamean7, maxv7, minv7, dominantamp] = showp(forcefilename, Cy, Stime, file, Tper, mode)
liftforce=[periodicity7, meanv7]
periodicity = (periodicity4 * totalenergy4 + periodicity7 * totalenergy7) / (totalenergy4 + totalenergy7);
result = [k Amp meanv4/Fref, sigmamean4/Fref, maxv4/Fref, minv4/Fref,...
                meanv7/Fref, sigmamean7/Fref, maxv7/Fref, minv7/Fref,...
    periodicity, 0.5*(dominantfrequency4 + dominantfrequency7)]
%%
save('frictionresult.txt', 'result', '-ascii', '-double')
