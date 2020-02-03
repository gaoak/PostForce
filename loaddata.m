function [file] = loaddata(filename, nskip, nvars)
    global DIRNAME
    file.name = filename;
    
    fp = fopen(strcat(DIRNAME, filename), 'r');
    for ii=1:1:nskip
        sline=fgetl(fp);
    end
    for jj=1:nvars
        varName{jj} = sscanf(sline, '%s', 1);
    end
    
    rflag = 7;fdata = [];
    sline = fgetl(fp);
    while length(sline)>7
        [ftemp, rflag] = sscanf(sline, '%g', 7);
        fdata = [fdata, ftemp];
        sline = fgetl(fp);
    end
    fdata = fdata';
    numStep = length(fdata);
    file.varName = varName;
    file.data = fdata;
    file.dt = (fdata(101, 1) - fdata(1, 1))/100;
	fclose(fp);
end