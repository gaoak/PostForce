function [meanv, error] = stat_mean(Stimes, file, column)
% mean over integer number of periodics 
%  [meanv, maxv, minv, is, ie] = peak_mean(Stime, file, column, tilstr)
nsample = length(Stimes);
Ns = round(Stimes/file.dt)+1;
len = length(file.data(:,1));
Ne = len - (Ns(nsample) - Ns);
maxi =-1.E30;
mini =  1.E30;
sum = 0.;
for ii=1:1:nsample
    meanv = mean(file.data(Ns(ii):Ne(ii),column));
    if(meanv>maxi) 
        maxi = meanv;
    end
    if(meanv<mini)
        mini = meanv;
    end
    sum = sum + meanv;
end
meanv = 0.5*(maxi + mini);
error = maxi - mini;
end