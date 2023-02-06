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
index = [len:-1:1 2:1:len];
points = [x(index) [y(len:-1:1);-y(2:1:len)] index'*0];
figure;
plot(points(:,1), points(:,2), '.-')
save('naca0012.dat', 'points', '-ascii', '-double')