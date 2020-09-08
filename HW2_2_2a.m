clc, clear all, close all

Vl = 80;
Vb = 60;
Vt = 100;
Vr = 20;	


Nn = 40;
Ex = 1;
Ey = 1;

Px = linspace(0,Ex,Nn);
Py = linspace(0,Ey,Nn);
Pn = [Ex,Ey];
Fi=zeros(Nn);

for i = 1:length(Px)
for j = 1:length(Py)

P = [Px(i),Py(j)];

Fi(i,j) = F(P,Pn,Vl,Vb,Vt,Vr);

end
end

[X,Y] = meshgrid(Px,Py);

figure(1)
surf(X,Y,Fi)
