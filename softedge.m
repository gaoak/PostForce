function softedge(filename, ratio, pix, prefix)
fig = imread(filename);
[nx, ny, nc ] = size(fig);
if nargin==1
    ratio = 0.003;
end
if nargin>2 && pix>1
    rnx = pix;
    rny = pix;
else
    rnx = round(ratio*nx);
    rny = round(ratio*ny);
end
for i=[1:1:rnx] + nx - rnx
    for j=1:1:ny
        for c=1:1:nc
            fig(i,j,c) = 255;
        end
    end
end
for i=[1:1:nx]
    for j=[1:1:rny] + ny - rny
        for c=1:1:nc
            fig(i,j,c) = 255;
        end
    end
end
if nargin<4
    prefix = '';
end
imwrite(fig, strcat(prefix,filename), 'png')