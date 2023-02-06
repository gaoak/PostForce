clc;
close all;
setPlotParameters;
scale = 0.5;
%% read wall shear stress data
%VARIABLES = "x" "y" "Shear_s" "Shear_n" "Shear_mag" "Norm_x" "Norm_y"
nskip = 0;
nvars = 7;
wssdat = loaddata("wss.dat", nskip, nvars, @conditions);
%interpolate to uniform grid
arc = computeArchLength(wssdat.data(:,1), wssdat.data(:,2));
len = length(arc);
Smax = arc(len);
sint = [0:0.0625:1]'*Smax;
x = interp1(arc, wssdat.data(:,1), sint);
y = interp1(arc, wssdat.data(:,2), sint);
sx = interp1(arc, wssdat.data(:,3), sint);
sy = interp1(arc, wssdat.data(:,4), sint);
nx = interp1(arc, wssdat.data(:,6), sint);
ny = interp1(arc, wssdat.data(:,7), sint);
[sx, sy] = shearstress(x, sx, sy, sqrt(sx.*sx+sy.*sy));
offset=-0.01;
x1 = x + nx*offset;
y1 = y + ny*offset;
sheardata = [x1, y1, sx*0.12, sy*0.12];
save('sheardata.dat', 'sheardata', '-ascii', '-double')
%% read wall variables data
%VARIABLES = "x" "y" "u" "v" "p"
nskip = 0;
nvars = 5;
varsdat = loaddata("vars.dat", nskip, nvars, @conditions);
sint = [0:0.01:1]'*Smax;
x = interp1(arc, wssdat.data(:,1), sint);
y = interp1(arc, wssdat.data(:,2), sint);
nx = interp1(arc, wssdat.data(:,6), sint);
ny = interp1(arc, wssdat.data(:,7), sint);
p = interp1(arc, varsdat.data(:,5), sint);
p1 = pressure(p, -1);
pressuredata = [x, y, nx.*p1*scale, ny.*p1*scale];
save('pressuredata1.dat', 'pressuredata', '-ascii', '-double');
p1 = pressure(p, 1);
pressuredata = [x-abs(p1).*nx*scale, y-abs(p1).*ny*scale, nx.*p1*scale, ny.*p1*scale];
save('pressuredata2.dat', 'pressuredata', '-ascii', '-double');
%% output pressure mesh
x = varsdat.data(:,1);
y = varsdat.data(:,2);
p = varsdat.data(:,5);
nx = wssdat.data(:,6);
ny = wssdat.data(:,7);
p = pressure(p);
pressuredata = [x, y, nx*0, ny*0];
save('mesh1.dat', 'pressuredata', '-ascii', '-double');
pressuredata = [x-abs(p).*nx*scale, y-abs(p).*ny*scale, nx*0, ny*0];
save('mesh2.dat', 'pressuredata', '-ascii', '-double');