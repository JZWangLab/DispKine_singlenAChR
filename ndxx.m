clc;clear;
%Ũ��Ϊ10�ﵽƽ�Ⱥ������½�Ϊ0
%��һ������ƽ�ȸ���
%Ũ�Ⱥ�Ϊ10��[Ach]=10
ac=10;t2=0.2;
d = 200; %̩��չ��ʽ�趨Ϊ200��
% K_2 = 8.15; K_1 = 16.3; alpha = 0.714; beta = 30.6;
k1=0.06*ac; k2=0.1*ac;
K_2 = 40; K_1 = 0.25; alpha = 8; beta = 45;
P_int1=[K_1*K_2*alpha;k1*K_2*alpha;k1*k2*alpha;k1*k2*beta]/(K_1*K_2*alpha+k1*K_2*alpha+k1*k2*alpha+k1*k2*beta);
%�ڶ��������½�Ach=10-lt
k1 = zeros(1,d); k1(1) = ac; 
k2 = zeros(1,d); k2(1) = ac;

k1(2)=-ac/t2;k2(2)=-ac/t2;
k1=0.06*k1;k2=0.1*k2;
t3=0:0.001:t2;
P_p0=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[1;0;0;0],d,t2);
P_p1=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[0;1;0;0],d,t2);
P_p2=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[0;0;1;0],d,t2);
P_p3=jishuxishu(k1,k2,K_2,K_1,alpha,t3,beta,[0;0;0;1],d,t2);
P_int2=P_p0*P_int1(1)+P_p1*P_int1(2)+P_p2*P_int1(3)+P_p3*P_int1(4);
P_int2=bsxfun(@times,P_int2,1./sum(P_int2));
%�����½�AchŨ��Ϊ0��
t1=2.5-t2;
t=t2:0.001:t1+t2;
P_int1=P_int2(:,length(t3));
t0=t2; %��ʱŨ��ֱ��Ϊ��
P_int=ndwl(K_2,K_1,alpha,beta,P_int1,t,t0);
t_t=[t3,t];
P_p=[P_int2,P_int];
semilogy(t_t,P_p(4,:))
% subplot(2,2,1)
% plot(t_t,P_p(1,:))
% subplot(2,2,2)
% plot(t_t,P_p(2,:))
% subplot(2,2,3)
% plot(t_t,P_p(3,:))
% subplot(2,2,4)
% plot(t_t,P_p(4,:))
% cftool(t_t,P_p(4,:))
% cftool(t3,P_int2(4,:))
% hold on;
% F=zeros(1,length(t3)+length(t));
% for i=1:length(t3)
%     F(1,i)=10-100*t3(i);
% end

