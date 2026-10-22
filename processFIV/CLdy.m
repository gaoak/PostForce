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
vars = {'t',  'CD', 'CL', 'dy',  'v'};
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
    outfname = strcat('A', num2str(AoA),'M',num2str(Mass),'f', num2str(f), '.dat');
    if(exist(infname, 'file')~=2)
        disp(strcat('file ', infname, ' does not exist'));
        continue
    end
    if(exist(outfname, 'file')==2)
        disp(strcat('file ', outfname, ' already exists'));
        continue
    end
    file = loadequispacedtimeseries(infname, 1, nvars);
    [periodicity5, totalenergy5, dominantfrequency5, meanv5, sigmamean5, maxv5, minv5, dominantamp5, std5, file, Tper] = showp(infname, 5, Stime, file, Tper, mode);
    result = [AoA  Mass f 1./dominantfrequency5 Tper];
    %force
    infname = strcat('force', num2str(f), '.dat');
    file2 = loadequispacedtimeseries(infname, 6, nvars);
    len = min(length(file.data), length(file2.data));
    if(f==0)
        file.data = file.data*0;
        meanv5=0;
    end
    data = [file2.data(1:len,1),file2.data(1:len,4)/Fref,file2.data(1:len,7)/Fref,file.data(1:len,5)-meanv5,file.data(1:len,6)];
    savedata(outfname, vars, data);
    outfname = strcat('A', num2str(AoA),'M',num2str(Mass),'f', num2str(f), '.txt');
    save(outfname, 'result', '-ascii', '-double')
    close all;
end