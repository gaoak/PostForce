%%
setPlotParameters;
clear;
clc;
close all;
%% parameters
nskip = 1;
nvars = 7;
infname = 'bodyMotion.mrf';
file = loadequispacedtimeseries(infname, nskip, nvars);
fileforce = loadequispacedtimeseries('DragLiftn.frc.fce', 6, nvars);
%%
nsteps=256;
len=length(file.data)-1;
deti = round(len/nsteps);
index=[0:1:nsteps]'*deti+1;
chkdata = file.data(index,[1 5 6 7]);
[maxy indmaxy] = max(chkdata(:,2))
[miny indminy] = min(chkdata(:,2))
[maxv indmaxv] = max(chkdata(:,3))
[minv indminv] = min(chkdata(:,3))
figure
plot(file.data(:,1),file.data(:,5),'b-')
hold on
plot(file.data(:,1),file.data(:,6),'g-')
plot(fileforce.data(10:len,1),fileforce.data(10:len,7),'c-')
plot(chkdata(:,1), chkdata(:,2),'.k')
specindex=[indminy, indmaxy, indminv, indmaxv]
plot(chkdata(specindex,1),chkdata(specindex,2),'sr')
hold off
saveas(gcf, 'motion.png');
%%
fp = fopen('specindex', 'w');
for ii=1:length(specindex)
    fprintf(fp, '%d \n', specindex(ii)-1);
end
fclose(fp);