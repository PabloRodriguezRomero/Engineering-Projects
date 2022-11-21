clear
clc
%
% Bode and Nyquist Diagrams
%       SDOF systems
%
%
% Input
%
ms = 1000; % Structural Mass [kg] 
fs=5; % Natural Frequency [Hz]
zetas=[0.1 0.5 1 2 5]/1000; % Structural Damping Ratio [-]
%
% Structural Parameters
%
cs = 2*ms*zetas.*(2*pi*fs); % damping coeffcient [sN/m]
ks = ms*(2*pi*fs)^2; % stiffness coefficient [N/m]
%
% Transfer Function
%
s = tf('s');
%
H1 = 1/(ms*s^2 + cs(1)*s + ks);
H2 = 1/(ms*s^2 + cs(2)*s + ks);
H3 = 1/(ms*s^2 + cs(3)*s + ks);
H4 = 1/(ms*s^2 + cs(4)*s + ks);
H5 = 1/(ms*s^2 + cs(5)*s + ks);
%
% Bode Diagram
%
figure(1)
bode(H1,H2,H3,H4,H5)
grid on
%
% Nyquist Diagram
%
figure(2)
nyquist(H1,H2,H3,H4,H5)
axis([-0.006 0.006 -0.006 0.006])
grid on