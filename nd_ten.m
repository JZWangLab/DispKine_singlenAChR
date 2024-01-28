function [ P_int ] = nd_ten(k1,k2,K_2,K_1,alpha,beta,initial_p2,t,t0)
% k1=0.6; k2=1;
% k1=6;k2=10;
% b=k1+K_1+k2+K_2+alpha+beta; c=(k1+k2+K_1)*(K_2+alpha+beta)+alpha*K_2;
% d=k1*k2*alpha+k1*k2*beta+K_1*K_2*alpha+k1*K_2*alpha;
A=[-k1,K_1,0,0
    k1,-(K_1+k2),K_2,0
    0,k2,-(K_2+beta),alpha
    0,0,beta,-alpha];
[P,LAMDA]=eig(A);
lamda1=LAMDA(1,1);lamda2=LAMDA(2,2);lamda3=LAMDA(3,3);lamda4=LAMDA(4,4);

P_int=zeros(4,length(t));
P_int(:,1)=initial_p2;
% B=zeros(4,4);
% B(1,1)=1;
for i=2:length(t)
    A=[exp(lamda1*(t(i)-t0)), 0,              0,                  0;
           0,        exp(lamda2*(t(i)-t0)),   0,                  0;
           0,                0,          exp(lamda3*(t(i)-t0)),   0;
           0,                0,              0,              exp(lamda4*(t(i)-t0))];
% %     P_int(:,i)=P*A*inv(P)*B*initial_p2;
   P_int(:,i)=P*A*inv(P)*initial_p2;
   
end
end
