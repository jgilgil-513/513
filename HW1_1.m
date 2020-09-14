clc,close all,clear all 

dy=0.001; % increment in y
y1(1)=0;
N = 51; %use odd number so lines align
d = 5; %charge distance
q = 1E-5;
th = linspace(0,2*pi(),N);
steps = 20000;

% Let me know if you have questions about doing this with ODE45.

%Plot positive paricle E-field lines
for j = 1:N
    [X(:,j),Y(:,j)] = ode_gilgilP(d,q,th(j),steps);
end

figure(1)
plot(X,Y);
hold on;

%Plot negative particle E-field lines like if it was a positive charge
for j = 1:N

    [x,y] = ode_gilgilN(d,q,th(j),steps);
   
    X(:,j) = x;
    Y(:,j) = y;
end

plot(X,Y);
%axis([-N N -N N])
axis square
xlabel('x')
ylabel('y')
title('Homework1.1','Interpreter','Latex');
