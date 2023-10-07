% MIMO Outage Probability Analysis
close all
clear all
clc
% Parameters
mT = 4;               % Number of transmit antennas
mR = 4;               % Number of receive antennas
N = 10^5;             % Number of channel realizations
SNRdB = 1:25;         % SNR range in dB
SNR = 10.^(SNRdB/10); % Convert SNR from dB to linear scale

rateth = 5;           % Target data rate (in bits/sec)

% Initialize variables for outage probabilities
p_outage_SISO = zeros(1, length(SNR));
p_outage_SIMO = zeros(1, length(SNR));
p_outage_MISO = zeros(1, length(SNR));
p_outage_MIMO = zeros(1, length(SNR));

for snr_idx = 1:length(SNRdB)

for iter = 1:N
    % Generate random channel matrices for SISO, SIMO, MISO, and MIMO
    seedValue = iter;
    rng(seedValue);
    
    H_SISO = (randn + 1i * randn) / sqrt(2);
    H_SIMO = (randn(mR, 1) + 1i * randn(mR, 1)) / sqrt(2);
    H_MISO = (randn(1, mT) + 1i * randn(1, mT)) / sqrt(2);
    H_MIMO = (randn(mR, mT) + 1i * randn(mR, mT)) / sqrt(2);

    % Calculate the capacity for each configuration
    C_SISO = log2(1 + SNR(snr_idx) .* abs(H_SISO).^2);
    C_SIMO = sum(log2(1 + SNR(snr_idx) .* abs(H_SIMO).^2));
    C_MISO = log2(1 + SNR(snr_idx) .* sum(abs(H_MISO).^2) / mT);
    C_MIMO = log2(abs(det(eye(mT) + SNR(snr_idx)* (H_MIMO * H_MIMO') / mT)));

    % Check for outage and update probabilities
    p_outage_SISO(iter) =+ (C_SISO < rateth);
    p_outage_SIMO(iter) =+ (C_SIMO < rateth);
    p_outage_MISO(iter) =+ (C_MISO < rateth);
    p_outage_MIMO(iter) =+ (C_MIMO < rateth);
end
% Calculate outage probabilities
avg_p_outage_SISO(snr_idx) = sum(p_outage_SISO) / N;
avg_p_outage_SIMO(snr_idx) = sum(p_outage_SIMO) / N;
avg_p_outage_MISO(snr_idx) = sum(p_outage_MISO) / N;
avg_p_outage_MIMO(snr_idx) = sum(p_outage_MIMO) / N;
end

% Plot the results
figure(1);
semilogy(SNRdB, avg_p_outage_SISO, 'r', SNRdB, avg_p_outage_SIMO, 'b--', SNRdB,...
    avg_p_outage_MISO, 'k-', SNRdB, avg_p_outage_MIMO, 'g-');
legend('SISO', 'SIMO', 'MISO', 'MIMO');
xlabel('SNR (dB)');
ylabel('Outage Probability');
title('Outage Probability vs. SNR');
grid on;
