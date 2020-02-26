function [dominantfrequency, meanv, maxv, minv, dominantamp, file] = periodicity(filename, col, Stime, file, Tper,mod)
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
if nargin < 5
    [meanv, maxv, minv, is, ie] = peak_mean(Stime, file, col, mode);
else
   [meanv, maxv, minv, is, ie] = period_mean(Stime, Tper, file, col, mode);
end
Tp = file.data(ie, 1) - file.data(is, 1);
y = 1/(ie-is)*fft(file.data(is:(ie-1),col)-meanv);
figure;
index = (1:min(ceil(length(y)/2),100))';
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

