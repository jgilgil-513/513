clc
clear all
close all

Nx = 550;
x = [1:Nx];
lambda = 100;
x1 = linspace(Nx,1,Nx);
figure(1);clf
for i = 1:1500
    Ep = cos(2*pi*(x-i)/lambda);
    if i>Nx
    En = 0.5*cos(2*pi*(x1-i)/lambda);
    E= Ep+En;
    end
   
    % Set values to right of wave front to NaN so they won't be plotted.
    Ep(i+1:end) = NaN;
     if i>Nx
    En(1:end-(i-Nx)) = NaN;
    E(1:end-(i-Nx)) = NaN;
     end
   
    % Plot current time step as light grey.
    plot(Ep,'k','LineWidth',1,'Color',[1,1,1,0.4]/2);
    % Keep past time steps
    hold on;
     if i>Nx
    plot(En,'r','LineWidth',1,'Color',[2,1,1,0.4]/2);
    hold on
    plot(E,'b','LineWidth',1,'Color',[1,1,2,0.4]/2);
     end
    
    grid on;
    if i > 1
        % Delete previous current time step thick black line
        delete(hp)
         if i>Nx+1
        delete(hn)
        delete(h)
        
         end
      
    end
    % Plot current time step as thick black line
    hp = plot(Ep,'k','LineWidth',2);
      if i>Nx
    hn = plot(En,'r','LineWidth',2);
    h = plot(E,'b','LineWidth',2);
   
      end
    
    set(gca,'Ylim',[-2,2]);
    set(gca,'Xlim',[1,Nx]);
    %legend('V^{+}');
    % Uncomment the following to hide past time steps
    %hold off;
%     if mod(i,100) == 0
%         % Allow early termination of animation
%         input('Continue?');
%     end
    drawnow;
end

ylabel('V')
xlabel('i_x')
title('Propagating Waves at i_x = 300')