function [file] = readfile_addedmass(forcefilename, Amp, k)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
nskip = 5;
nvars = 7;
file = loadequispacedtimeseries(forcefilename, nskip, nvars);
t = file.data(:, 1);
fx = file.data(:,4);
fy = file.data(:,7);
amp = 0.5 * Amp;
omega = 2 * k;
ay = -omega*omega*amp*cos(omega*t);
addedmass = [0.192912    0.730332];
Faddedy = -addedmass(2) * ay;
Faddedx = -addedmass(1) * ay;
file.data(:,4) = fx - Faddedx;
file.data(:,7) = fy - Faddedy;
end

