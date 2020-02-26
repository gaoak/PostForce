function [h, u, a] = getmotion(amp, omega, phi0, t)
    h = amp*cos(omega*t + phi0);
    u = -amp*sin(omega*t + phi0)*omega;
    a = -amp*cos(omega*t + phi0)*omega*omega;
end