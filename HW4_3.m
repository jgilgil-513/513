
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



 pc = [0, 0, 2];
 Bc = HW4_BiotSavart(pc, XYZ, I); %calculate magnetic fied at Z =2 at the center

 pe = [1, 1, 2];
 Be = HW4_BiotSavart(pe, XYZ, I); %calculate magnetic fied at Z =2 at the edge
 
 Bm = (Bc+Be)/2; % magnetic field mean
 
 Area = pi*radius^2;

 % Magnetic flux at Coil 2 using the mean magnetic field as constant
 % through the area
 

 Flux = Bm*Area;
   
table (pc,Bc,pe,Be,Bm, Area,Flux)
