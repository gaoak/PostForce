%%
close all;
clc;
%% parameters
filename='L2_TEV.dat';
%% dependent parameters
nskip = 1;
nvars = 10;
%% load data
file = loaddata(filename, nskip, nvars);
%%
X=file.data;
Y = X;
hold on;
for ii=1:1:nvars
    Y(:,ii) = smooth(X(:,ii), 0.1, 'lowess');
end
plot(X(:,3), X(:,1))
hold on;
plot(Y(:,3), Y(:,1))
%%
fid = fopen(strcat('s_', filename), 'w');
fprintf(fid, 'variables = "x","y","z","radius1","radius2","Gamma","W_x","W_y","W_z","Q"\n');
for ii=1:1:length(Y(:,1))
    for jj=1:1:length(Y(1,:))
        fprintf(fid, '%12.8f ', Y(ii, jj));
    end
    fprintf(fid, '\n');
end
fclose(fid);