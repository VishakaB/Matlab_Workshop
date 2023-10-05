%{
AM Modulation and Demodulation
--------------------------------------------------------------------------
File: Script_AM_Mod_Demod.m  

Description: AM based Modualation and Demodulation Process Demonstration   

Author: Vishaka Basnayake

Contact Information:
  - Email: vishakab@sltc.ac.lk
  - GitHub: https://github.com/vishakab

Date: October 7, 2023

Revision History:
  - Version 1.0 (October 1, 2023): Initial release.
  - Version 1.1 (October 4, 2023): Update filter order and passband edge frequency
%}

%--------------------------------------------------------------------------
clc
clear all
close all

%% Initialization

fs = 2^14; % Sampling frequency
t = 0:1/fs:1; % Time vector
fc = 1000; % Carrier frequency (Hz)
fm = 50; % Message signal frequency (Hz)
Am = 1; % Message signal amplitude
Ac = 2; % Carrier signal amplitude

%% Transmission

% Message signal (sine wave)
message_signal = Am * sin(2*pi*fm*t);

% Carrier signal (sine wave)
carrier_signal = Ac * sin(2*pi*fc*t);

% DSB modulation
modulated_signal = message_signal .* carrier_signal;

%% Reception
% DSB demodulation
demodulated_signal = modulated_signal .* carrier_signal;

% Low-pass filtering to remove carrier frequency
% Design the FIR low-pass filter using fir1
passband_edge = 100; % Passband edge frequency (Hz)
stopband_edge = 2500; % Stopband edge frequency (Hz)
filter_order = 50; % Filter order
normalized_passband_edge = passband_edge / (fs/2);
normalized_stopband_edge = stopband_edge/ (fs/2);
filter_coeff = fir1(filter_order, [normalized_passband_edge, normalized_stopband_edge], 'low');
 
% Use the filter function to filter the demodulated signal
filtered_demodulated_signal = filter(filter_coeff, 1, demodulated_signal);

%% Visualization
% Plot the signals
subplot(5,1,1);
plot(t, message_signal);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(5,1,2);
plot(t, carrier_signal);
title('Carrier Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Display the modulated signal
subplot(5,1,3);
plot(t, modulated_signal);
title('Modulated Signal (DSB)');
xlabel('Time (s)');
ylabel('Amplitude');

% Display the Filtered and Demodulated signal (should resemble the message signal)
subplot(5,1,4);
plot(t, demodulated_signal);
title('Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Display the Filtered and Demodulated signal (should resemble the message signal)
subplot(5,1,5);
plot(t, filtered_demodulated_signal);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');
