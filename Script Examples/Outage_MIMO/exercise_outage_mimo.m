% MIMO Outage Probability Analysis
clear all;
clc;

%seedValue = 0;
%rng(seedValue);

%Initialization
N = 10^6;             % Number of random channel realizations
mT = 2;               % Number of transmit antennas
mR = 3;               % Number of receive antennas
SNRdB = 1:25;     % SNR range in dB
SNR = 10.^(SNRdB/10); % Convert SNR from dB to linear scale
rateth = 5;           % Threshold data rate (in bits/sec)
maxmonte_iterations = 10;

% Initialize variables for outage probabilities
p_outage_SISO = zeros(1, N);
p_outage_SIMO = zeros(1, N);
p_outage_MISO = zeros(1, N);
p_outage_MIMO = zeros(1, N);

avg_p_outage_SISO = zeros(1, length(SNR));
avg_p_outage_SIMO = zeros(1, length(SNR));
avg_p_outage_MISO = zeros(1, length(SNR));
avg_p_outage_MIMO = zeros(1, length(SNR));

for snr_idx = 1:length(SNRdB)
    
for iter = 1:N
    %fprintf('iter: %d\n',iter);
    % Generate random channel matrices for SISO, SIMO, MISO, and MIMO
    H_SISO = (randn + 1i * randn) / sqrt(2);%rayleigh fading channel
    H_SIMO = (randn(mR, 1) + 1i * randn(mR, 1)) / sqrt(2);%rayleigh fading channel
    H_MISO = (randn(1, mT) + 1i * randn(1, mT)) / sqrt(2);%rayleigh fading channel
    H_MIMO = (randn(mR, mT) + 1i * randn(mR, mT)) / sqrt(2);%rayleigh fading channel

    % Calculate the capacity for each configuration
    C_SISO = log2(1 + SNR(snr_idx) .* abs(H_SISO).^2);
    C_SIMO = sum(log2(1 + SNR(snr_idx) .* abs(H_SIMO).^2));
    C_MISO = log2(1 + SNR(snr_idx) .* sum(abs(H_MISO).^2) / mT);
    C_MIMO = log2(abs(det(eye(size((H_MIMO * H_MIMO'),1)) + SNR(snr_idx)* (H_MIMO * H_MIMO') / mT)));

    % Check for outage and update probabilities
    p_outage_SISO(iter) =+ (C_SISO < rateth);
    p_outage_SIMO(iter) =+ (C_SIMO < rateth);
    p_outage_MISO(iter) =+ (C_MISO < rateth);
    p_outage_MIMO(iter) =+ (C_MIMO < rateth);
    
end

avg_p_outage_SISO(snr_idx) = mean(p_ooutage_SISO);
avg_p_outage_SIMO(snr_idx) = mean(p_outage_SIMO);
avg_p_outage_MISO(snr_idx) = mean(p_outage_MISO);
avg_p_outage_MIMO(snr_idx) = mean(p_outage_MIMO);
end

% Plot the results
figure(1);
semilogy(SNRdB, avgg_p_outage_SISO, 'r', SNRdB, avgg_p_outage_SIMO, 'b--', SNRdB,avgg_p_outage_MISO, 'k-', SNRdB, avgg_p_outage_MIMO, 'g-');
legend('SISO', 'SIMO', 'MISO', 'MIMO');
xlabel('SNR (dB)');
ylabel('Outage Probability');
xlim([min(SNRdB), max(SNRdB)])  % min, max limits of x axis 
title('Outage Probability vs. SNR');
grid on;
