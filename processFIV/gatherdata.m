fname = 'Static.dat';
%% force and motion data
data=[];
for i3=1:length(freq)
    f = freq(i3);
    outfname = strcat('mres', num2str(f), '.txt');
    if(exist(outfname, 'file')==2)
        data1 = load(outfname);
        data = [data; data1];
    end
end
savedata(fname, vars, data);
%% psd data
data=[];
bin = [0:0.01:1.5];
count = 0;
for i3=1:length(freq)
    f = freq(i3);
    outfname = strcat('psd_motion', num2str(f), '.dat');
    if(exist(outfname, 'file')==2)
        data1 = load(outfname);
        [xc, yc] = redistributePdf(data1(:,1), data1(:,2), bin);
        nlen = length(xc);
        Uref = 1/f + zeros(nlen, 1);
        data = [data; xc Uref yc];
        count = count + 1;
    end
end
savedata(strcat('PSD_',fname), {'fy', 'Ured', 'psd'}, data, [nlen, count]);
