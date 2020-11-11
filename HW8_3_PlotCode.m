
clc
close all 
clear all


sig = 0

L = 5; %domain length in meters
N = 500; %# spatial samples in domain

fs = 300e6; %source frequency in Hz
ds = L/N; %spatial step in meters
dt = ds/300e6; %"magic time step"
eps0 = 8.854e-12; %permittivity of free space
mu0 = pi*4e-7; %permeability of free space
 %x coordinate of spatial samples
w = 2*pi*fs;
c = sqrt(1/eps0/mu0);
k = w/c;
B= w/c;
lamb = c/fs;
Phip = 2*B*(0.275*lamb)-pi;
S=3;

x = linspace(-N/2,N/2,N);
x1 = linspace(-N/2,N/2,N);
x2 = linspace(N/2,-N/2,N);
HW8_3_function()
Ep = 1;
En = 0.5;
Epz = zeros(1,N);
Enz = zeros(1,N);
E = zeros(1,N);

t = zeros(1,N);
l = (N/2-20) %space length to conductor with offset to match E+

for i = 1:N
    
    Epz(i) = real(Ep*exp(-1j*(B*l+pi/4))*exp(1j*w*dt*i)); %calculate Ey+
    Enz(i) = real(En*exp(1j*(B*l+Phip))*exp(1j*w*dt*i)); % caculate Ey-
    E(i) = Epz(i)+Enz(N-i+1); % calculate Ey
    t(i) = dt*i; % get the time
end

E2 = max(Epz)-max(Enz); %Amplitud of standing wave

Es1 = (E2)*sin(B*l).*cos(w*t); % "Standing wave"

r1 = 251:500;
r2 = 1:250;
 figure(2)
 plot(x1(r1),E(r1),'b',x1(r1),Epz(r1),'r',x2(r2),Enz(r2),'g',x1(r1),Es1(r1),'m')
 legend('E_y_1 [V/m]','E^+_y_1 [V/m]','E^-_y_1 [V/m]','E_y_2 [V/m]','Conductor','Calculated E_y_1 [V/m]','Calculated E^+_y_1 [V/m]','Calculated E^-_y_1 [V/m]','Standing Wave [V/m]')
