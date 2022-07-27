% 2022-07-16
% paper : Linear Transmit Processing in MIMO Communications Systems
% made by Kohs
% what learn? precoder and decoder 

clear all; close all; warning off; tic

% setting parameter

simul.M = 2;          % number of Tx anttena
simul.N = 2;          % number of Rx anttena
simul.B = 2;          % parallel data stream
simul.E_tr = 2;       % transmit power
simul.experiments = 1000; % channel realization
simul.SNR_dB = [-10 : 5 : 30]; 
simul.perchannelrealization = 100;


% 한번의 channel realization 동안 100개의 QPSK로 비트 심볼의 갯수가 2인?

SNR_dB = simul.SNR_dB;


%setting temp
RxMF_MSE_temp = zeros(simul.experiments,length(SNR_dB));
RxZF_MSE_temp = zeros(simul.experiments,length(SNR_dB));
RxWF_MSE_temp = zeros(simul.experiments,length(SNR_dB));
TxMF_MSE_temp = zeros(simul.experiments,length(SNR_dB));
TxZF_MSE_temp = zeros(simul.experiments,length(SNR_dB));
TxWF_MSE_temp = zeros(simul.experiments,length(SNR_dB));

RxMF_BER_temp = zeros(simul.experiments,length(SNR_dB));
RxZF_BER_temp = zeros(simul.experiments,length(SNR_dB));
RxWF_BER_temp = zeros(simul.experiments,length(SNR_dB));
TxMF_BER_temp = zeros(simul.experiments,length(SNR_dB));
TxZF_BER_temp = zeros(simul.experiments,length(SNR_dB));
TxWF_BER_temp = zeros(simul.experiments,length(SNR_dB));




for ii = 1: length(SNR_dB)


    for expr = 1: simul.experiments

        stream=Generate_Data_stream1(simul);
        ch1 = Generate_Channel(simul);
        chMat(expr,ii) = trace(ch1*ch1');

        [RxMF_MSE_temp(expr,ii), RxMF_BER_temp(expr,ii)] = RxMF(simul,stream,ch1,SNR_dB(ii));
        [RxZF_MSE_temp(expr,ii), RxZF_BER_temp(expr,ii)] = RxZF(simul,stream,ch1,SNR_dB(ii));
        [RxWF_MSE_temp(expr,ii), RxWF_BER_temp(expr,ii)] = RxWF(simul,stream,ch1,SNR_dB(ii));
 
        [TxMF_MSE_temp(expr,ii), TxMF_BER_temp(expr,ii)] = TxMF(simul,stream,ch1,SNR_dB(ii));
        [TxZF_MSE_temp(expr,ii), TxZF_BER_temp(expr,ii),P(:,:,ii)] = TxZF(simul,stream,ch1,SNR_dB(ii));
        [TxWF_MSE_temp(expr,ii), TxWF_BER_temp(expr,ii)] = TxWF(simul,stream,ch1,SNR_dB(ii));


    end

    fprintf('SNR_dB: %d , simulation time: %.1f seconds \n',SNR_dB(ii),toc);
 



end




RxMF_MSE = sum(RxMF_MSE_temp)/simul.experiments;
RxZF_MSE = sum(RxZF_MSE_temp)/simul.experiments;
RxWF_MSE = sum(RxWF_MSE_temp)/simul.experiments;
TxMF_MSE = sum(TxMF_MSE_temp)/simul.experiments;
TxZF_MSE = sum(TxZF_MSE_temp)/simul.experiments;
TxWF_MSE = sum(TxWF_MSE_temp)/simul.experiments;

RxMF_BER = sum(RxMF_BER_temp)/simul.experiments;
RxZF_BER = sum(RxZF_BER_temp)/simul.experiments;
RxWF_BER = sum(RxWF_BER_temp)/simul.experiments;
TxMF_BER = sum(TxMF_BER_temp)/simul.experiments;
TxZF_BER = sum(TxZF_BER_temp)/simul.experiments;
TxWF_BER = sum(TxWF_BER_temp)/simul.experiments;


mean(chMat,'all')

% result plot

figure 
semilogy(SNR_dB,RxMF_BER,"|-",'LineWidth',2)
hold on
semilogy(SNR_dB,RxZF_BER,"o-",'LineWidth',2)
semilogy(SNR_dB,RxWF_BER,"*-",'LineWidth',2)
semilogy(SNR_dB,TxMF_BER,"^-",'LineWidth',2)
semilogy(SNR_dB,TxZF_BER,"v-",'LineWidth',2)
semilogy(SNR_dB,TxWF_BER,"d-",'LineWidth',2)
title("BER")
axis([-10 30 10^-3 1])
grid on

legend("RxMF","RxZF","RxWF","TxMF","TxZF","TxWF")


% figure
% semilogy(SNR_dB,RxMF_MSE,"|-",'LineWidth',2)
% hold on
% semilogy(SNR_dB,RxZF_MSE,"*-",'LineWidth',2)
% semilogy(SNR_dB,RxWF_MSE,"*-",'LineWidth',2)
% semilogy(SNR_dB,TxMF_MSE,"^-",'LineWidth',2)
% semilogy(SNR_dB,TxZF_MSE,"v-",'LineWidth',2)
% semilogy(SNR_dB,TxWF_MSE,"d-",'LineWidth',2)
% 
% title("MSE")
% axis([-10 30 10^-2 2])
% grid on
% 
% legend("RxMF","RxZF","RxWF","TxMF","TxZF","TxWF")