clc, clear all, close all

I = 1; % Current

mu = 4*pi()*10^(-7); %added here for comparison 
radius=1;            %added here for comparison   

p = [0, 0, 0];

N=0;

%Create poligons multiple of 4

for j=1:20
    
    N=N+4; %poligon sides 
    theta=linspace(0,2*pi(),N+1); %find points in circle 
    p = [0, 0, 0];

    for i = 1: length(theta)-1 %Calculate poligon coordinates
        x=radius*cos(theta(i));
        y=radius*sin(theta(i));
        z = 0;
        XYZ(i,:)=[x,y,z];
       
     end


    Bi = HW4_BiotSavart(p, XYZ, I); % call Biot Savart
   

    B1(j,:) = Bi;  % store the magnetic fied for this poligon
    
    
    for i = 1:length(XYZ) 
   
        Bo(i,:)= mu*I/(2*pi*radius)*sin(pi/N); %Calcule magnetic field for N-sided poligon for comparison
    
    end
      
    
    B2(j,:) = sum(Bo,1); % store the magnetic fied for this poligon
    p(j,:) = p;
    Sides(j,:) = N;

end
    
table(Sides,p,B1,B2) %print table