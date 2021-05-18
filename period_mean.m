function [meanv, sigmamean, maxv, minv, datastd, is, ie] = period_mean(Stime, period, file, column, mode)
% mean over integer number of periodics 
%  [meanv, maxv, minv, is, ie] = peak_mean(Stime, file, column, tilstr)
Ns = round((Stime-file.data(1,1))/file.dt)+1;
if Ns<1
    Ns = 1;
end
len = length(file.data(:,1));
nperiod = floor( (file.data(len,1) - file.data(Ns,1))/period );
is = Ns;
ie = is + round( nperiod*period/file.dt );
ind = is + round( [0:1:nperiod]'*period/file.dt );
meanv = mean(file.data(is:(ie-1),column));
maxv  = max(file.data(is:(ie-1),column));
minv  = min(file.data(is:(ie-1),column));
datastd = std(file.data(is:(ie-1),column));
tmp = zeros(nperiod, 1);
for ii=1:1:nperiod
    tmp(ii) = mean(file.data(ind(ii):(ind(ii+1)-1),column));
end
sigmamean = std(tmp);
if nargin>=5 && mode==1
    figure;
    plot(file.data(Ns:len,1),file.data(Ns:len,column)); hold on;
    plot([file.data(is,1) file.data(is,1)], [minv maxv])
    plot([file.data((ie-1),1) file.data((ie-1),1)], [minv maxv])
    hold off;
    title(strcat(file.name, num2str(column)));
end
end