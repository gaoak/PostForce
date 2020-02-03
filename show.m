function show(filename, is)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
setPlotParameters;
varname = {'t', 'fxp', 'fxv', 'fx', 'fyp', 'fyv', 'fy'};
nskip = 5;
nvars = 7;
file = loaddata(filename, nskip, nvars);

figure;
labels={};
for ii=is
    labels{length(labels)+1} = varname{ii};
    plot(file.data(:,1), file.data(:,ii)); hold on;
end
xlabel('t');
ylabel('force');
title(filename);
legend(labels,'Location','Best');
end

