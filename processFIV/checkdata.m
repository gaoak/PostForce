%%
clear;
clc;
close all;
%%
AoA=15.;
Mass=1.;
%% parameters
setPlotParameters;
Tper = -1.;
mode = 3;
nskip = 1;
nvars = 7;
Fref=0.5;
%%
freq = [0:0.025:10];
vars = {'AoA',  'Mass', 'fn', 'invfn',  'invTper', ...
        'ymean', 'yamp', 'fy', 'ystd', 'sigmaymean', ...
        'vmean', 'vamp', 'fv', 'vstd', 'sigmavmean', ...
        'CD', 'CDamp', 'fCD', 'CDstd', 'sigmaCDmean', ...
        'CL', 'CLamp', 'fCL', 'CLstd', 'sigmaCLmean'};
for i3=1:length(freq)
    Tper = -1;
    f = freq(i3);
    if f < 0.3
        Stime = 120;
    elseif f <= 0.4
        Stime = 100;
    else 
        Stime = 80;
    end
    infname = strcat('motion', num2str(f), '.dat')
    outfname = strcat('A', num2str(AoA),'M',num2str(Mass),'f', num2str(f), '.png');
    if(exist(infname, 'file')~=2)
        disp(strcat('file ', infname, ' does not exist'));
        continue
    end
    if(exist(outfname, 'file')==2)
        disp(strcat('file ', outfname, ' already exists'));
        continue
    end
    file = loadequispacedtimeseries(infname, nskip, nvars);
    [periodicity5, totalenergy5, dominantfrequency5, meanv5, sigmamean5, maxv5, minv5, dominantamp5, std5, file, Tper] = showp(infname, 5, Stime, file, Tper, mode);
    saveas(gcf, outfname);
    close all;
end