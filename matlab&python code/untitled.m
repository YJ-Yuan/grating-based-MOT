% Plot for the Moiré pattern formed by two overlapping Gaussian Beams
% Simulation for the Lloyd interferometer
% All units are SI Units and the beam is at its waist for z=0. 
% Beam angle is always on x-z plane for simplicity

global MFD;
global lambda;
global E0;

%%%%%%%%%%%%%%%%%%%%%%%%%  setups  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 60000; % meshgrid density
linRange = 0.05; %simulation domain
MFD = 3e-6;
lambda = 405e-9;
E0 = 1; % calibrated by the data from experiments to
theta = 10/180*pi;
d = lambda/2/sin(theta);

E1 = 

%%%%%%%%%%%%%%%%%%%%%%%%%%  Implementatiobs%%%%%%%%%%%%%%%%%%%%%%%%%
intensity = zeros(1,N);
x = linspace(-linRange, linRange, N);


% plot the result
plot(x,intensity)

