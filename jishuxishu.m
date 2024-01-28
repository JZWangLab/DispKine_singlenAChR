function [ P ] = jishuxishu(k1,k2,K_2,K_1,alpha,t,beta,cstj ,d,~)
H = zeros(4,d);

H(:,1)=cstj;
% H(:,1)=[1;0;0;0];
xs1 = [-k1(1)    K_1          0      0
        k1(1) -(K_1+k2(1))    K_2    0
           0    k2(1)  -(K_2+beta)  alpha
           0     0        beta       -alpha ];
    
H(:,2) = xs1*H(:,1); %¼ÆËãH10,H11,H12,H13 
P=H(:,1).*t.^(0)+H(:,2).*t;
for i=3:d
    b=i-2;
    xs2=[-k1(i-b)   0      0  0
         k1(i-b)  -k2(i-b) 0  0
          0        k2(i-b) 0  0
          0         0      0 0 ];
    
    
    H(:,i)=xs1*H(:,i-1)+xs2*H(:,b);
    c=b-1;
    if b>1
        for j=1:c
            xs3=[-k1(i-j)     0     0  0
                 k1(i-j)  -k2(i-j)  0  0 
                 0          k2(i-j) 0  0
                 0           0      0  0];
            
            H(:,i)=H(:,i)+xs3*H(:,j);
        end
        
    end
    H(:,i)=H(:,i)./(i-1);
    P=P+H(:,i)*t.^(i-1);
end


end

