function B=HW4_BiotSavart(p,XYZ,I)


mu = 4*pi()*10^(-7);

%unit vectors
xi = [1 0 0];
yi = [0 1 0];
zi = [0 0 1];
for i=1:length(XYZ)

    x = XYZ(i,1);
    y = XYZ(i,2);
    z = XYZ(i,3);
   
    px = p(1);
    py = p(2);
    pz = p(3);

    r(i,:) = (px-x)*xi + (py-y)*yi + (pz-z)*zi;     
    
     %close the loop of wires
    if i == length(XYZ)
        dL(i,:) = XYZ(1,:)-XYZ(i,:);
    else
        dL(i,:) = XYZ(i+1,:)-XYZ(i,:);
    end
    
    %get the magnitud of r
    rm(i) = norm(r(i,:));
        
    Bi(i,:)= mu*I/(4*pi())*cross(dL(i,:),r(i,:))/rm(i)^(3);
    

end
 B = sum(Bi,1);

end
