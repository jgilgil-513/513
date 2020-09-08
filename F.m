function Fi=F(P,Po,Vl,Vb,Vt,Vr)

syms n

N = 1:2:10; %Odd numbers

xo = Po(1);
yo = Po(2);

x = P(1);
y = P(2);

Fi = 0;

for i=1:length(N)
  
    n = N(i); %evaluate only n= odd number
    
    Fl = -4*Vl/(n*pi())*1/sinh(n*pi()*xo/yo)*sin(y/yo*n*pi())*sinh(n*pi()/yo*(x-xo));
    Fb = -4*Vb/(n*pi())*1/sinh(n*pi()*yo/xo)*sin(x/xo*n*pi())*sinh(n*pi()/xo*(y-yo));
    Ft = 4*Vt/(n*pi())*1/sinh(n*pi()*yo/xo)*sin(x/xo*n*pi())*sinh(n*pi()*y/xo);
    Fr = 4*Vr/(n*pi())*1/sinh(n*pi()*xo/yo)*sin(y/yo*n*pi())*sinh(n*pi()*x/yo);
    

    Fi = Fi + Fl + Fb + Ft + Fr;
    
end

end