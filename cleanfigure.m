function cleanfigure(pix, format)
files = dir('./*.png');
if nargin==0
    pix = [];
end
if nargin==2
    files = dir(strcat('./*.',format));
end
for i=1:1:length(files)
    f = files(i).name;
    softedge(f, pix, '', format);
end