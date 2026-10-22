%%
clear;
close all;
%% parameters
filenameformat='spectra_%d.dat';
Nf = [56:1:135];
nskip = 1;
nvars = 3;
data = [];
len = 0;
%% dependent parameters
figure;
for ii=Nf
    fname = sprintf(filenameformat, ii);
    file = loaddata(fname, nskip, nvars)
    if length(data)==0
        data = file.data;
        len = length(data(:,1));
    else
        data = data + file.data(1:len,1:nvars);
    end
    plot(file.data(:,2), file.data(:,3),'s')
    hold on
end
data = data / length(Nf);
plot(data(:,1), data(:,3),'+-r')
save('spectra_average.dat', 'data', '-ascii', '-double')
saveas(gcf, 'spanwisespectral.png')