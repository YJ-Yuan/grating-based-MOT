clc;
clearvars;

lambda = 405e-9; % wavelength [unit in m]
w1 = 1.1e-3; % Beam radius at position 1 [unit in m]
w2 = 1.68e-3; % Beam radius at position 2 [unit in m]
d = 8e-3; % distance between position 1 and 2 [unit in m]

a = w1^2*pi/lambda;
b = w2^2*pi/lambda;

syms u v positive
eqns = [u^2-a*u+v^2 == 0, u^2-b*u+(v+d)^2 == 0];
S = solve(eqns,[u v]);
z0 = double(S.u); % Rayleigh length of the beam
z = double(S.v); % distance of between the waist and the position 1
w0 = sqrt(lambda.*z0./pi); % waist radius in m

disp(['Waist radius = ',num2str(w0), ' m'])
disp(['Distance from waist to position 1 = ',num2str(z), ' m'])
disp(['Rayleigh length = ',num2str(z0), ' m'])