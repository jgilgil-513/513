clc,clear all,close all

Vl = 80;
Vb = 60;
Vt = 100;
Vr = 20;	



Po = [1,1];  % [xo,yo]

P1 = [1/3*Po(1),2/3*Po(2)];
P2 = [2/3*Po(1),2/3*Po(2)];
P3 = [1/3*Po(1),1/3*Po(2)];
P4 = [2/3*Po(1),1/3*Po(2)];

F1 = F(P1,Po,Vl,Vb,Vt,Vr)
F2 = F(P2,Po,Vl,Vb,Vt,Vr)
F3 = F(P3,Po,Vl,Vb,Vt,Vr)
F4 = F(P4,Po,Vl,Vb,Vt,Vr)

