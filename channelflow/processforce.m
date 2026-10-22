%%
clear;
clc;
close all;
%% parameters
setPlotParameters;
Tper = 1.;
mode = 2;
nskip = 1;
nvars = 7;
Fref=0.5;
nu = 1./2857.;
%%
Stime = 20;
vars = {'taulower', 'Retaulower', 'tauupper', 'Retauupper'};
infname = strcat('ForceLE.fce')
file = loadequispacedtimeseries(infname, nskip, nvars);
[periodicity4, totalenergy4, dominantfrequency4, meanv4, sigmamean4, maxv4, minv4, dominantamp4, std4] = showp(infname, 4, Stime, file, Tper, 1);
saveas(gcf, strcat('LE.png'));

infname = strcat('ForceTE.fce')
file = loadequispacedtimeseries(infname, nskip, nvars);
[periodicity5, totalenergy5, dominantfrequency5, meanv5, sigmamean5, maxv5, minv5, dominantamp5, std5] = showp(infname, 4, Stime, file, Tper, 1);
saveas(gcf, strcat('TE.png'));
    
tau = meanv4 / (2*pi*pi);
result  =[tau(1), sqrt(tau(1))/nu]
save('meanfriction.txt', 'result', '-ascii', '-double')
%%
% result([16 21 7 5])
% mean y, Amp y, f y; mean CL, Amp CL, f CL
% result([6, 7, 8;21, 22, 23])