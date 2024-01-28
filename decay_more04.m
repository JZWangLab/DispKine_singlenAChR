clc;clear;
%浓度为10达到平稳后线性下降为0
%第一段先算平稳概率
%浓度恒为10，[Ach]=10
achc=100;tt=1;
d = 200; %泰勒展开式设定为200项
% K_2 = 8.15; K_1 = 16.3; alpha = 0.714; beta = 30.6;
k1=0.06*achc; k2=0.1*achc;
K_2 = 40; K_1 = 0.25; alpha = 8; beta = 45;
initial_p1=[K_1*K_2*alpha;k1*K_2*alpha;k1*k2*alpha;k1*k2*beta]/(K_1*K_2*alpha+k1*K_2*alpha+k1*k2*alpha+k1*k2*beta);
b=tt/0.2;
Pp=initial_p1;
% P_M=zeros(1,b);P_m=zeros(1,b);

for j=1:5
    
   d = 200; %泰勒展开式设定为200项
    ac=-achc/tt;t1=0.2;
    k2 = zeros(1,d); k2(1) = achc+(j-1)*ac*t1; 
    %k2 = zeros(1,d); k2(1) = achc;
    k2(2)=ac;
    % k2(2)=ac;
    k1=0.06*k2;
    k2=0.1*k2;
    % k1=2*k2;
    t2=0:0.001:t1;
%     P_p00=jishuxishu(k1,k2,K_2,K_1,alpha,t2,beta,[1;0;0;0],d,t1);
%     P_p11=jishuxishu(k1,k2,K_2,K_1,alpha,t2,beta,[0;1;0;0],d,t1);
%     P_p22=jishuxishu(k1,k2,K_2,K_1,alpha,t2,beta,[0;0;1;0],d,t1);
%     P_p33=jishuxishu(k1,k2,K_2,K_1,alpha,t2,beta,[0;0;0;1],d,t1);
    P_int1=jishuxishu(k1,k2,K_2,K_1,alpha,t2,beta,initial_p1,d,t1);
    P_int1=bsxfun(@times,P_int1,1./sum(P_int1)); 
    Pp=[Pp,P_int1(:,2:length(t2))];
    initial_p1=P_int1(:,length(t2));
%     semilogy(t2(2:length(t2))+0.2*(j-1),P_int1(4,2:length(t2)),'b')
    
    hold on
end

t3=2.5-tt;
t=tt:0.001:2.5;
initial_p2=initial_p1;
% t0=t1; %此时浓度直接为零
P_int=ndwl(K_2,K_1,alpha,beta,initial_p2,t,tt);
t_t=0:0.001:tt;
plot(t_t,Pp(4,:))
% cftool(t_t,Pp(4,:))
% x=t(t_t);
% y=Pp(4,:);
% xdata=t_t;
% ydata=Pp(4,:);
% csvwrite('1.csv',ydata)
t_t=0:0.001:2.5;
Pp=[Pp,P_int(:,2:length(t))];
% ydata=Pp(4,:)';
% csvwrite('01_all.csv',ydata)
% plot(t_t,Pp(4,:))
% cftool(t_t,Pp(4,:))
% semilogy(t,P_int(4,:))
% t_tt=0:0.001:tt;
% cftool(t,P_int(4,:))
% syms x
% y=exp(-x);
% m=7;a=1;
% w=talorcof(y,m,a);