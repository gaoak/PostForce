%%
clear;
clc;
close all;
%% parameters
setPlotParameters;
%%
filemotion = loadequispacedtimeseries('bodyMotion.mrf', 1, 10);
len = length(filemotion.data(:,1));
dlen = (len - 1) / 128;
index = [1:dlen:len]';
angle = filemotion.data(index, 8);
filewss = loadequispacedtimeseries('DragLiftn.fce', 6, 4);
len = length(filewss.data(:,1));
dlen = (len - 1) / 128;
index = [1:dlen:len]';
forces = filewss.data(index, [2 3 4]');
fric = load('FRIC.dat');
visp = load('VISP.dat');
accf = load('ACCF.dat');
fric = transform(fric(:,[2 3]'), angle);
visp = transform(visp(:,[2 3]'), angle);
accf = transform(accf(:,[2 3]'), angle);
FQx = forces(:,1) - visp(:,1) - accf(:,1);
figure;
plot([0:128]/64, forces(:,3),'k-')
hold on;
plot([0:128]/64, accf(:,1), 'r-')
plot([0:128]/64, FQx(:,1), 'b-')
plot([0:128]/64, fric(:,1), 'k--')
plot([0:128]/64, visp(:,1), 'k-.')
hold off;