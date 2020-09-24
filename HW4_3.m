
clc, clear all, close all

I = 1;
radius=1; 

N = 1000; %aproximate coil 1 using a poligon of 1000 sides
theta=linspace(0,2*pi(),N+1);


for i = 1: length(theta)-1
    x=radius*cos(theta(i));
    y=radius*sin(theta(i));
    z = 0;
    XYZ(i,:)=[x,y,z];
    
end

dx = linspace(-1,1,100);
dy = linspace(-1,1,100);

for i = 1:length(dx)
for j = 1:length(dy)
 p = [dx(i), dy(j), 2];
 B(i,j,:) = HW4_BiotSavart(p, XYZ, I); %calculate magnetic fied at Z =2 at the center%end
end
end

figure(1)
mesh(dx,dy,B(:,:,3))
title('Magnetic flux at Coil 2 ')
xlabel('x')
ylabel('y')
zlabel('Magnetic Filed)')
legend('Bz')

 
 
 Bmz = sum(B(:,:,3))/length(dx); 
 Bm = sum(Bmz)/length(dy)% magnetic field mean

 Area = pi*radius^2;

 

 Flux = Bm*Area
   
table (p,Bm, Area,Flux)
