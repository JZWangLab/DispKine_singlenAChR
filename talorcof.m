function [ w] = talorcof(y,m,a)
syms x;
% m=5;%展开项数
% a=1;%展开点
% y=exp(-x);
f=taylor(y,x,m+1,a);
  
w=sym(zeros(m+1,1));
w(1)=subs(f,x-a,0);
f=f-w(1);
for n=m:-1:2
    w(n+1)=subs(f-subs(f,(x-a)^n,0),(x-a)^n,1);
    f=f-w(n+1)*(x-a)^n;
end
w(2)=subs(f,x-a,1);
w=double(w);



end

