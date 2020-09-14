    
function [x,y]= ode_gilgilN(d,q,th,steps)    

% Would be better to pass a sign argument to this function. This script
% is almost identical to "P" script; duplicate code should be avoided
% as it can create many problems later on.
    dt = 0.01;
    
    to = 0;
    
    qp = q;
    qn =-q; 
    
   
   
    x(1) = -d+cos(th); 
    
    y(1) = 0+sin(th);
    %ignore Z component
    

    
     eo = 8.85E-12;
     k = 1/(4*pi()*eo);
      
      

    %fprintf('t \t x \t y \n')
    for i = 1:steps
        %fprintf('%.2f\t%.2f\t%.2f\n',to(i),x(i),y(i));
       
        Ex = k*qp*(x(i)+d)/((x(i)+d)^2+y(i)^2)^(3/2)+k*qn*(x(i)-d)/((x(i)-d)^2+y(i)^2)^(3/2);
        Ey = k*qp*y(i)/((x(i)+d)^2+y(i)^2)^(3/2)+k*qn*y(i)/((x(i)-d)^2+y(i)^2)^(3/2);
        
        
        E = sqrt(Ex^2+Ey^2);
        
        x(i+1) = x(i) + Ex/E*dt;
        y(i+1) = y(i) + Ey/E*dt;
        
        to(i+1) = to(i) + dt;
    end

   