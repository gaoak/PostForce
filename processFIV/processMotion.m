%%
clear;
clc;
close all;
%%
AoA=15;
Mass=1.;
%% parameters
setPlotParameters;
Tper = -1.;
mode = 2;
nskip = 1;
nvars = 7;
Fref=0.5;
%%
freq = [0.35 0.6];
vars = {'AoA',  'Mass', 'fn', 'invfn',  'invTper', ...
        'ymean', 'yamp', 'fy', 'ystd', 'sigmaymean', ...
        'vmean', 'vamp', 'fv', 'vstd', 'sigmavmean', ...
        'CD', 'CDamp', 'fCD', 'CDstd', 'sigmaCDmean', ...
        'CL', 'CLamp', 'fCL', 'CLstd', 'sigmaCLmean'};
for i3=1:length(freq)
    Tper = -1;
    f = freq(i3);
    if f < 0.3
        Stime = 100;
    elseif f <= 0.4
        Stime = 100;
    else 
        Stime = 100;
    end
    infname = strcat('motion', num2str(f), '.dat')
    outfname = strcat('mres', num2str(f), '.txt');
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
    saveas(gcf, strcat('A', num2str(AoA),'M',num2str(Mass),'f', num2str(f), '.png'));
    [periodicity6, totalenergy6, dominantfrequency6, meanv6, sigmamean6, maxv6, minv6, dominantamp6, std6] = showp(infname, 6, Stime, file, Tper, 0);
    %force
    infname = strcat('force', num2str(f), '.dat');
    file = loadequispacedtimeseries(infname, nskip, nvars);
    [periodicity7, totalenergy7, dominantfrequency7, meanv7, sigmamean7, maxv7, minv7, dominantamp7, std7] = showp(infname, 7, Stime, file, Tper, 0);
    [periodicity4, totalenergy4, dominantfrequency4, meanv4, sigmamean4, maxv4, minv4, dominantamp4, std4] = showp(infname, 4, Stime, file, Tper, 0);
    result = [AoA  Mass f 1/f  1/Tper ...
              meanv5   maxv5 - minv5 dominantfrequency5 std5 sigmamean5 ...
              meanv6   maxv6 - minv6 dominantfrequency6 std6 sigmamean6 ...
              meanv4/Fref   (maxv4 - minv4)/Fref dominantfrequency4 std4/Fref sigmamean4/Fref ...
              meanv7/Fref   (maxv7 - minv7)/Fref dominantfrequency7 std7/Fref sigmamean7/Fref];
    save(outfname, 'result', '-ascii', '-double')
%     close all;
end
%%
% result([16 21 7 5])
% mean y, Amp y, f y; mean CL, Amp CL, f CL
% result([6, 7, 8;21, 22, 23])