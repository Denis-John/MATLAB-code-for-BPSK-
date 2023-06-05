%BER OF BPSK under AWGN
clc
clear all
close all
N=10000;
m=randi([0 1],1,N);
%mapping 
for i=1:N
 if m(i)==0
     x(i)=-1;
 else
     x(i)=1;
end
end
BER_sim=[];
BER_th=[];
BER_th_q=[];
BER_app=[];
mean_n=0;
for EbNOdB=0:15
EbNO=10^(EbNOdB/10);
SD=sqrt(1/(2*EbNO));
n=mean_n+SD.*randn(1,N);%AWGN Channel

r=x+n;%received vector

m_cap=(r>0);
ber=sum(m_cap~=m)/N;
BER_sim=[BER_sim ber];
BER_th=[BER_th 0.5*erfc(sqrt(EbNO))];
BER_th_q=[BER_th_q qfunc(sqrt(2*EbNO))];
BER_app=[BER_app 0.5*exp(-EbNO)];
end
EbNOdB=0:15;
semilogy(EbNOdB,BER_sim,'r-*',EbNOdB,BER_th,'k',EbNOdB,BER_th_q,'g+-',EbNOdB,BER_app,'m<-')
xlabel('Eb/NO(dB)')
ylabel('BER');
legend('simulation','Theory(erfc)','Theory(Q)','Approximation')
grid on
title('BER Performance of BPSK under AWGN Channel')