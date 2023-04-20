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
plot(force(:,1), force(:,2), '.r-')
hold on
plot(force(:,1), force(:,3), '.b-')
legend('Fx', 'Fy');
title('Added mass force')