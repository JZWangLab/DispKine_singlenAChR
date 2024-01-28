function [ P_INT ] = ndwl(K_2,K_1,alpha,beta,P_int1,t,t0)
A=[0,K_1,0,0
    0,-K_1,K_2,0
    0,0,-(K_2+beta),alpha
    0,0,beta,-alpha];
[P,LAMDA]=eig(A);
lamda1=0;lamda2=LAMDA(2,2);lamda3=LAMDA(3,3);lamda4=LAMDA(4,4);
% lamda1=0;lamda2=-K_1;
% lamda3=(-K_2-beta-alpha+sqrt((K_2+beta+alpha)^2-4*alpha*K_2))/2;
% lamda4=(-K_2-beta-alpha-sqrt((K_2+beta+alpha)^2-4*alpha*K_2))/2;
% P=[1, 1,K_1,                                        K_1;
%    0,-1,lamda3 ,                                   lamda4;
%    0,0, lamda3*(lamda3+K_1)/K_2,                   lamda4*(lamda4+K_1)/K_2;
%    0,0,beta*lamda3*(lamda3+K_1)/(2*(lamda3+alpha)),beta*lamda4*(lamda4+K_1)/(K_2*(lamda4+alpha))];
%P为特征向量构成矩阵
% P_int=P_int1;
% P_int=[0;0;1;0];
% C=P\P_int;
% C=inv(P)*P_int;
% Replace inv(A)*b with A\b
% Replace b*inv(A) with b/A
P_INT=zeros(4,length(t));
B=[P_int1,P_int1,P_int1,P_int1];
for i=1:length(t)
    A=[exp(lamda1*(t(i)-t0)), 0,              0,                  0;
           0,        exp(lamda2*(t(i)-t0)),   0,                  0;
           0,                0,          exp(lamda3*(t(i)-t0)),   0;
           0,                0,              0,              exp(lamda4*(t(i)-t0))];
%     P_INT(:,i)=P*A*inv(P)*B*P_int1;
P_INT(:,i)=P*A*inv(P)*P_int1;
end

end

