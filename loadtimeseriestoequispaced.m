function [file] = loadtimeseriestoequispaced(filename, nskip, nvars)
% time series
    file = loaddata(filename, nskip, nvars);
    numStep = length(file.data);
    t = file.data(:,1);
    stime = t(1);
    etime = t(numStep);
    file.dt = (etime-stime)/(numStep-1);
    file.data(:,1) = stime + [0:1:numStep-1]'*file.dt;
    for ii=2:1:nvars
        fx = file.data(:,ii);
        file.data(:,ii) = interp1(t, fx, file.data(:,1));
    end
end