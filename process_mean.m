function [meanv, sigmamean, maxv, minv, datastd, is, ie, Tper] = process_mean(Stime, period, file, column, mode)
% mean over integer number of periodics
%  [meanv, maxv, minv, is, ie] = peak_mean(Stime, file, column, mode)
Ns = round((Stime-file.data(1,1))/file.dt)+1;
if Ns<1
    Ns = 1;
end
len = length(file.data(:,1));
% find mean max value and mean min value [maxv] [minv]
% ind is the index of peaks, not used here
peaks = findpeaks(file.data(Ns:len,column), 1E6, mode, strcat(file.name, '_v', num2str(column)));
[is, ie, maxv, minv, nperiod, ind] = peak(peaks, Ns, 1);
% reset period and Stime is needed
% find Tper [Tper]
if period <= 0
    %get period using fft dominant frequency if period is not given
    Stime = file.data(is, 1);
    Tspan = file.data(ie, 1) - Stime;
    meanv = mean(file.data(is:(ie-1),column));
    y = 1/(ie-is)*fft(file.data(is:(ie-1),column)-meanv);
    index = (1:min(ceil(length(y)/3), 500))';
    [~, id] = max(abs(y(index)));
    period = Tspan / (index(id)-1);
end
Tper = period;
% using period do averaging [meanv], [sigmamean], [datastd], [is], [ie]
[meanv, sigmamean, tmpmaxv, tmpminv, datastd, is, ie, tmpperiod] = period_mean(Stime, period, file, column, mode);
end

function [is, ie, maxv, minv, Tcount, ind] = peak(acme, Ns, step)
len = length(acme);
is = -1;
ie = -1;
maxv = 0.;
cmax = 0.;
minv = 0.;
cmin = 0.;
Tcount = 0;
ind=[];
for ii=2:1:len-1
    if ispeak(step, acme(ii-1,2), acme(ii,2), acme(ii+1,2))==1
        is = acme(ii,1) + Ns - 1;
        break
    end
end
for ii=len-1:-1:2
    if ispeak(step, acme(ii-1,2), acme(ii,2), acme(ii+1,2))==1
        ie = acme(ii,1) + Ns - 1;
        break
    end
end
for ii=2:1:len-1
    if ispeak(1, acme(ii-1,2), acme(ii,2), acme(ii+1,2))==1
        cmax = cmax + 1.;
        maxv = maxv + acme(ii, 2);
    end
    if ispeak(-1, acme(ii-1,2), acme(ii,2), acme(ii+1,2))==1
        cmin = cmin + 1.;
        minv = minv + acme(ii, 2);
    end
    if ispeak(step, acme(ii-1,2), acme(ii,2), acme(ii+1,2))==1
        ind = [ind acme(ii, 1)+Ns-1];
    end
end
maxv = maxv / cmax;
minv = minv / cmin;
if step>0
    Tcount = cmax - 1;
elseif step<0
    Tcount = cmin - 1;
end
end

function [value] = ispeak(type, a, b, c)
if b<=a && b<=c && type<0
    value = 1;
elseif b>=a && b>=c && type>0
    value = 1;
else
    value = 0;
end
end