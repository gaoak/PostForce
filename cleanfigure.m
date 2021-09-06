function cleanfigure(pix)
files = dir('./*.png');
if nargin==0
    pix = [];
end
for i=1:1:length(files)
    f = files(i).name;
    softedge(f, pix, '');
end