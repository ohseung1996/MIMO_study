function [MSE, BER] = RxWF(simul,stream,ch1,SNR_dB)

M = simul.M;
N = simul.N;
E_tr = simul.E_tr;
chreal = simul.perchannelrealization;
B = simul.B;
SNR = 10^(SNR_dB/10);
alpha = 1;
delta = (E_tr/B)/(2*SNR/M);
H = ch1;
Rs = eye(2);
Rn = delta*eye(2);
P = eye(2);


s = stream;
G = inv(P'*H'*inv(Rn)*H*P+inv(Rs))*P'*H'*inv(Rn);

n = sqrt(1/SNR)*sqrt(1/2)*(randn(M,chreal/B)+1i*randn(M,chreal/B));



shat = G*(H*P*s+n);

j_rx = SNR*B*P'*H'*H*P/trace(P*P');

MSE = trace(Rs)-trace((inv(j_rx+eye(B))*j_rx*Rs));



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
