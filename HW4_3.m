
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
 P(i,j) = [dx(i), dy(j)];
 B(i,j,:) = HW4_BiotSavart(p, XYZ, I); %calculate magnetic fied at Z =2 at the center%end
end
end

figure(1)
mesh(dx,dy,B(:,:,3))
% This does not make sense. This is the field in the z=2 plane
% for x = [-1,1], y = [-1,1].
title('Magnetic field at Coil 2 ')
xlabel('x')
ylabel('y')
zlabel('Magnetic Field)')
legend('Bz')

 

 % Should state what you are doing here. To get mean Bz, use
 % Bz = B(:,:,3);
 % Bzm = mean(Bz(:));
 
 Bmz = sum(B(:,:,3))/length(dx); 
 Bm = sum(Bmz)/length(dy)% magnetic field mean

 Area = pi*radius^2;

 % It appears that you have computed the average Bz
 % in a square loop and then multiplied this by the area of a circle.
 
 if 0
     % To use your method, you could have done
     P = P(:); % Flatten position array.
     Bz = Bz(:); % Flatten Bz array.
     I = find(sqrt(P(:,1).^2+P(:,2).^2) < 1); % Indices for points inside circle.
     Bzm = mean(Bz(I));
     Flux = Bzm*pi*r^2;
 end
 
 Flux = Bm*Area
   
table (p,Bm, Area,Flux)
