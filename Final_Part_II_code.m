clc
clear all
close all


%f = 1E3;
w = 0.005;
f = w/(2*pi)

Vo = 1;
L = 1; % matched impedance Z = sqrt(L/C) for Z = 50 ohm
C = 1; 
Zl = sqrt(L/C);
N = 1000;
wc = 2/(sqrt(L*C));
fc = wc/(2*pi)   %around 6Mz for this LC combination

[Zk,Vk,Ik]= Final_function(w,L,C,N,Zl,Vo);

dt = w/10;
ti = 0:w:(2*pi/w)/4;
B = w*sqrt(L*C)

It = zeros(N,length(ti));
Vt = zeros(N,length(ti));

Vt(1,:) = Vk(1)*exp(-1i*w*ti);
It(1,:) = Vk(1)/Zk(1);

for k = 2:N
    Vt(k,:) = Vt(k-1,:)*exp(-1i*B);
    It(k,:)= It(k-1,:)*exp(-1i*B);

end

Nth = 1:N;

figure(1)
subplot(3,1,1)
title('')
plot(Nth,Vt(:,1))
title('V_k For t = 0 ')
subplot(3,1,2)
plot(Nth,It(:,1))
title('I_k')
subplot(3,1,3)
plot(Nth,Zk(1:end-1),Nth,Vt(:,1)./It(:,1))
title('Z_k')
legend('Z_k','V_k/I_k')
print('Final_part_II_Figure_1','-dpdf','-fillpage') 

figure(2)
subplot(3,1,1)
title('')
plot(Nth,Vt(:,end))
title('V_k For t = (2*pi/w)/4 ')
subplot(3,1,2)
plot(Nth,It(:,end))
title('I_k')
subplot(3,1,3)
plot(Nth,Zk(1:end-1),Nth,Vt(:,end)./It(:,end))
title('Z_k')
legend('Z_k','V_k/I_k')
print('Final_part_II_Figure_2','-dpdf','-fillpage') 