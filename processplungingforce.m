%%
% clear;
%% parameters
Amp = 0.125;
sta = 1.75/pi
k=sta*pi/Amp
%% for static case only
k=-1
Amp=0
%%
Fref = 0.5;
Stime = 0;
Tper = pi/k;
mod = 1;
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
[periodicity4, dominantfrequency4, meanv4, sigmamean4, maxv, minv, dominantamp] = showp(forcefilename, 4, Stime, file, Tper, mod)
dragforce=[periodicity4, meanv4]
[periodicity7, dominantfrequency7, meanv7, sigmamean7, maxv, minv, dominantamp] = showp(forcefilename, 7, Stime, file, Tper, mod)
liftforce=[periodicity7, meanv7]
result = [meanv4/Fref, sigmamean4/Fref, meanv7/Fref, sigmamean7/Fref,...
    0.5*(periodicity4 + periodicity7), 0.5*(dominantfrequency4 + dominantfrequency7)]
%%
save('result.txt', 'result', '-ascii', '-double')