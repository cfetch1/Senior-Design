function [W_fuse] = fuselage_nikolai(MTOW, VeqMax,fuse_width, fuse_diam, Ltot )
    %dimensions are all going to be in feet
    %Ltot= total length of the fuselage    
    N=1.5;   
    W_fuse=200*((((MTOW*N)/10^5)^.286)*((Ltot/10)^.857)*((fuse_width+fuse_diam)/10)*((VeqMax/100)^.338))^1.1;  
end

