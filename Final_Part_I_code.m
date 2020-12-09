clc
clear all
close all


f = 1E3;
w = 2*pi*f;
Zl = 50;
Vo = 1;
L = 2.5E-6; % matched impedance Z = sqrt(L/C) for Z = 50 ohm
C = 1E-9;  
N = 10000;
wc = 2/(sqrt(L*C));
fc = wc/(2*pi)   %around 6Mz for this LC combination


[Zk,Vk,Ik]= Final_function(w,L,C,N,Zl,Vo);


Nth = 1:N;

subplot(3,1,1)
plot(Nth,Vk)
title('V_k')
subplot(3,1,2)
plot(Nth,Ik)
title('I_k')
subplot(3,1,3)
plot(Nth,Zk(1:end-1),Nth,Vk./Ik)
title('Z_k')
legend('Z_k','V_k/I_k')
print('Final_part_I_plot','-dpdf','-fillpage') 