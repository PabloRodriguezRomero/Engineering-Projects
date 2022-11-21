clear
clc
%
% FFT Exponential Decay Function
%
fs = 100; % Sampling Frequency
t = 0:1/fs:1; % Time Vector (1 second)
%
x = 2*exp(-5*t);  % Generate Exponential Decay
%
% Fast Fourier Transform
%
nfft = 1024; % Length of FFT
%
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
fv = (0:nfft/2-1)*fs/nfft; 
%
% Generate the Plot
%
figure(1)
plot(t,x);
title('Exponential Decay Function');
xlabel('Time (s)');
ylabel('Amplitude');
%
figure(2)
plot(fv,mx); 
title('Power Spectrum of Exponential Decay Function');
xlabel('Frequency (Hz)');
ylabel('Power');