clear
clc
%
% FFT Square Pulse Function
%
fs = 100; % Sampling Frequency
t = -0.5:1/fs:0.5; % Time Vector (1 second)
w = 0.2; % Widht of the Rectangule
%
x = rectpuls(t,w); % Generate Square Pulse
%
% Fast Fourier Transform
%
nfft = 512; % Length of FFT
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
title('Square Pulse Function');
xlabel('Time (s)');
ylabel('Amplitude');
%
figure(2)
plot(fv,mx); 
title('Power Spectrum of Square Pulse Function');
xlabel('Frequency (Hz)'); 
ylabel('Power');