%% load restart files and reinterpolate data
clc;
close all;
clear;
setPlotParameters;
filename = {'wingforce.dat', 'tipforce.dat'};
nskip = 0;
nvars = 10;
for ii=1:1:length(filename)
%     file{ii} = loadtimeseriestoequispaced(filename{ii}, nskip, nvars);
    file{ii} = loadequispacedtimeseries(filename{ii}, nskip, nvars);
end
%%
for nn=2:1:nvars
    file{1}.data(:,nn) = file{1}.data(:,nn) + file{2}.data(:,nn);
end
force = file{1}.data;
save('force.dat', 'force', '-ascii', '-double')
%%
figure;
plot(file{1}.data(:,1), file{1}.data(:,4))