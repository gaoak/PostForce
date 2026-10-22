function [time, aveforce, file] = phaseaverage(filename, col, Stime, Tper, file,mod)
% do phase average of data(:, col)
% [aveforce, file] = phaseaverage(filename, col, Stime, file, Tper,mod)
setPlotParameters;
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

Ns = round((Stime-file.data(1,1))/file.dt)+1;
if Ns<1
    Ns = 1;
end
len = length(file.data(:,1));
%
nperiod = floor( (file.data(len,1) - file.data(Ns,1))/Tper );
nperT = round( Tper/file.dt );
is = Ns;
ie = is + nperiod*nperT;
ind = is + [0:1:nperiod]'*nperT;
aveforce = zeros(nperT, 1);
for ii=1:1:nperiod
    aveforce = aveforce + file.data(ind(ii):(ind(ii+1)-1),col);
end
aveforce = aveforce / nperiod;
time = file.data(ind(1):(ind(1+1)-1),1);
[time, aveforce, t0] = shiftdata(time, aveforce, Tper);
%shift phase to start from 0
if nargin>=5 && mode==1
    figure;
    plot(time+t0,aveforce,'r-');
    hold on;
    plot(file.data(ind(1):ind(nperiod+1)-1, 1), file.data(ind(1):ind(nperiod+1)-1, col),'k--')
    hold off;
    title(strcat(file.name, num2str(col)));
end
end

function [times, forces, t0] = shiftdata(time, force, Tper)
[~, Ind] = min(abs(time/Tper - round(time/Tper)));
if Ind==1
    t0 = time(1);
    times = time - t0;
    forces = force;
else
    len = length(time);
    t0 = time(Ind);
    times = [time(Ind:len); time(1:Ind-1)+Tper] - t0;
    index = [Ind:len 1:Ind-1]';
    forces = force(index);
end
end