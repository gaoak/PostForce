function [file] = loaddata(filename, nskip, nvars)
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
    file.varName = varName;
    file.dt = (fdata(numStep, 1) - fdata(1, 1))/(numStep-1);
    file.data = fdata;
	fclose(fp);
end