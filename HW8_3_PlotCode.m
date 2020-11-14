
clc
close all 
clear all


sig = 0

L = 5; %domain length in meters
N = 500; %# spatial samples in domain

fs = 300e6; %source frequency in Hz
ds = L/N; %spatial step in meters
dt = ds/300e6; %"magic time step"
eps0 = 8.854e-12; %permittivity of free space
mu0 = pi*4e-7; %permeability of free space

w = 2*pi*fs;
c = sqrt(1/eps0/mu0);
B= w/c;
lamb = c/fs;
p = 1/2;
Phip = 2*B*(0.333*lamb)-pi;

x1 = linspace(0,N,N);

Ep = 1;



l = (N/2-20)/2 %space length to conductor with offset to match E+


Nth = 100 %phase points
th = linspace(-pi,pi,Nth);

Epz = zeros(Nth,N);
Esw = zeros(Nth,N);
E = zeros(Nth,N);


for j = 1:Nth 
for i = 1:N
         
    Epz(j,i) = Ep*(p-1)*cos(w*dt*i+B*l+th(j));
    Esw(j,i) = Ep*2*cos(w*dt*i)*cos(B*l+th(j));
    E(j,i) = Epz(j,i)+Esw(j,i);

end
end

HW8_3_function()% call function to plot Ey1 and Ey2
 
r1 = 1:250;
d = 24;
r2 = 1+d:250+d; %shift to match Ey1

figure(2)
plot(x1(r1),E(:,r2),'g',x1(r1),Esw(:,r2),'r');
legend('E_y_1 [V/m]','E_y_2 [V/m]','Conductor','Traveling Wave [V/m]') 

 
