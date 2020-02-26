function [meanv, maxv, minv, is, ie] = peak_mean(Stime, file, column, mode)
% mean over integer number of periodics 
%  [meanv, maxv, minv, is, ie] = peak_mean(Stime, file, column, mode)
Ns = round(Stime/file.dt)+1;
len = length(file.data(:,1));
meanvtmp = mean(file.data(Ns:len,column));
step = round(0.05*(len-Ns));
is = peak(file.data(:,column), Ns, step, meanvtmp);
ie = peak(file.data(:,column),len,-step, meanvtmp);
meanv = mean(file.data(is:(ie-1),column));
maxv  = max(file.data(is:(ie-1),column));
minv  = min(file.data(is:(ie-1),column));
if nargin>=4 && mode==1
    figure;
    plot(file.data(Ns:len,1),file.data(Ns:len,column)); hold on;
    plot([file.data(is,1) file.data(is,1)], [minv maxv])
    plot([file.data((ie-1),1) file.data((ie-1),1)], [minv maxv])
    hold off;
    title(file.name);
end
end

function [index] = peak(array, is, step, meanvtmp)
if step>0
    [M, index] = max(array(is:min(is+step, length(array) ) ) );
    index = index + is - 1;
else
    [M, index] = max(array(max(1, is+step):is) );
    index = index + max(1, is+step) - 1;
end
end