nstart = 48;
dataI = [0.314573 0.169848 0 -4.12304 0.314573 0.169848 0 0.0626365 0.0915931 1.52233 0.37022 0.152049 -37.8889 -4.12304];
%%
clc;
close all;
nskip = 8;
nperiod = 128;
distmax = 0.3;
radiusmultiplier = 1;
xmin = -0.2;
xmax = 3;
ymin = -1;
ymax = 1.4;
IDx = 1;
IDy = 2;
IDr1 = 8;
IDr2 = 9;
IDG=10;
IDWz=13;
NColumn = 14;
%%
DataVor = [nstart dataI];
for ii=1:1:1000
    nabs = nstart + ii*nskip;
    nfile = mod(nabs, nperiod);
    filename = strcat('vortex_', num2str(nfile), '.dat')
    file = loaddata(filename, 1, NColumn);
    nvortex = length(file.data(:,1));
    index = [];
    for jj=1:1:nvortex
        if file.data(jj, IDWz) * dataI(IDWz) > 0 && file.data(jj, IDG) / dataI(IDG) > 0.3
            index = [index; jj]
        end
    end
    [dist, I] = min((file.data(index, IDx)-dataI(IDx)).^2 + (file.data(index, IDy)-dataI(IDy)).^2);
    dataI = file.data(index(I), :);
    radius = radiusmultiplier * sqrt(0.5*(dataI(IDr1)^2 + dataI(IDr2)^2))
    if dist > distmax
        break;
    end
    if dataI(IDx)<=xmin+radius || dataI(IDx)>=xmax-radius
        break;
    end
    if dataI(IDy)<=ymin+radius || dataI(IDy)>=ymax-radius
        break;
    end
    DataVor = [DataVor; nabs dataI];
end
DataVor(:,1) = DataVor(:,1)/nperiod;
%%
%    variables = t/T, x, y, z, signal, vx, vy,  vz,  r1,  r2,  Gamma,  u,  v, W_z, p
figure;
plot(DataVor(:, IDx+1), DataVor(:, IDy+1), 'b-');
hold on;
plot(DataVor(:, IDx+1), DataVor(:, IDG+1), 'r-');
%%
figure;
plot(DataVor(:,1), DataVor(:,IDx+1), 'b--')
hold on;
plot(Tevdata(:,1), Tevdata(:,IDx+1), 'ks')
title('TEV')
%%
figure;
plot(DataVor(:,1), DataVor(:,IDx+1), 'b--')
hold on;
plot(Levdata(:,1), Levdata(:,IDx+1), 'ks')
title('LEV')