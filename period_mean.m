function [meanv, maxv, minv, is, ie] = period_mean(Stime, period, file, column, mode)
% mean over integer number of periodics 
%  [meanv, maxv, minv, is, ie] = peak_mean(Stime, file, column, tilstr)
Ns = round(Stime/file.dt)+1;
len = length(file.data(:,1));
nperiod = floor( (file.data(len,1) - file.data(Ns,1))/period );
is = Ns;
ie = round( (file.data(Ns,1) + nperiod*period)/file.dt )+1;
meanv = mean(file.data(is:(ie-1),column));
maxv  = max(file.data(is:(ie-1),column));
minv  = min(file.data(is:(ie-1),column));
if nargin>=5 && mode==1
    figure;
    plot(file.data(Ns:len,1),file.data(Ns:len,column)); hold on;
    plot([file.data(is,1) file.data(is,1)], [minv maxv])
    plot([file.data((ie-1),1) file.data((ie-1),1)], [minv maxv])
    hold off;
    title(file.name);
end
end