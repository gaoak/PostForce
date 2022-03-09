nstart=97;
nend = 117;
data = [];
for ii=nstart:1:nend
    tmpdata = load(strcat(num2str(ii), '.dat'));
    if length(data)==0
        data = tmpdata;
    else
        data = data + tmpdata;
    end
end
data = data / (nend - nstart + 1);
max(data(:,3)) / sum(data(:,3))