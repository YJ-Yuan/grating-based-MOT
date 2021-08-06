% Plot for the Moiré pattern formed by two overlapping Gaussian Beams
% Simulation for the Lloyd interferometer
% All units are SI Units and the beam is at its waist for z=0. 
% Beam angle is always on x-z plane for simplicity

global MFD;
global lambda;
global E0;

%%%%%%%%%%%%%%%%%%%%%%%%%  setups  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 600000; % meshgrid density
linRange = 0.0005; %simulation domain
MFD = 3e-6;
lambda = 405e-9;
E0 = 1; % calibrated by the data from experiments to 

source1 = [-0.229 0 1.3]; % y is suggested to be zero
source2 = [0.229 0 1.3]; % because the interferometer mirror is horizontal
angle1 = atan(0.229/1.3); % only the angle on x-z plane
angle2 = -atan(0.229/1.3);

%%%%%%%%%%%%%%%%%%%%%%%%%%  Implementatiobs%%%%%%%%%%%%%%%%%%%%%%%%%
intensity = zeros(1,N);
x = linspace(-linRange, linRange, N);

for i = 1:1:N
   plane = [x(i) 0 0];
   E1 = gaussian_beam(source1,plane,angle1);
   E2 = gaussian_beam(source2,plane,angle2);
   intensity(i) = abs(E1+E2)^2;
end

% plot the result
plot(x,intensity)

function E=gaussian_beam(source, plane, angle)
    global lambda;
    global MFD;
    global E0;
    k = 2*pi/lambda;
    w0 = MFD/2;
    zR = pi*w0^2/lambda;   % Rayleigh length
    
    center = [source(1)+source(3)*tan(angle) 0 0];
    r = norm(cross((center-source),(source-plane)))/norm(center-source);
	z = abs(dot((source-center),(source-plane)))/norm(source-center);
    
    w = w0*sqrt(1+(z/zR)^2);
    R = z+zR^2/z;
    gouy_phase = atan(z/zR);
    phase_factor = (k*z + k*r^2/(2*R) - gouy_phase);
    
    E=E0*(w0/w)*exp(-r^2/w^2)*exp(-1j*phase_factor);
end
