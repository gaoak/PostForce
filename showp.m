function [periodicity, totalenergy, dominantfrequency, meanv, sigmamean, maxv, minv, dominantamp, datastd, file, Tper] = showp(filename, col, Stime, file, Tper,mod)
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
[meanv, sigmamean, maxv, minv, datastd, is, ie Tper]= process_mean(Stime, Tper, file, col, mode);
%process frequency
Tp = file.data(ie, 1) - file.data(is, 1);
y = 1/(ie-is)*fft(file.data(is:(ie-1),col)-meanv);
psd = abs(y).^2;
index = (1:min(ceil(length(psd)/3), 500))';
[dominantamp, id] = max(psd(index));
if mode==1
  figure;
  plot((index-1)/Tp, psd(index),'.-');
  xlabel('frequency');
  ylabel('amplitude');
  title(varname{col});
end
if mode==2
    result = [(index-1)/Tp psd(index)/dominantamp];
    save(strcat('psd_',filename), 'result', '-ascii', '-double');
end
%% periodicity
wavenumber = id - 1;
totalwavenumbers = floor((length(psd) - 1) / 2);
np = floor(totalwavenumbers / wavenumber);
perind = (1:1:np)*wavenumber + 1;
total = sum(psd(1:1:totalwavenumbers));
periodic = sum(psd(perind));
periodicity = (total - periodic) / total;
totalenergy = total;
dominantfrequency = (index(id)-1)/Tp;
%% output
format long;
if mode>0
    meanv
    maxv
    minv
    dominantamp
    id
    [1/dominantfrequency Tper]
end
end

