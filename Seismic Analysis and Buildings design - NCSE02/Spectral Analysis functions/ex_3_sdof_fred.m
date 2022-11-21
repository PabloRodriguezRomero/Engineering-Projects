clear
clc
%
% Response of SDOF Systems Under Earthquake Action
%            Frequency Domain Analysis
%

%Este ejemplo tiene ya un terremoto.

%Datos del enunciado
ms=2000; % Structural Mass [kg]
ff=2; % Natural Frequency [Hz]
zetas=5/100; % Damping ratio [-]. Ratio amortiguamiento (5% en este caso)

%Paso 1: Sacamos la k y c del sistema
ks=ms*(2*pi*ff)^2;
cs=2*ms*zetas*(2*pi*ff);

%Paso 2: Cargamos el .mat de aceleraciones del terremoto (El Centro.mat)
%Problema de "escitación de base"
load elcentro.mat

%Paso 3: Ploteamos en dominio temporal la acel. terremoto
figure(1)
plot(elcentro(:,1),elcentro(:,2))
title('El Centro Earthquake'); 
xlabel('Time [s.]')
ylabel('Acceleration [m/s2]')
axis([0 max(elcentro(:,1)) -3.5 3.5])

%
deltat=0.02; % Time Increment [s]
ttotal=elcentro(1560,1); % Total Time [s]   %El tiempo del terremoto está en elcentro.mat. [1º columna,fila 1560(última)]
t=0:deltat:ttotal;
%
for i=1:length(t)
p(i)=-ms*elcentro(i,2);     %Aqui paso la acel del terremoto a una carga mutiplicando por la masa. Problema de Escitación en la base.
end
%
nfft = length(p); % Length of FFT. La frecuencia de la transformada será la de la excitación externa p(t).
fs=50; % Sampling Frequency
p_fft = fft(p,nfft); % FFT of El Centro Earthquake
f_fft=((0:1/nfft:1-1/nfft)*fs).'; % Frecuencies of FFT [Hz]
w_fft=2*pi*f_fft; % Frequencies of FFT [rad/s]. Igual que la linea anterior pero pasado a rad/s por si lo pide.
mag_p_fft=abs(p_fft); % Magnitude of El Centro Earthquake. Magnitud de la carga equivalente del terremoto, no del sistema.
%
figure(2)
plot(f_fft(1:length(f_fft)/2-1),mag_p_fft(1:length(f_fft)/2-1))
title('FFT El Centro Earthquake'); 
xlabel('Frequency [Hz]')
%
% FRF
%
j=sqrt(-1);
for i=1:length(f_fft)
%    
H_frf(i)=1/((ks-w_fft(i)^2*ms)+j*w_fft(i)*cs);
%
end
%
figure(3)
plot(f_fft(1:length(f_fft)/2-1),abs(H_frf(1:length(f_fft)/2-1)))
title('Frequency Response Function'); 
xlabel('Frequency [Hz]')
%
% Response in Frequency Domain
%
y_fft=H_frf.*p_fft;
y_time =ifft(y_fft,nfft,'symmetric');
%
figure(4)
plot(f_fft(1:length(f_fft)/2-1),abs(y_fft(1:length(f_fft)/2-1)))
title('FFT Response'); 
xlabel('Frequency [Hz]')
%
% Plot Results
%
figure(5)
plot(t,y_time,'-b')
title('Response of the structure (Frequency Domain)'); 
xlabel('Time [s]')
ylabel('x(t) [m]')