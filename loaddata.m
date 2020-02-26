function [file] = loaddata(filename, nskip, nvars)
% time should be uniform
    file.name = filename;
    
    fp = fopen(filename, 'r');
    for ii=1:1:nskip
        sline=fgetl(fp);
    end
    for jj=1:nvars
        varName{jj} = sscanf(sline, '%s', 1);
    end
    
    rflag = nvars;fdata = [];
    sline = fgetl(fp);
    while length(sline)>(nvars*2-1)
        [ftemp, rflag] = sscanf(sline, '%g', nvars);
        fdata = [fdata, ftemp];
        sline = fgetl(fp);
    end
    fdata = fdata';
    numStep = length(fdata);
    %% check time uniform
    len4 = floor(numStep/4);
    ctime = fdata(len4*[1:1:4], 1) - fdata(1+len4*[0:1:3],1);
    maxv = max(ctime);
    minv = min(ctime);
    if(maxv-minv>minv*0.001)
        strcat('warning: time step changes in file', filename)
    end
    %%
    file.varName = varName;
    file.dt = (fdata(numStep, 1) - fdata(1, 1))/(numStep-1);
    fdata(:,1) = [0:1:(numStep-1)]'*file.dt;
    file.data = fdata;
	fclose(fp);
end