%第一段浓度线性商上升ACH=100t(0.1ms后ACH达到10um)
clear;clc;
%计算第一段概率
ac=1000;
t=25;
t1=20;
K_2 = 40; K_1 = 0.25; alpha = 8; beta = 45;
a=t1/0.2;
initial_p=[1;0;0;0];
b=ac/t1;
Pp=initial_p;
d = 200; %泰勒展开式设定为200项

for i=1:a
    t_t=0.2;
    k2 = zeros(1,d); k2(2) = b; k2(1)=b*(i-1)*t_t;
    k1=0.06*k2;
    k2=0.1*k2;
    t2=0:0.001:t_t;
%     P_p0=jishuxishu(k1,k2,K_2,K_1,alpha,t2,beta,[1;0;0;0],d,0.2);
%     P_p1=jishuxishu(k1,k2,K_2,K_1,alpha,t2,beta,[0;1;0;0],d,0.2);
%     P_p2=jishuxishu(k1,k2,K_2,K_1,alpha,t2,beta,[0;0;1;0],d,0.2);
%     P_p3=jishuxishu(k1,k2,K_2,K_1,alpha,t2,beta,[0;0;0;1],d,0.2);
    P_int1=jishuxishu(k1,k2,K_2,K_1,alpha,t2,beta,initial_p,d,t_t);
%     P_int1=P_p0*initial_p(1)+P_p1*initial_p(2)+P_p2*initial_p(3)+P_p3*initial_p(4);
    P_int1=bsxfun(@times,P_int1,1./sum(P_int1)); 
    initial_p=P_int1(:,length(t2));
    Pp=[Pp,P_int1(:,2:length(t2))];
%     plot(t2+t_t*(i-1),P_int1(4,:),'r') %x轴线性刻度，y轴对数刻度
%     hold on
end

initial_p2=P_int1(:,length(t2));
k1=0.06*ac; k2=0.1*ac;
t3=t1:0.001:t;
P_0=nd_ten(k1,k2,K_2,K_1,alpha,beta,[1;0;0;0],t3,t1); 
P_1=nd_ten(k1,k2,K_2,K_1,alpha,beta,[0;1;0;0],t3,t1); 
P_2=nd_ten(k1,k2,K_2,K_1,alpha,beta,[0;0;1;0],t3,t1); 
P_3=nd_ten(k1,k2,K_2,K_1,alpha,beta,[0;0;0;1],t3,t1); 
P_int2=P_0*initial_p2(1)+P_1*initial_p2(2)+P_2*initial_p2(3)+P_3*initial_p2(4);
P_int2=bsxfun(@times,P_int2,1./sum(P_int2)); 
Pp=[Pp,P_int2(:,2:length(t3))];
t_t=0:0.001:25;
plot(t_t,Pp(4,:))
% plot(t3,P_int2(4,:),'r')

