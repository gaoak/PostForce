%%
% clear;
%% parameters
k=2.9;
Amp = 0.5;
forcefilename='force.dat';
%% dependent parameters
Fref = 0.5;
Stime = 0;
Tper = pi/k;
mode = 1;
StA = k*Amp/pi
%% load data
% clc;
close all;
setPlotParameters;
nskip = 5;
nvars = 7;
file = loadequispacedtimeseries(forcefilename, nskip, nvars);
t = file.data(:, 1);
fx = file.data(:,4);
fy = file.data(:,7);
phaseIndex = getfileDividers(file, Tper, 4);
%% calculate added mass force
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
% legend('total', 'added mass', 'Location', 'Best')
figure
plot(t/Tper, fy/Fref, 'b-')
hold on
plot(t/Tper, Faddedy/Fref, 'r-')
xlabel('t/T')
ylabel('C_L')
% legend('total', 'added mass', 'Location', 'Best')
%% substract added mass force from the total force
fxvor = fx - Faddedx;
fyvor = fy - Faddedy;
CX = fxvor / Fref;
CY = fyvor / Fref;
cxmax = max(CX);
cxmin = min(CX);
cymax = max(CY);
cymin = min(CY);
cxabsmax = max(cxmax, -cxmin);
cyabsmax = max(cymax, -cymin);
%% plot vortex force
figure
plot(t/Tper, file.data(:,4)/Fref, 'b-')
xlabel('t/T')
ylabel('C_D - added mass force')
figure
plot(t/Tper, file.data(:,7)/Fref, 'b-')
xlabel('t/T')
ylabel('C_L - added mass force')
%% CD-CL phase plot
figure;
plot(Faddedx/Fref, Faddedy/Fref, 'r')
hold on
plot(fx/Fref, fy/Fref, 'b')
figure;
plot(CX, CY, 'b-')
hold on;
plot(CX(phaseIndex{1}), CY(phaseIndex{1}), '+m')
plot(CX(phaseIndex{2}), CY(phaseIndex{2}), 'vg')
plot(CX(phaseIndex{3}), CY(phaseIndex{3}), 'ok')
plot(CX(phaseIndex{4}), CY(phaseIndex{4}), '^r')
xlabel('C_D')
ylabel('C_L')
axis([-cxabsmax, cxabsmax, -cyabsmax, cyabsmax])
saveas(gcf, strcat(num2str(k), 'CL_CD.png'))
%% statistic data, can only run ontime
file.data(:,4) = fxvor;
file.data(:,7) = fyvor;
[periodicity4, dominantfrequency4, meanv4, sigmamean4, maxv4, minv4, dominantamp] = showp(forcefilename, 4, Stime, file, Tper, mode)
dragforce=[periodicity4, meanv4]
[periodicity7, dominantfrequency7, meanv7, sigmamean7, maxv7, minv7, dominantamp] = showp(forcefilename, 7, Stime, file, Tper, mode)
liftforce=[periodicity7, meanv7]
result = [k Amp meanv4/Fref, sigmamean4/Fref, maxv4/Fref, minv4/Fref,...
                meanv7/Fref, sigmamean7/Fref, maxv7/Fref, minv7/Fref,...
    0.5*(periodicity4 + periodicity7), 0.5*(dominantfrequency4 + dominantfrequency7), ...
    cxmin, cxmax, cymin, cymax]
%%
save('result.txt', 'result', '-ascii', '-double')