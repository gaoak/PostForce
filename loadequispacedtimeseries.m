function [file] = loadequispacedtimeseries(filename, nskip, nvars)
% time should be uniform
    file = loaddata(filename, nskip, nvars);
    numStep = length(file.data);
    %% check time uniform
    len4 = floor(numStep/10);
    ctime = file.data(len4*[1:1:10], 1) - file.data(1+len4*[0:1:9],1);
    maxv = max(ctime);
    minv = min(ctime);
    (maxv-minv)/minv
    if(maxv-minv>minv*0.001)
        strcat('warning: time step changes in file', filename)
    end
    %%
    disp 'rescale time assuming uniform'
    stime = file.data(1,1);
    file.data(:,1) = stime + [0:1:(numStep-1)]'*file.dt;
end