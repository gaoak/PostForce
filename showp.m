function [periodicity, totalenergy, dominantfrequency, meanv, sigmamean, maxv, minv, dominantamp, file] = showp(filename, col, Stime, file, Tper,mod)
% show fft
%   [dominantfrequency, meanv, maxv, minv, dominantamp] = showp(filename, col, Stime, file)
setPlotParameters;
varname = {'t', 'fxp', 'fxv', 'fx', 'fyp', 'fyv', 'fy', '', '', '', ''};
if nargin < 4
    nskip = 5;
    nvars = 7;
    file = loaddata(filename, nskip, nvars);
end
if nargin>=6
   mode = mod; 
else
    mode = 0;
end
[meanv, sigmamean, maxv, minv, datastd, is, ie]= process_mean(Stime, Tper, file, col, mode);
Tp = file.data(ie, 1) - file.data(is, 1);
y = 1/(ie-is)*fft(file.data(is:(ie-1),col)-meanv);
figure;
index = (1:min(ceil(length(y)/3), 500))';
plot((index-1)/Tp, abs(y(index)),'.-');
hold on;
xlabel('frequency');
ylabel('amplitude');
title(varname{col});
[dominantamp, id] = max(abs(y(index)));
%% periodicity
wavenumber = id - 1;
totalwavenumbers = floor((length(y) - 1) / 2);
np = floor(totalwavenumbers / wavenumber);
perind = (1:1:np)*wavenumber + 1;
total = sum(abs(y(1:1:totalwavenumbers)).^2);
periodic = sum(abs(y(perind)).^2);
periodicity = (total - periodic) / total;
totalenergy = total;
%% output
format long;
meanv
maxv
minv
dominantamp
id
dominantfrequency = (index(id)-1)/Tp
end

