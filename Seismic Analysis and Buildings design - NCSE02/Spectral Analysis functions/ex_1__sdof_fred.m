clear
clc
%
% Response of SDOF Systems Under Harmonic Load
%            Frequency Domain Analysis
%
ms=100; % Structural Mass [kg]
ff=3; % Natural Frequency [Hz]
zetas=1/100; % Damping ratio [-]. Ratio de amortiguamiento.
%
ks=ms*(2*pi*ff)^2;  %rigidez sistema. Recuerda w=sqrt(k/m)
cs=2*ms*zetas*(2*pi*ff);    %amortiguameiento sistema
%
% FFT of the External Load
%
deltat=0.01; % Time Increment [s]
ttotal=20; % Total Time [s]
t=0:deltat:ttotal;  %vector de tiempo. dominio temporal del tiempo
%
for i=1:length(t)
p(i)=ext_harm_load(t(i));   %carga del sistema. En el ejemplo 1 hay tres tipos. Se mete en 
end
%
nfft = length(p); % Length of FFT. Defino que la longitud de la transformada es la longitud de la carga
fs=100; % Sampling Frequency.

%La regla de Linguish te dice que puedes tomar como válidos resultados hasta la mitad de la
%frecuencia de sampleo (100Hz/2=50Hz). La frecuencia de la fuerza debe
%estar en el rango por tanto de 0-50Hz. En este caso la fuerza va a 3Hz
%luego el resultado es válido.


p_fft = fft(p,nfft); % FFT of Externa Load. Transformada de Fourier.
f_fft=((0:1/nfft:1-1/nfft)*fs).'; % Frecuencies of FFT [Hz]
w_fft=2*pi*f_fft; % Frequencies of FFT [rad/s]
mag_p_fft=abs(p_fft); % Magnitude of External Force
%
figure(1)
plot(f_fft(1:length(f_fft)/2-1),mag_p_fft(1:length(f_fft)/2-1))
title('FFT External Load'); 
xlabel('Frequency [Hz]')
%Esto me da la transformada de Fourier que debe ser un punto en 2 Hz porque
%es una frecuencia armónica pura en 2Hz. 2Hz porque así lo dice el (i) del
%p(t) del ejemplo 1. 4*pi=2*pi*f


% FRF
%
j=sqrt(-1);
for i=1:length(f_fft)
%    
H_frf(i)=1/((ks-w_fft(i)^2*ms)+j*w_fft(i)*cs);
%
end
%
figure(2)
plot(f_fft(1:length(f_fft)/2-1),abs(H_frf(1:length(f_fft)/2-1)))
title('Frequency Response Function'); 
xlabel('Frequency [Hz]')
%
% Response in Frequency Domain
%
y_fft=H_frf.*p_fft;
y_time =ifft(y_fft,nfft,'symmetric');
%
figure(3)
plot(f_fft(1:length(f_fft)/2-1),abs(y_fft(1:length(f_fft)/2-1)))
title('FFT Response'); 
xlabel('Frequency [Hz]')
%Esta es la respuesta del sistema, en este caso el desplazamiento. Es el producto de Figure(1) por Figure
%(2) siendo las transformadas de Fourier de la fext y del filtro del
%sistema. Esto tres términos son los de la función de transferencia.


% Plot Results
%
figure(4)
plot(t,y_time,'-b')
title('Response of the structure (Frequency Domain)'); 
xlabel('Time [s]')
ylabel('x(t) [m]')
%Esto es tb la respuesta del sistema pero en el dominio del tiempo en vez
%de la frecuencia (Figure (3)).