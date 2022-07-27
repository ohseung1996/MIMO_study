
function [stream]=Generate_Data_stream1(simul)



% stream 은 Bx1 구조임. 즉 2x1 구조이고 100개의 QPSK 로 만든다는데 사실상 00비트로 만들면 될스
% 즉 다시말해 2x100 구조의 stream 을 만들것 


ch_realization = simul.perchannelrealization;
B = simul.B;


a = randi([0 3], [1,ch_realization]);

a = a*2+1;

stream_QPSK = exp(a.*1i*pi/4);


stream = reshape(stream_QPSK,[B,ch_realization/B]);

end
