N = 1500; % meshgrid density

intensity = zeros(N);
linRange = 0.00002;

x = linspace(-linRange, linRange, N);
y = linspace(-linRange, linRange, N);

source1 = [-0.22 0 1.3];
source2 = [0.22 0 1.3];

for i = 1:1:N
   for j = 1:1:N
       plane = [x(j) y(i) 0];
       E1 = gaussian_beam(source1,plane,10*(pi/180));
       E2 = gaussian_beam(source2,plane,-10*(pi/180));
       E = E1+E2;
       intensity(i,j) = abs(E)^2;
   end
end
% intensity = movmean(intensity,10,10);
imagesc(x,y,intensity)
set(gca,'color',[0 0 0])
colormap(hot)
colorbar



function E=gaussian_beam(source, plane, angle)
    lambda = 405e-9;                      
    k = 2*pi/lambda;
    MFD = 2e-6;
    w0 = MFD/2;
    zR = pi*w0^2/lambda;   % Rayleigh length
    E0 = 1;   % calibrated by the data from experiments
    
    center = [source(1)+source(3)*tan(angle) 0 0];
    r = norm(cross((center-source),(source-plane)))/norm(center-source);
	z = abs(dot((source-center),(source-plane)))/norm(source-center);
    
    w = w0*sqrt(1+(z/zR)^2);
    R = z+zR^2/z;
    gouy_phase = atan(z/zR);
    phase_factor = (k*z + k*r^2/(2*R) - gouy_phase);
    
    E=E0*(w0/w)*exp(-r^2/w^2)*exp(-1j*phase_factor);
end
