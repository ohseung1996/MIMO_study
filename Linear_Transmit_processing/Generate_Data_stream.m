
function [stream]=Generate_Data_stream(simul)



% stream 은 Bx1 구조임. 즉 2x1 구조이고 100개의 QPSK 로 만든다는데 사실상 00비트로 만들면 될스
% 즉 다시말해 2x100 구조의 stream 을 만들것 


ch_realization = simul.perchannelrealization;
B = simul.B;


signal_QPSK = randi([0 3], [1,ch_realization]);


for n=1:ch_realization
    
 %QPSK
    if (signal_QPSK(n) == 0)
        stream_QPSK(n) = exp(1i*pi/4);
    elseif(signal_QPSK(n) == 1)
        stream_QPSK(n) = exp(1i*(3*pi/4));
    elseif(signal_QPSK(n) == 2)
        stream_QPSK(n) = exp(1i*(7*pi/4));
    elseif(signal_QPSK(n) == 3)
        stream_QPSK(n) = exp(1i*(5*pi/4));
    end   
                 
   
 end


stream = reshape(stream_QPSK,[B,ch_realization/B]);

end
