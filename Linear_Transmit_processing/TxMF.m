function [MSE, BER] = TxMF(simul,stream,ch1,SNR_dB)

M = simul.M;
N = simul.N;
E_tr = 2;
chreal = simul.perchannelrealization;
B = simul.B;
SNR = 10^(SNR_dB/10);



delta = (E_tr/B)/(2*SNR/M);


Rs = eye(2);
Rn = delta*eye(2);
G = eye(2);

H = ch1;



beta =sqrt(E_tr/(trace(H'*G'*Rs*G*H)));

s = stream;
P = beta*H'*G';

n = sqrt(delta)*sqrt(1/2)*(randn(M,chreal/B)+1i*randn(M,chreal/B));

shat = G*(H*P*s+n);

j_tx = SNR*B*G*H*H'*G'/trace(G*G');

MSE = trace(Rs)-((trace(j_tx*Rs))^2)/trace((j_tx^2+j_tx)*Rs);



shat_re = reshape(shat,[1,chreal]);


for ii = 1: chreal
    if real(shat_re(ii))>0
        if imag(shat_re(ii))>0 % 11
            shat(ii) = exp(1i*pi/4);
        else
            shat(ii) = exp(7i*pi/4); % 01
        end

    else
        if imag(shat_re(ii))>0

            shat(ii) = exp(3i*pi/4);
        else
            shat(ii) = exp(5i*pi/4);
        end

    end

end


shat = reshape(shat,[B,chreal/B]);


% if shat == stream
% 
%     BER = 0;
% 
% else
%     BER = sum(shat~=stream,"all")/chreal;
%     
% 
% end

BER1 = sum(real(shat)~=real(stream),"all");
BER2 = sum(imag(shat)~=imag(stream),"all");


BER = (BER1+BER2)/(2*chreal);


end
