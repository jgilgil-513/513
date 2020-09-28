clc, clear all, close all

I = 1; % Current

mu = 4*pi()*10^(-7); %added here for comparison 
radius=1;            %added here for comparison   

p = [0, 0, 0];

N=0;

%Create poligons multiple of 4

for j=1:60
    
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
    B3(j,:) = mu*I/2*radius^2/(radius^2)^(3/2); %Calcule magnetic field for a circle 
    p(j,:) = p;
    Sides(j,:) = N;
    Sol_Error(j,:)= abs((B1(j,3)-B3(j,:))/B3(j,:)); %calculate solution error 

end

% Great that you checked both options for computing B (end and middle).
% In limit that number of segments -> infinity, won't matter.
figure(1)
semilogx(Sides,B1(:,3),'*-r',Sides,B2,'o-g',Sides,B3,'+-b')
title('Biot-Savart - Magnetic Field of a closed loop at z = 0')
xlabel('Polygon Sides')
ylabel('Magnetic Filed)')
legend('Solution','N-Polygon','Circle')

Solution = B1;
NPoligon = B2;
Circle = B3;

table(Sides,p,Solution,NPoligon,Circle,Sol_Error) %print table
