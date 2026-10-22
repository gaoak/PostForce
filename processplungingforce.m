%%
% clear;
%% parameters
Amp = 0.0;
k=pi;
%% for static case only
%  k=-1
%  Amp=0
%%
Fref = 0.5;
Stime = 0;
Tper = -1;
mode = 1;
%%
% clc;
close all;
setPlotParameters;
forcefilename='force.dat';
nskip = 5;
nvars = 7;
file = loadequispacedtimeseries(forcefilename, nskip, nvars);
%%
t = file.data(:, 1);
fx = file.data(:,4);
fy = file.data(:,7);
amp = 0.5 * Amp;
omega = 2 * k;
ay = -omega*omega*amp*cos(omega*t);
addedmass = [0.192912    0.730332];
Faddedy = -addedmass(2) * ay;
Faddedx = -addedmass(1) * ay;
figure
plot(t/Tper, fx/Fref, 'b-')
hold on
plot(t/Tper, Faddedx/Fref, 'r-')
xlabel('t/T')
ylabel('C_D')
legend('total', 'added mass', 'Location', 'Best')
figure
plot(t/Tper, fy/Fref, 'b-')
hold on
plot(t/Tper, Faddedy/Fref, 'r-')
xlabel('t/T')
ylabel('C_L')
legend('total', 'added mass', 'Location', 'Best')
file.data(:,4) = fx - Faddedx;
file.data(:,7) = fy - Faddedy;
%%
figure
plot(t/Tper, file.data(:,4)/Fref, 'b-')
xlabel('t/T')
ylabel('C_D - added mass force')
figure
plot(t/Tper, file.data(:,7)/Fref, 'b-')
xlabel('t/T')
ylabel('C_L - added mass force')
%%
figure;
plot(Faddedx/Fref, Faddedy/Fref, 'r')
hold on
plot(fx/Fref, fy/Fref, 'b')
figure;
plot(file.data(:,4)/Fref, file.data(:,7)/Fref, 'b-')
xlabel('C_D')
ylabel('C_L')
saveas(gcf, 'CL_CD.png')
%%
[periodicity4, totalenergy4, dominantfrequency4, meanv4, sigmamean4, maxv4, minv4, dominantamp] = showp(forcefilename, 4, Stime, file, Tper, mode)
dragforce=[periodicity4, meanv4]
[periodicity7, totalenergy7, dominantfrequency7, meanv7, sigmamean7, maxv7, minv7, dominantamp] = showp(forcefilename, 7, Stime, file, Tper, mode)
liftforce=[periodicity7, meanv7]
periodicity = (periodicity4 * totalenergy4 + periodicity7 * totalenergy7) / (totalenergy4 + totalenergy7);
result = [k Amp meanv4/Fref, sigmamean4/Fref, maxv4/Fref, minv4/Fref,...
                meanv7/Fref, sigmamean7/Fref, maxv7/Fref, minv7/Fref,...
    periodicity, 0.5*(dominantfrequency4 + dominantfrequency7)]
%%
save('result.txt', 'result', '-ascii', '-double')
