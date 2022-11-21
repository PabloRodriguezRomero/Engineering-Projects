clear
clc
%
% Response of SDOF Systems Under Earthquake Action
%            Time Domain Analysis
%
ms=2000; % Structural Mass [kg]
ff=2; % Natural Frequency [Hz]
zetas=5/100; % Damping ratio [-]
%
ks=ms*(2*pi*ff)^2;
cs=2*ms*zetas*(2*pi*ff);
%
A = [0 1; -ks/ms -cs/ms];
B = [0 1/ms]';
C = [1 0];
D = [0];
%
sys = ss(A,B,C,D); % State-Space Model
%
% Time Domain 
%
load elcentro.mat
%
figure(1)
plot(elcentro(:,1),elcentro(:,2))
title('El Centro Earthquake'); 
xlabel('Time [s.]')
ylabel('Acceleration [m/s2]')
axis([0 max(elcentro(:,1)) -3.5 3.5])
%
deltat=0.02; % Time Increment [s]
ttotal=elcentro(1560,1); % Total Time [s]
t=0:deltat:ttotal;
%
for i=1:length(t)
p(i)=-ms*elcentro(i,2);
end
%
[y, tsim,z]=lsim(sys, p, t);
%
% Plot Results
%
figure(2)
plot(tsim,y,'-g')
title('Response of the structure (Time Domain)'); 
xlabel('Time [s]')
ylabel('x(t) [m]')