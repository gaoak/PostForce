function [file] = loaddata(filename)
    global DIRNAME
    file.name = filename;
    
    fp = fopen(strcat(DIRNAME, filename),'r');
    head=fgetl(fp);head=fgetl(fp);head=fgetl(fp);head=fgetl(fp);fscanf(fp, '%s', 1);
    sline = fgetl(fp);
    for jj=1:7
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