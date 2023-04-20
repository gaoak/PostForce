setPlotParameters;
close all;
%% input parameters for NACA0015 pitching
Uinfty = 1.;
Vinfty = 0.;
freq = 1.;
thickness = 0.15;
AD = 2;
Amplitude = AD * thickness;
%% added-mass matrix
mass = zeros(3);
mass(1, 1) = 1.6223089e-02;
mass(1, 2) = 0;
mass(1, 3) = 0;
mass(2, 1) = 0;
mass(2, 2) = 7.8017544e-01;
mass(2, 3) = 0;
mass(3, 1) = 0;
mass(3, 2) = 3.8843205e-01;
mass(3, 3) = 2.1707965e-01;
%% auxi vars
t=[0:0.01:10]';
len = length(t);
omega = 2*pi*freq;
angle   = asin(Amplitude*0.5)*( sin(omega*t)-     omega*t.*exp(-t*omega));
dangle  = asin(Amplitude*0.5)*( cos(omega*t)+ (omega*t-1).*exp(-t*omega) )*omega;
ddangle = asin(Amplitude*0.5)*(-sin(omega*t)+(-omega*t+2).*exp(-t*omega) )*omega*omega;
%%
Fax = zeros(len, 1);
Fay = zeros(len, 2);
for ii=1:1:len
    Ua = [-Uinfty, -Vinfty]';
    dUa = [0, 0]';
    theta   =   angle(ii);
    dtheta  =  dangle(ii);
    ddtheta = ddangle(ii);
    Fa = ComputeAddedMass2D(Ua,dUa,theta,dtheta,ddtheta,mass);
    Fax(ii) = Fa(1);
    Fay(ii) = Fa(2);
end
force = [t Fax Fay];
%%
figure;
plot(force(:,1), force(:,2), 'r-')
hold on
plot(force(:,1), force(:,3), 'b-')
legend('Fx', 'Fy');
title('Added mass force')
%% test cases for the added mass force, 2D ellipse
clear all;
mss = zeros(3);
a = 2;
b = 1;
t = 1;
mss(1,1)=pi*b*b;mss(2,2)=pi*a*a;mss(3,3)=pi*(a^2-b^2)^2/8.;
%case 1
display('test case===================');
Ua = [1 0]';dUa=[0 0]';
theta=0.;dtheta=0;ddtheta=0;
Fa = ComputeAddedMass2D(Ua,dUa,theta,dtheta,ddtheta,mss)'
display('expect: 0, 0')
%case 2
display('test case===================');
Ua = [0 0]'; dUa=[0 0]';
theta=0; dtheta=t; ddtheta = 1;
Fa = ComputeAddedMass2D(Ua,dUa,theta,dtheta,ddtheta,mss)'
display('expect: 0, 0')
%case 3
display('test case===================');
Ua = [4*t*t 0]'; dUa=[8*t 0]';
theta=0; dtheta=0; ddtheta = 0;
Fa = ComputeAddedMass2D(Ua,dUa,theta,dtheta,ddtheta,mss)'
display(strcat('expect: ', num2str(-8*pi*t*b*b), ', 0'))
%case 4
display('test case===================');
Ua = [0 4*t]'; dUa=[0 4]';
theta=0; dtheta=0; ddtheta = 0;
Fa = ComputeAddedMass2D(Ua,dUa,theta,dtheta,ddtheta,mss)'
display(strcat('expect: 0, ', num2str(-4*pi*a*a)))
%case 5
display('test case===================');
Ua = [3*t 2*t]'; dUa=[3 2]';
theta=0; dtheta=0; ddtheta = 0;
Fa = ComputeAddedMass2D(Ua,dUa,theta,dtheta,ddtheta,mss)'
display(strcat('expect: ', num2str(-3*pi*b*b), ', ', num2str(-2*pi*a*a)))
%case 6
display('test case===================');
Ua = [3*t 2*t]'; dUa=[3 2]';
theta=0; dtheta=t; ddtheta = 1;
Fa = ComputeAddedMass2D(Ua,dUa,theta,dtheta,ddtheta,mss)'
display(strcat('expect: ', num2str(-3*pi*b*b+2*t*t*pi*a*a), ', ', num2str(-2*pi*a*a-3*t*t*pi*b*b)))
%case 7
display('test case===================');
Ua = [-4*t 0]'; dUa=[-4 0]';
theta=pi/2; dtheta=0; ddtheta = 0;
Fa = ComputeAddedMass2D(Ua,dUa,theta,dtheta,ddtheta,mss)'
display(strcat('expect: ', num2str(4*pi*a*a), ', 0'))