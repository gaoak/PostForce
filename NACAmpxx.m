mt = 0.12;
xleading = 0.03;
xdelta = 0.005;
x = [[0:0.05:1].^2*xleading (xleading+xdelta):xdelta:1]';
len = length(x);
xs = zeros(len, 5);
xs(:, 1) = x;
for i=1:1:5
    xs(:, i+1) = xs(:, i).*x;
end
y = 5.*mt*(0.2969*sqrt(x) -0.1260*xs(:,1) - 0.3516*xs(:,2) + 0.2843*xs(:,3) - 0.1015*xs(:,4));
sy= 5.*mt*(0.2969*2/3*sqrt(x).*x -0.1260/2*xs(:,2) - 0.3516/3*xs(:,3) + 0.2843/4*xs(:,4) - 0.1015/5*xs(:,5));
rad0 = (5.*mt*0.2969)^2 / 2;
y0 = sqrt(abs(2 * rad0 * x - x.*x));
y1 = sqrt(abs(2 * rad0 * x ));
rad1 = rad0 * 1.5;
y2 = sqrt(abs(2 * rad1 * x - x.*x));
index = [len:-1:1 2:1:len];
points = [x(index) [y(len:-1:1);-y(2:1:len)] index'*0];
%% aoa
AoA = 15 / 180. * pi;
rawp = points;
points(:,1) = cos(AoA)*rawp(:,1) + sin(AoA)*rawp(:,2);
points(:,2) =-sin(AoA)*rawp(:,1) + cos(AoA)*rawp(:,2);
points(:,3) = 0.195195;
%%
figure;
plot(points(:,1), points(:,2), '.-')
hold on
plot(x, y0, '-r')
plot(x, y1, '-k')
plot(x, y2, '-g')
axis([0 1 -0.5 0.5])
pbaspect([1 1 1])
save('naca0012.dat', 'points', '-ascii', '-double')
%%
fp = fopen('naca0012.txt', 'w');
for ii=1:length(points(:,1))
    fprintf(fp, '%f,%f,%f\n', points(ii, 1),points(ii, 2),points(ii, 3));
end
fclose(fp);