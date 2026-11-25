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
Stime = Tper*(41.5);
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
dragforce=[periodicity4, meanv4];
[periodicity7, totalenergy7, dominantfrequency7, meanv7,...
    sigmamean7, maxv7, minv7, dominantamp] = ...
    showp(forcefilename, 7, Stime, file, Tper, mode);
liftforce=[periodicity7, meanv7];
periodicity = (periodicity4 * totalenergy4 + periodicity7 * totalenergy7) / (totalenergy4 + totalenergy7);
result = [meanv4/Fref, maxv4, minv4, sigmamean4/Fref; ...
    meanv7/Fref, maxv7, minv7, sigmamean7/Fref; ...
    periodicity, k, Amp, Stime ]
%%
save('result.txt', 'result', '-ascii', '-double');
