clc
clear all
close all


%-----------------Set variables----------------
w = 0.005;
N = 1000;
Vo = 1;
L = 1; 
C = 1; 
Zl = 5*sqrt(L/C);
t = (2*pi/w)/4

%--------------Calculate other variables------------

f = w/(2*pi);
wc = 3*(sqrt(L*C));
B = w*sqrt(L*C);
vp = w/B;
lamb = vp/f;

%--------------Setup vectors---------------------
x = linspace(0,N,N);
Iz = zeros(1,N);
Vz = zeros(1,N);
p = zeros(1,N);


%-----------------Call for k values --------------
[Zk,Vk,Ik]= Final_function(w,L,C,N,Zl,Vo);

%---------------------Calculate Vk(t) and Ik(t) and Zk(t)--------------------
Vkt= real(Vk.*exp(1i*w*t));
Ikt= real(Ik.*exp(1i*w*t));
Zkt = (Vk.*exp(1i*w*t))./(Ik.*exp(1i*w*t));
%---------------------Calculate exact solution--------------------

Zo = sqrt(L/C);
Vzt(1)= Vo;
Izt(1) = Vzt(1)/Zo; % I1 = Vo/Zo

p = (Zl-Zo)/(Zl+Zo);


for k= 2:N
    
 Izt(k)= real(Izt(1)*exp(1i*w*t-1i*B*x(k))*(1+p))-1i*w*C*Vzt(k-1);
 Vzt(k)= real(Vzt(1)*exp(1i*w*t-1i*B*x(k))*(1+p))-1i*w*L*Izt(k);
 
end



Zzt = Vzt./Izt;

Nth = 1:N;


figure(1)
subplot(3,1,1)
plot(Nth, Vk,'LineWidth',3)
hold on
plot(Nth,Vkt,'--r','LineWidth',2)
plot(Nth,Vzt,'--g','LineWidth',1)
title('V')
legend('Vk','Vk(t)','Vz(t)')
ylabel('Volts')
xlabel('N')

subplot(3,1,2)
plot(Nth, Ik,'LineWidth',3)
hold on
plot(Nth,Ikt,'--','LineWidth',2)
plot(Nth,Izt,'--g','LineWidth',1)
title('I')
legend('Ik', 'Ik(t)','Iz(t)')
ylabel('Amps')
xlabel('N')

subplot(3,1,3)
plot(Nth,Zk(1:end-1),'LineWidth',3)
hold on
plot(Nth,Zkt,'--','LineWidth',2)
plot(Nth,Zzt,'--g','LineWidth',1)
title('Z')
legend('Zk', 'Vk(t)/Ik(t)','Vz(t)/Iz(t)')
axis([0 N min(real(Zk))-1 max(real(Zk))+1])
ylabel('Ohms')
xlabel('N')

dim = [0.35 0.7 .3 .3];
str = 'w = 0.005, ZL = sqrt(L/C), t = (2*pi/w)/4';%(2*pi/w)/4
annotation('textbox',dim,'String',str,'FitBoxToText','on');
hold off
print('Final_part_II_Figure_8','-dpdf','-fillpage') 
