%these are defined in this file permanently
global cpd cpv cl Lv Ll Rd Rv p0 ch absu za lam md moinit Tfreeze smooth c1c2 Toinit;

%these can change depending on on script
global A1 ideal; 

p0 = 1e5;            % Reference pressure [Pa]

Lv = 2.501e6;          % Latent heat of vaporization [J/kg]
Ll = 3.337e5;

Rv = 461.50;            % Gas constant for water vapor [J/(kg·K)]
Rd = 287.04;

Tfreeze = 273.16;    % Reference freezing temperature [K]

md = 1000;          % Mass of dry air [kg]
moinit = 5000;
Toinit = 295;

cpd = 1005.7; %[J/K/kg]
cpv = 1870.0;
cl = 4190.0;

ch = 0.0011;
absu = 50;
za = 50;
lam = 1/100;

c1c2 = 0.622 * 610.78;

smooth = 0;  % Use smoothed tanh max