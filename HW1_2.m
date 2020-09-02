clc,clear all, close all

eo = 8.85E-12;
k = 1/(4*pi()*eo)
q = 1E-9;
L = 1;
z = L;
Eye = k*2*q*L/(z*sqrt(z^2+L^2)) %"Introduction to electrodynamic," David J. Griffiths, 3rd eddition

M = 100;
Nq = linspace(1,M,M);
for j=1:M
    
dx(j) = L/Nq(j);
N = L/dx(j);
x = linspace(0,L,N+1);
Eya = 0;

 for i = 1:N
        
    
       Ey = 2*k*q*dx(j)*z/((z^2+x(i+1)^2)^(3/2));
      
       Eya= Ey+Eya ; 
        
 end
 
 N_Charges(j) = j;
 Error(j) = abs((Eye-Eya)/Eye);

if Error(j)<=0.01
    break;
end
end

N_Charges = N_Charges';
dx = dx';
Error = Error';
T = table(N_Charges,dx,Error)


plot(dx,Error)
xlabel('dx')
ylabel('Eerror')
title('Homework1.2','Interpreter','Latex');