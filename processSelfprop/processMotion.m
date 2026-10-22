%%
clear;
clc;
close all;
%%
Amp=10;
Mass=1.;
%% parameters
setPlotParameters;
Tper = 1.;
mode = 0;
nskip = 1;
nvars = 10;
%%
parms = [1:1:15];
vars = {'Amp',  'Mass', ...
        'umean', 'uamp', 'fu', 'ustd', 'sigmaumean', ...
        'ymean', 'yamp', 'fy', 'ystd', 'sigmaymean', ...
        'vmean', 'vamp', 'fv', 'vstd', 'sigmavmean'};
result = [];
outfname = strcat('resAmp.dat');
for i3=1:length(parms)
    f = parms(i3);
    infname = strcat('../A', num2str(f), '/bodyMotion.mrf')
    if(exist(infname, 'file')~=2)
        disp(strcat('file ', infname, ' does not exist'));
        continue
    end
    if(exist(outfname, 'file')==2)
        disp(strcat('file ', outfname, ' already exists'));
        continue
    end
    file = loadequispacedtimeseries(infname, nskip, nvars);
    t = file.data(:,1);
    Stime = t(length(t)) - 16;
    figure;
    plot(t, file.data(:,3))
    hold on;
    plot([Stime Stime], [min(file.data(:,3)) max(file.data(:,3))], 'r-');
    hold off;
    saveas(gcf, strcat('A', num2str(f), '.png'));
    [periodicity3, totalenergy3, dominantfrequency3, meanv3, sigmamean3, maxv3, minv3, dominantamp3, std3, file, Tper] = showp(infname, 3, Stime, file, Tper, mode);
    [periodicity5, totalenergy5, dominantfrequency5, meanv5, sigmamean5, maxv5, minv5, dominantamp5, std5] = showp(infname, 5, Stime, file, Tper, 0);
    [periodicity6, totalenergy6, dominantfrequency6, meanv6, sigmamean6, maxv6, minv6, dominantamp6, std6] = showp(infname, 6, Stime, file, Tper, 0);
    result = [result; f  Mass  ...
              meanv3   maxv3 - minv3 dominantfrequency3 std3 sigmamean3 ...
              meanv5   maxv5 - minv5 dominantfrequency5 std5 sigmamean5 ...
              meanv6   maxv6 - minv6 dominantfrequency6 std6 sigmamean6];
%     close all;
end
savedata(outfname, vars, result)
%%
% result([16 21 7 5])
% mean y, Amp y, f y; mean CL, Amp CL, f CL
% result([6, 7, 8;21, 22, 23])