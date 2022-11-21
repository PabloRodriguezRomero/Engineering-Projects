clear
clc
%
% FFT Harmonic Function
%
fs = 100; % Sampling Frequency
t = 0:1/fs:1; % Time Vector (1 second)
f = 5; % Create an Harmonic Function of f Hz.
pha = 1/3*pi; % Phase Shift
%
%x = sin(2*pi*f*t+pha); % Create a Sine Function of f Hz and Phase pha.
x = cos(2*pi*f*t+pha); % Create a Cosine Function of f Hz and Phase pha.
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
title('Harmonic Function');
xlabel('Time (s)');
ylabel('Amplitude');
%
figure(2)
plot(fv,mx); 
title('Power Spectrum of Harmonic Function');
xlabel('Frequency (Hz)'); 
ylabel('Power');