function [n] = Generate_Noise(simul,SNR_dB)

M = simul.M;
N = simul.N;
E_tr = 10^(simul.E_tr/10);
chreal = simul.perchannelrealization;
B = simul.B;
SNR = 10^(-SNR_dB/10);
delta = SNR; 

Rn = delta*eye(2);

SNR = ((E_tr)/B)/(trace(Rn)/M);

n = sqrt(1/SNR)*sqrt(1/(2))*(randn(M,chreal/B)+1i*randn(M,chreal/B));



end
