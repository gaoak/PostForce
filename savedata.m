function savedata(filename, vars, data, zones)
%output data
    fp = fopen(filename, 'w');
    fprintf(fp, 'variables = ');
    for jj=1:length(vars)
        fprintf(fp, '%s ', vars{jj});
    end
    fprintf(fp, '\n');
    if nargin >= 4 && length(zones)>=2
        fprintf(fp, 'zone i = %d, j = %d\n', zones(1), zones(2));
    end
    for ii=1:length(data(:,1))
        for jj=1:length(data(1,:))
            fprintf(fp, '%20.16e ', data(ii, jj));
        end
        fprintf(fp, '\n');
    end
	fclose(fp);
end