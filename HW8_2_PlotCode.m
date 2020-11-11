
% The following is a modified version of fdtd_original.m obtained from
% https://www.mathworks.com/matlabcentral/fileexchange/7459-fdtd1d-m
% The additions include the ability to extract the field at certain
% locations and to define different runs.
% To speed up the run, comment out the plotting in the loop.
% The basics of the algorithm when sigma = 0 is described in
% https://my.ece.utah.edu/~ece6340/LECTURES/lecture%2014/FDTD.pdf
% See also https://eecs.wsu.edu/~schneidj/ufdtd/ufdtd.pdf

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Scott Hudson, WSU Tri-Cities
%1D electromagnetic finite-difference time-domain (FDTD) program.
%Assumes Ey and Hz field components propagating in the x direction.
%Fields, permittivity, permeability, and conductivity
%are functions of x. Try changing the value of "profile".
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(0,'DefaultFigureWindowStyle','docked');
set(0,'DefaultAxesFontName','Times');
set(0,'DefaultAxesTitleFontWeight','normal');
set(0,'DefaultTextFontName','Times');
set(0,'DefaultTextFontSize',16);
set(0,'DefaultAxesFontSize',16);

% https://www.mathworks.com/matlabcentral/answers/338733-how-to-stop-legend-from-adding-data1-data2-when-additional-data-is-plotted
set(0,'DefaultLegendAutoUpdate','off');

%close all;
clear all;
clc

animate = 1;

eps0 = 8.854e-12; % permittivity of free space
mu0  = pi*4e-7;   % permeability of free space
run = 1;

if run == 0
    profile = 0; % eps = eps_o, mu = mu_o, sigma = 0.
    source = 2;  % Gaussian pulse at left boundary
    xg = Lx;
    Niter = 500; % # of iterations to perform
end

if run == 1
    profile = 1;
    source  = 1;
    Lx  = 5;       % Domain length in meters
    Nx  = 500;     % Spatial samples in domain
    ixb = Nx/2;     %Nx/2
    fs = 300e6;   % Source frequency in Hz
    fstr = '300 MHz';
    Niter = 500;  % Number of iterations to perform
    ip = Nx/2 - 2; % Index of probe Nx/2-2
    ylims = [-3, 3];
end

ds = Lx/Nx; % spatial step in meters
dt = ds/fs; % "magic time step"
% See https://my.ece.utah.edu/~simpson/ECE5340/Taflove%20Chpt.%202.pdf
% for definition of magic time step.

% Scale factors for E and H
ae = ones(Nx,1)*dt/(ds*eps0);
am = ones(Nx,1)*dt/(ds*mu0);
as = ones(Nx,1);

% Create grid of epsilon, mu, sigma.
[epsr,mur,sigma] = fdtd_profile(profile, Nx, ixb);

figure(1);
fdtd_profile_plot(profile, Nx, ixb);

ae = ae./epsr;
am = am./mur;
ae = ae./(1+dt*(sigma./epsr)/(2*eps0));
as = (1-dt*(sigma./epsr)/(2*eps0))./(1+dt*(sigma./epsr)/(2*eps0));

% Initialize fields to zero
Hz = zeros(Nx,1);
Hz1 = zeros(Nx,1);
Ey = zeros(Nx,1);
Ey1 = zeros(Nx,1);
Ey2 = zeros(Nx,1);

% figure(2);clf
%     set(gcf,'doublebuffer','on'); % For smoother graphics
%     grid on;
%     plot(Ey,'b','LineWidth',2);
%     hold on;
%     plot(377*Hz,'r','LineWidth',2);
%     set(gca,'YLim',ylims); 

c = sqrt(1/eps0/mu0);
fprintf('-------------------------\n')
fprintf('Nx = %d\n',Nx);
fprintf('Lx = %.1f [m]\n',Lx);
fprintf('dx = Lx/Nx = %.1e [m]\n',ds);
fprintf('fs = %.1e [Hz]\n',fs);
fprintf('dt = ds/fs = %.1e [s]\n',dt);
fprintf('i_lamda = %.1f\n',Nx*c/fs/Lx);
fprintf('lamda   = %.2e [m]\n',c/fs/Lx);
fprintf('max(sigma)*2*pi*f/epsilon_o = %.1e\n',max(sigma)*2*pi*fs/eps0);
fprintf('-------------------------\n')

ix=1:Nx; % space index

for iter=1:Niter
    % Source
    if source == 1
        Ey(2) = sin(2*pi*fs*dt*iter);
        Ey1(2) = sin(2*pi*fs*dt*iter);
    end

%     
    % The next 10 or so lines of code are where we actually integrate Maxwell's
    % equations. All the rest of the program is basically bookkeeping and plotting.
   
    Hz(1) = Hz(2); % Absorbing boundary conditions for left-propagating waves
    Hz1(1) = Hz1(2); % Absorbing boundary conditions for left-propagating waves
   
    for i=2:Nx-1 % Update H field
      Hz(i) = Hz(i)-am(i)*(Ey(i+1)-Ey(i));
      if i >= Nx/2
          Hz1(i) = Hz1(i)-am(1)*(Ey1(i+1)-Ey1(i));
      else
          Hz1(i) = Hz1(i)-am(i)*(Ey1(i+1)-Ey1(i));
      end
      
      
     end
    
    Ey(Nx) = Ey(Nx-1); % Absorbing boundary conditions for right-propagating waves
    Ey1(Nx) = Ey1(Nx-1); % Absorbing boundary conditions for right-propagating waves
    
     for i=2:Nx-1 % Update E field
      Ey(i) = as(i)*Ey(i)-ae(i)*(Hz(i)-Hz(i-1));
      if i >= Nx/2
           Ey1(i) = as(1)*Ey1(i)-ae(1)*(Hz1(i)-Hz1(i-1));
           Ey2(i) = Ey(i)-Ey1(i);
      else
          Ey1(i) = as(i)*Ey1(i)-ae(i)*(Hz1(i)-Hz1(i-1));
          Ey2(i) = Ey(i)-Ey1(i);
      end
     end
     

    
    Hz_ip(iter) = Hz(ip);
    Hz1_ip(iter) = Hz1(ip);
    
    Ey_ip(iter) = Ey(ip);
    Ey1_ip(iter) = Ey1(ip);

    if (animate || iter == Niter)
        figure(2);hold off;
            plot(ix(1:ixb),Ey(1:ixb),'b','LineWidth',2);
            hold on;
            plot(ix(1:ixb),Ey1(1:ixb),'r','LineWidth',2);     
            hold on;
            plot(ix(1:ixb),Ey2(1:ixb),'g','LineWidth',2);     
            plot(ix(ixb+1:Nx),Ey(ixb+1:Nx),'k','LineWidth',2);
            hold on;           
            grid on;
            
            title(sprintf('i_t = %03d; f = %s [Hz]; L_x = %.1f [m]',...
                iter,fstr,Lx));
            legend('E_y_1 [V/m]','E^+_y_1 [V/m]','E^-_y_1 [V/m]','E_y_2 [V/m]') % Slows down rendering
            
            ylabel('[V/m]');
            xlabel('i_x');
            fdtd1d_annotate;
            drawnow;
            %pause(0);
    end

    if iter == 1
        fprintf('i_t (Time Step) = %04d',iter);
    end
    if iter > 1
        fprintf('\b\b\b\b');
        fprintf('%04d',iter);
    end

end

