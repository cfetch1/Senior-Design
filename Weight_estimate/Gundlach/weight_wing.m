function [W_wing] = weight_wing(MTOW_in,AR,Sw,k,t_c_root)
%Variables
%Nz is the load factor [g]
%Wto=maxtimum take off weight in kg
%AR is the aspect ratio
%Sw is the wing plandorm area in m^2
%k=taper ratio
%t_c_root=wing root thickness to chord ratio

%need to convert MTOW from lb to kg
MTOW=MTOW_in/2.205; %[kg]
Nz=1.5;
W_wing=.0038*(Nz*MTOW)^1.06*AR^.38*Sw^.25*(1+k)^.21*(t_c_root)^-.14; %[kg]
W_wing=W_wing*2.205;
end

