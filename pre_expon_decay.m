%ACh浓度周期变化
%第一个周期
%先0.1秒线性上升到10uM（100t）,此时的初始概率为（1，0，0，0）
clear;clc;
achc=100;d=3;
tt=[0.1,15];
% a=[68,117,123]/255;
% PP=zeros(4,5);
%计算第一段概率
%k1 = 0.06*[Ach](t); k2 = 0.1[Ach](t); [Ach](t) = 100t
% K_2 = 16.3; K_1 = 8.15; alpha = 0.714; beta = 30.6;
K_2 = 40; K_1 = 0.25; alpha = 8; beta = 45;
initial_p1=[1;0;0;0];
%第二段10uM保持0.2ms，
%此时的初始条件为
t1=tt(1);
t0=0; t=t0:0.001:t1+t0;
k1=0.06*achc; k2=0.1*achc;
% k2=0.1*achc;k1=2*k2;
P_0=nd_ten(k1,k2,K_2,K_1,alpha,beta,[1;0;0;0],t,t0); 
P_1=nd_ten(k1,k2,K_2,K_1,alpha,beta,[0;1;0;0],t,t0); 
P_2=nd_ten(k1,k2,K_2,K_1,alpha,beta,[0;0;1;0],t,t0); 
P_3=nd_ten(k1,k2,K_2,K_1,alpha,beta,[0;0;0;1],t,t0); 
P_int1=P_0*initial_p1(1)+P_1*initial_p1(2)+P_2*initial_p1(3)+P_3*initial_p1(4);

P_int1=bsxfun(@times,P_int1,1./sum(P_int1));
% P_M1=P_int1;
Pp=P_int1;
% plot(t,P_int1(4,:),'color',a)
initial_p2=P_int1(:,length(t));

% ac=500;
l = 99; %泰勒展开式设定为200项
% K_2 = 8.15; K_1 = 16.3; alpha = 0.714; beta = 30.6;
% k1=0.06*ac; k2=0.1*ac;
% K_2 = 40; K_1 = 0.25; alpha = 8; beta = 45;
% P_int1=[K_1*K_2*alpha;k1*K_2*alpha;k1*k2*alpha;k1*k2*beta]/(K_1*K_2*alpha+k1*K_2*alpha+k1*k2*alpha+k1*k2*beta);
% Pp=P_int1;
%第二段下降阶段浓度呈指数函数10*exp(-k*x)

t=tt(2);
syms x
y=achc*exp(-d*x);
% L2=double(coeffs(L));
% k1=(0.06.*L2);k2=(0.1.*L2);
% K_2 = 40; K_1 = 0.25; alpha = 8; beta = 45;
t2=0.1;
b=t/t2;
for i=1:b
    
    t3=0:0.001:t2;
    L2=talorcof(y,l,t2*(i-1));
    k1=(0.06.*L2);k2=(0.1.*L2);
%     P_p0=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[1;0;0;0],d,t2);
%     P_p1=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[0;1;0;0],d,t2);
%     P_p2=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[0;0;1;0],d,t2);
    P_int2=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,initial_p2,l,t2);
%     P_int2=P_p0*P_int1(1)+P_p1*P_int1(2)+P_p2*P_int1(3)+P_p3*P_int1(4);
    initial_p2=P_int2(:,length(t3));
    P_int2=bsxfun(@times,P_int2,1./sum(P_int2));
    Pp=[Pp,P_int2(:,2:length(t3))];
end
% F=10*exp(-t3);
% yyaxis left %左侧绘制打开概率
t_t=0:0.001:tt(1)+tt(2);
figure(2)
plot(t_t,Pp(4,:)) %此时x轴为线性，y轴为对数坐标
hold on
t_1=(find(Pp(4,:)==max(Pp(4,:)))-1)*0.001
max1=max(Pp(4,:))
% A=Pp(4,:);
% save('k_0_5_c10.mat','A')