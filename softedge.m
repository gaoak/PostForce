function softedge(filename, pix, prefix)
fig = imread(filename);
[nx, ny, nc ] = size(fig);
if nargin==1 || length(pix)<4
    pix = [0 3 0 3];
end
for i=[1:1:pix(1)]
    for j=1:1:ny
        for c=1:1:nc
            fig(i,j,c) = 255;
        end
    end
end
for i=[1:1:pix(2)] + nx - pix(2)
    for j=1:1:ny
        for c=1:1:nc
            fig(i,j,c) = 255;
        end
    end
end
for i=[1:1:nx]
    for j=[1:1:pix(3)]
        for c=1:1:nc
            fig(i,j,c) = 255;
        end
    end
end
for i=[1:1:nx]
    for j=[1:1:pix(4)] + ny - pix(4)
        for c=1:1:nc
            fig(i,j,c) = 255;
        end
    end
end
if nargin<3
    prefix = '';
end
imwrite(fig, strcat(prefix,filename), 'png')