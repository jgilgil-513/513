
function [Zk,Vk,Ik]= Final_function(w,L,C,N,Zl,Vo)


Z = zeros(1,N);
Zk = zeros(1,N+1);
Ik = zeros(1,N);
Vk = zeros(1,N);

Z(N) = Zl;

for k = 1:N-1
         
        
        Z(N-k) = ((Z(N+1-k)+1i*w*L)*1/(1i*w*C))/(Z(N+1-k)+1i*w*L +1/(1i*w*C) );
        
    
end

Zk(2:N+1) = Z;
Zk(1) = Zk(2)+1i*w*L; %This is Z0

Vk(1) = Vo; %This is V0

for k = 2:N
    
 if k == 2
     Ik(k) = Vk(k-1)/Zk(k-1);
     Ik(k-1) = Ik(k);
     Vk(k)= Vk(k-1)-1i*w*L*Ik(k);
 end
 
 Ik(k)= Ik(k-1)-1i*w*C*Vk(k-1);
 Vk(k)= Vk(k-1)-1i*w*L*Ik(k);

end



