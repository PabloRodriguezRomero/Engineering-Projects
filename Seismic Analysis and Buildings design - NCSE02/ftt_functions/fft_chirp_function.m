clear
clc

%Este archivo consiste en hacer la transformada de Fourier a la funci�n
%Chirp de MatLab.
%
% FFT Chirp Function
%
fs = 100; % Sampling Frequency (Hz). Esto es lo que mide el aceler�metro. Cuantos m�s Hz, m�s informaci�n recoge por segundo pero peor recoge las frecuencias bajas.
t = 0:1/fs:1; % Time Vector (1 second) %El tiempo donde voy a evaluar la funci�n (0 a 1sg a 0.01sg de paso)
%
x = chirp(t,0,t(length(t)),fs/5);  % Generate Chirp Function. Es una funci�n que tiene la misma amplitud pero var�a su "ritmillo" a m�s.
%Chirp es una funci�n de matlab que nos sirve porque es una oscilaci�n
%arm�nica que var�a su frecuencia con el tiempo.


% Fast Fourier Transform
%
nfft = 1024; % Length of FFT  %N�mero de puntos para hacer la transform. Fourier. Es la precisi�n del c�lculo.
%nfft tiene que ser exponente de 2 (512,1024,2048,...) porque la
%transformada de Fourier r�pida necesita que sea exp2 para funcionar.


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
fv = (0:nfft/2-1)*fs/nfft; %Frecuencia unidad. Es el vector que hace el "dominio de frecuencia". Osea los puntos de abcisa donde se representa la funci�n en la transformada (dominio frecuencia)
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



%El plot es una representaci�n discreta de la distribuci�n continua de la
%realidad en frecuencia.