function [file] = loaddata(filename, nskip, nvars, cond)
%cond is a function
    file.name = filename;
    
    fp = fopen(filename, 'r');
    for ii=1:1:nskip
        sline=fgetl(fp);
    end
    varName={}
    if nskip>0
        for jj=1:nvars
            varName{jj} = sscanf(sline, '%s', 1);
        end
    end
    
    rflag = nvars;fdata = [];
    sline = fgetl(fp);
    while length(sline)>(nvars*2-1);
        [ftemp, rflag] = mysscanf(sline, '%g', nvars);
        if nargin<4 || cond(fdata, ftemp);
            fdata = [fdata, ftemp];
        end
        sline = fgetl(fp);
    end
    fdata = fdata';
    numStep = length(fdata(:,1));
    file.varName = varName;
    file.dt = (fdata(numStep, 1) - fdata(1, 1))/(numStep-1);
    file.data = fdata;
	fclose(fp);
end

function [data flag] = mysscanf(sline, format, nvars)
for ii=1:1:length(sline)
    if sline(ii)==','
        sline(ii) = ' ' ;
    end
end
[data flag] = sscanf(sline, format, nvars);
end