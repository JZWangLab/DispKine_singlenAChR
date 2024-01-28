%ACh浓度周期变化
%第一个周期
%先0.1秒线性上升到10uM（100t）,此时的初始概率为（1，0，0，0）
clear;clc;
achc=500;
tt=[0.1,20,0.1];
a=[68,117,123]/255;
PP=zeros(4,5);
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
hold on
initial_p2=P_int1(:,length(t));
b=tt(2)/0.2;
% P_M=zeros(1,b);P_m=zeros(1,b);
% P_M1=zeros(4,1);
% P_M2=zeros(4,1);

for j=1:b
    
   d = 200; %泰勒展开式设定为200项
    ac=-achc/tt(2);t2=0.2;
    k2 = zeros(1,d); k2(1) = achc+(j-1)*ac*t2; 
    %k2 = zeros(1,d); k2(1) = achc;
    k2(2)=ac;
    % k2(2)=ac;
    k1=0.06*k2;
    k2=0.1*k2;
    % k1=2*k2;
    t3=0:0.001:t2;
    P_p00=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[1;0;0;0],d,t2);
    P_p11=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[0;1;0;0],d,t2);
    P_p22=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[0;0;1;0],d,t2);
    P_p33=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[0;0;0;1],d,t2);
    P_int2=P_p00*initial_p2(1)+P_p11*initial_p2(2)+P_p22*initial_p2(3)+P_p33*initial_p2(4);
    P_int2=bsxfun(@times,P_int2,1./sum(P_int2)); 
    Pp=[Pp,P_int2(:,2:length(t3))];
    initial_p2=P_int2(:,length(t3));
%     plot(t3(2:length(t3))+t1+0.2*(j-1),P_int2(4,2:length(t3)),'color',a)
%     P_M(1,j)=max(P_int2(4,:));
    
end
t_1=(find(Pp(4,:)==max(Pp(4,:)))-1)*0.001
max1=max(Pp(4,:))
% max(P_M)
%第三段浓度为0，并保持0.4ms
t4=tt(3);t0=0; %此时浓度直接为零
t5=t0:0.001:t4;
% P_int1=P_int2(:,length(t3));
initial_p3=P_int2(:,length(t3));
P_00=ndwl(K_2,K_1,alpha,beta,[1;0;0;0],t5,t0);
P_11=ndwl(K_2,K_1,alpha,beta,[0;1;0;0],t5,t0);
P_22=ndwl(K_2,K_1,alpha,beta,[0;0;1;0],t5,t0);
P_33=ndwl(K_2,K_1,alpha,beta,[0;0;0;1],t5,t0);
P_int3=P_00*initial_p3(1)+P_11*initial_p3(2)+P_22*initial_p3(3)+P_33*initial_p3(4);
P_int3=bsxfun(@times,P_int3,1./sum(P_int3));
t_t1=0:0.001:20;
t_t2=0:0.001:tt(1)+tt(2);
Pp=[Pp,P_int3(:,2:length(t5))];
% plot(t5(2:length(t5))+tt(1)+tt(2),P_int3(4,2:length(t5)),'color',a)
plot(t_t1,Pp(4,:),'color',a)
plot(t_t2(length(t_t2)),Pp(4,length(t_t2)),'*','color','r')

% for i = 1:1
% initial_p1=P_int3(:,length(t5));
% P_int1=P_0*initial_p1(1)+P_1*initial_p1(2)+P_2*initial_p1(3)+P_3*initial_p1(4);
% P_int1=bsxfun(@times,P_int1,1./sum(P_int1));
% P_M2=P_int1;
% plot(t+(tt(1)+tt(2)+tt(3))*i,P_int1(4,:),'g')
% 
% initial_p2=P_int1(:,length(t));
% for j=1:b
%    d = 200; %泰勒展开式设定为200项
%     ac=-achc/tt(2);t2=0.2;
%     k2 = zeros(1,d); k2(1) = achc+(j-1)*ac*t2; 
%     %k2 = zeros(1,d); k2(1) = achc;
%     k2(2)=ac;
%     % k2(2)=ac;
%     k1=0.06*k2;
%     k2=0.1*k2;
%     % k1=2*k2;
%     t3=0:0.001:t2;
%     P_p00=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[1;0;0;0],d,t2);
%     P_p11=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[0;1;0;0],d,t2);
%     P_p22=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[0;0;1;0],d,t2);
%     P_p33=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[0;0;0;1],d,t2);
%     P_int2=P_p00*initial_p2(1)+P_p11*initial_p2(2)+P_p22*initial_p2(3)+P_p33*initial_p2(4);
%     P_int2=bsxfun(@times,P_int2,1./sum(P_int2)); 
%     initial_p2=P_int2(:,length(t3));
%     plot(t3(2:length(t3))+t1+0.2*(j-1)+(tt(1)+tt(2)+tt(3))*i,P_int2(4,2:length(t3)),'g')
%     P_M2=[P_M2,P_int2(:,2:length(t3))];
% %     P_m(1,j)=max(P_int2(4,:));
%     
% end
% % max(P_m)
% initial_p3=P_int2(:,length(t3));
% P_int3=P_00*initial_p3(1)+P_11*initial_p3(2)+P_22*initial_p3(3)+P_33*initial_p3(4);
% P_int3=bsxfun(@times,P_int3,1./sum(P_int3));
% plot(t5(2:length(t5))+tt(1)+tt(2)+(tt(1)+tt(2)+tt(3))*i,P_int3(4,2:length(t5)),'g')
% 
% end
% t_2=(find(P_M2(4,:)==max(P_M2(4,:)))-1)*0.001+20;
% max2=max(P_M2(4,:));
