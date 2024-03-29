%% targeting dimensionless parameters
clc
amp=0.25; % amplitude (half peak-to-peak value)
dt = 1/10000.; % dimensionless time step by period
doutFlow = 1/8; %flow field output time interval per period
doutInfo = 1/512;%flow infomation output time interval per period
Shear = 0.5; %dimensionless shear rate
%% values with dimension
dtreal = 1/100. %mesh size
Lreal = 1.; %plate length
%% parameters with dimension (used in the input file)
%% for reference velocity 11, U_ref is the maximum plunging velocity
f = dt / dtreal %* Lreal / (2*pi*amp)
Uref = 2*pi*f*amp;
Amp = 2*amp;
ShearReal = Shear*Uref/Amp
outflow = doutFlow * (2*pi*amp) / Lreal % outflow / Tref
outInfo = doutInfo * (2*pi*amp) / Lreal % outflow / Tref