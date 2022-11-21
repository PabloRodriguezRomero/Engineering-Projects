clear
clc

%Este archivo consiste en hacer la transformada de Fourier a la función
%Chirp de MatLab.
%
% FFT Chirp Function
%
fs = 100; % Sampling Frequency (Hz). Esto es lo que mide el acelerómetro. Cuantos más Hz, más información recoge por segundo pero peor recoge las frecuencias bajas.
t = 0:1/fs:1; % Time Vector (1 second) %El tiempo donde voy a evaluar la función (0 a 1sg a 0.01sg de paso)
%
x = chirp(t,0,t(length(t)),fs/5);  % Generate Chirp Function. Es una función que tiene la misma amplitud pero varía su "ritmillo" a más.
%Chirp es una función de matlab que nos sirve porque es una oscilación
%armónica que varía su frecuencia con el tiempo.


% Fast Fourier Transform
%
nfft = 1024; % Length of FFT  %Número de puntos para hacer la transform. Fourier. Es la precisión del cálculo.
%nfft tiene que ser exponente de 2 (512,1024,2048,...) porque la
%transformada de Fourier rápida necesita que sea exp2 para funcionar.


% Take FFT, padding with zeros so that length(X) is equal to nfft
%
X = fft(x,nfft);
%
% FFT is symmetric, throw away second half
%
X = X(1:nfft/2);
%
% Take the magnitude of FFT of x
%
mx = abs(X);
%
% Frequency vector
%
fv = (0:nfft/2-1)*fs/nfft; %Frecuencia unidad. Es el vector que hace el "dominio de frecuencia". Osea los puntos de abcisa donde se representa la función en la transformada (dominio frecuencia)
%
% Generate the Plot
%
figure(1)
plot(t,x);
title('Chirp Function');
xlabel('Time (s)');
ylabel('Amplitude');
%
figure(2)
plot(fv,mx); 
title('Power Spectrum of Chirp Function');
xlabel('Frequency (Hz)');
ylabel('Power');



%El plot es una representación discreta de la distribución continua de la
%realidad en frecuencia.