clc;
clearvars;
%% position 1
a = 0:1:10;
a = a*5e-6
P0 = 13.51; % Max power in mW
P = [0.09 0.13 0.18 1.12 6.18 8.17 10.7 11.9 13.38 13.5 13.51];

% a = 0:0.0001:0.0025;
% P0 = 11.19; % Max power in mW
% P = [0.014 0.036 0.095 0.21 0.55 1.05 1.6 2.1 2.71 3.32 3.97 4.7 5.46 6.2 6.89 7.5 8.12 8.77 9.33 10.03 10.64 11 11.135 11.19 11.2 11.2];
% 
% % a = 0:0.0001:0.0035;
% % P0 = 10.95;
% % P = [0.008 0.008 0.08 0.12 0.2 0.365 0.63 0.96 1.32 1.69 2.01 2.37 2.77 3.15 3.55 4.03 4.47 4.97 5.43 5.9 6.38 6.79 7.18 7.6 8 8.43 8.83 9.17 9.585 10.08 10.49 10.76 10.9 10.95 10.96 10.96];

P_fit = @(x,a)(P0./2).*erfc((x(1)-a).*sqrt(2)./x(2)); % x(1) = a0; x(2) = w0
% a0 is the fitting param where the count is supposed to be half of the
% Max. count. w0 is the beam waist radius (86% power) at the measured
% position. P0 is the Max. count when the beam path is completely
% unblocked.

x0 = [a(5) 10e-6]; % [a0 w0] initial value
[x,resnorm] = lsqcurvefit(P_fit,x0,a,P);

a0 = x(1);
w0 = x(2);
a_fit = linspace(min(a'),max(a'),1e3); % xdata for the fitting equation

figure(1);clf;
plot(a0-a,P,'ko',a0-a_fit,P_fit(x,a_fit),'r-','MarkerSize',8,'MarkerFaceColor','b'); grid on
xlabel('Knife edge movement')
ylabel('Count (kHz)')
legend('Data','Fit')
title('Beam power fit curve')

disp(['w0 = ',num2str(w0,3),' m'])
disp(['D for 86% power = ',num2str(2*w0,3),' m'])
disp(['D for 99% power = ',num2str(1.5*2*w0,3),' m'])