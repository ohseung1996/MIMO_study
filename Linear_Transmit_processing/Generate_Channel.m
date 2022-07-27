function [ch1] = Generate_Channel(simul)

M = simul.M;
N = simul.N;

ch1 = sqrt(1/2)*(randn(M,N)+1i*randn(M,N));

ch1 = ch1./sqrt(trace(ch1'*ch1));

end
