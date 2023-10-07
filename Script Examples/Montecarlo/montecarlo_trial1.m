
%Initialization
N = 10;             % Number of random channel realizations
mT = 2;               % Number of transmit antennas
mR = 3;               % Number of receive antennas
SNRdB = 1:25;     % SNR range in dB
SNR = 10.^(SNRdB/10); % Convert SNR from dB to linear scale
rateth = 5;           % Threshold data rate (in bits/sec)

for snr_idx = 1:length(SNRdB)
    
for iter = 1:N   
    seedValue = iter;
    rng(seedValue);
    fprintf('iter: %d\n',iter)
    % Generate random channel matrices for SISO, SIMO, MISO, and MIMO
    H_SISOt1(iter) = (randn + 1i * randn) / sqrt(2)%rayleigh fading channel
end
end