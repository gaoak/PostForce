function [dominantfrequency, meanv, maxv, minv, dominantamp] = showp(filename, col, Stime, file)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
setPlotParameters;
varname = {'t', 'fxp', 'fxv', 'fx', 'fyp', 'fyv', 'fy'};
if nargin < 4
    nskip = 5;
    nvars = 7;
    file = loaddata(filename, nskip, nvars);
end

[meanv, maxv, minv, is, ie] = peak_mean(Stime, file, col, varname{col});
Tp = file.data(ie, 1) - file.data(is, 1);
y = Tp/(ie-is)*fft(file.data(is:(ie-1),col)-meanv);
figure;
index = (1:min(ceil(length(y)/3),100))';
plot((index-1)/Tp, abs(y(index)),'.-');
hold on;
xlabel('frequency');
ylabel('amplitude');
title(varname{col});
[dominantamp, id] = max(abs(y(index)));
format long;
meanv
maxv
minv
dominantamp
dominantfrequency = (index(id)-1)/Tp
end

