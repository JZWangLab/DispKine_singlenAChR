clc;clear;
%浓度为10达到平稳后线性下降为0
%第一段先算平稳概率
%浓度恒为10，[Ach]=10
ac=500;
l = 99; %泰勒展开式设定为200项
% K_2 = 8.15; K_1 = 16.3; alpha = 0.714; beta = 30.6;
k1=0.06*ac; k2=0.1*ac;
K_2 = 40; K_1 = 0.25; alpha = 8; beta = 45;
P_int1=[K_1*K_2*alpha;k1*K_2*alpha;k1*k2*alpha;k1*k2*beta]/(K_1*K_2*alpha+k1*K_2*alpha+k1*k2*alpha+k1*k2*beta);
Pp=P_int1;
%第二段下降阶段浓度呈指数函数10*exp(-k*x)
d=9;
t=3;
syms x
y=ac*exp(-d*x);
% L2=double(coeffs(L));
% k1=(0.06.*L2);k2=(0.1.*L2);
K_2 = 40; K_1 = 0.25; alpha = 8; beta = 45;
t2=0.1;
b=t/t2;
for i=1:b
    
    t3=0:0.001:t2;
    L2=talorcof(y,l,t2*(i-1));
    k1=(0.06.*L2);k2=(0.1.*L2);
%     P_p0=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[1;0;0;0],d,t2);
%     P_p1=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[0;1;0;0],d,t2);
%     P_p2=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[0;0;1;0],d,t2);
    P_int2=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,P_int1,d,t2);
%     P_int2=P_p0*P_int1(1)+P_p1*P_int1(2)+P_p2*P_int1(3)+P_p3*P_int1(4);
    P_int1=P_int2(:,length(t3));
    P_int2=bsxfun(@times,P_int2,1./sum(P_int2));
    Pp=[Pp,P_int2(:,2:length(t3))];
end
% F=10*exp(-t3);
% yyaxis left %左侧绘制打开概率
t_t=0:0.001:t;
plot(t_t,Pp(4,:)) %此时x轴为线性，y轴为对数坐标
hold on
% xlabel('time(ms)')
% semilogy(t_t,Pp(4,:))
cftool(t_t,Pp(4,:))
% P_P=Pp(4,:)';
% csvwrite('k_9c_10.csv',P_P)
% csvwrite('t_t.csv',t_t')
% ylabel('Open probability')
% yyaxis right
% plot(t3,F)
% ylabel('ACh concentration(μM)')
% legend('Channel open probability','ACh concentration')
% 
% cftool(t3,P_int2(4,:));
% Pp=P_int2(4,:)';
% t_t=t3';

% csvwrite('t_k_1.csv',t_t)
% % csvwrite('k_1_all.csv',Pp)
% F=zeros(1,length(t_t));
% for i=1:length(t_t)
%     F(1,i)=500*exp(-5*t_t(i));
% end
% plot(t_t,F)