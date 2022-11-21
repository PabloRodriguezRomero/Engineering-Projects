clear
clc
%
% FFT Gaussina Pulse Function
%
fs = 100; % Sampling Frequency
t = -0.5:1/fs:0.5; % Time Vector (1 second)
%
x = 1/(sqrt(2*pi*0.01))*(exp(-t.^2/(2*0.01))); % Generate Gaussian Pulse
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
title('Gaussian Pulse Function');
xlabel('Time (s)');
ylabel('Amplitude');
%
figure(2)
plot(fv,mx); 
title('Power Spectrum of Gaussian Pulse Function');
xlabel('Frequency (Hz)');
ylabel('Power');