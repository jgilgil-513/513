clc,clear all, close all

eo = 8.85E-12;
k = 1/(4*pi()*eo);
q = 1E-9;
L = 1;
z = L;

% From "Introduction to electrodynamics" David J. Griffiths, 3rd edition
Eye = k*2*q*L/(z*sqrt(z^2+L^2));

M = 100;
Nq = linspace(1,M,M);
for j=1:M
   
    dx(j) = L/Nq(j);
    N = L/dx(j);
    x = linspace(0,L,N+1);
    Eya = 0;

    for i = 1:N
       Ey = 2*k*q*dx(j)*z/((z^2+x(i+1)^2)^(3/2));
       Eya= Ey+Eya; 
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
% Great use of table(). I often forget about this handy function.
T = table(N_Charges,dx,Error)
loglog(N_Charges,Error,'.') 
% More conventional way of plotting - want to know
% error versus N_charges. Loglog b/c of rapid decrease.
grid on;
xlabel('N')
ylabel('Error')
title('Homework1.2','Interpreter','Latex');

print -dpdf HW1_2.pdf