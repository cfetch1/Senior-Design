function [W_fuel_sys] = weight_fuel_system(Wfuel)
%This is an estimate from Gundlach
%Variables
%Ffs=multiplication factor 
    %FOr tactial UAS .05-.1
Ffs=.05;
%E1 is an exponenet
E1=1;

W_fuel_sys=Ffs*Wfuel^E1;
end

