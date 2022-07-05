%%
% clear;
%% parameters

%%
Stime = 0;
Tper = 1;
mod = 1;
%%
% clc;
close all;
setPlotParameters;
forcefilename='node1.dat';
nskip = 1;
nvars = 7;
file = loadequispacedtimeseries(forcefilename, nskip, nvars);
%%
t = file.data(:, 1);
u = file.data(:,4);
figure
plot(t, u, 'b-')
%%
[periodicity4, totalenergy4, dominantfrequency4, meanv4, sigmamean4, maxv4, minv4, dominantamp] = showp(forcefilename, 4, Stime, file, Tper, mod)

result = [meanv4, sigmamean4, maxv4, minv4, periodicity4, dominantfrequency4]
%%
save('result.txt', 'result', '-ascii', '-double')