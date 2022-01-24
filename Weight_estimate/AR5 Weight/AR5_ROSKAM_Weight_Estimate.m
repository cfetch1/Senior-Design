clc
clear
close all
% EXCLUSIVELY FOR AR5!!!

%Weight estimate code
%The idea is that this will take all the inputs from other engine stuff and
%with the estimate MTOW, will determine the actual MTOW by iterating until
%the numbers converge within a certain tolerance.

%This will be the initial guess 
MTOW_in1=(396.8); %[lb]
MTOW_in2=MTOW_in1*5;
MTOW_in=[MTOW_in1,MTOW_in2];
%Variables
%Control surface planform area 
Scs=5.5; %[ft^2]
%wingspan
b=23.9513; %[ft]
%Max velocity in KEAS
VeqMax=53.9957; %[KEAS]
%Max payload power
p_pay=300; %[Watts]
%length of the fuselage (using total length of aircraft here)
Ltot=12.8; %[ft^2]
%payload weight
Wpay=110; %[lb]
%Engine weight
Wengine=79.36; %[lb]
%Number of props
Nprop=2;
%Propeller diameter
D=3; %[ft]
%Number of blades (per propeller?)
N_blades=4;
%Max shaft horsepower (60hp per engine, 120 total)
P_max=120;
%Fuel weight
Wfuel=119.04; %[lb]
%Wing area
S=35.95; %[ft^2]
%Aspect Ratio
AR=16.35;
%Cross sectional circumference of fuselage
pmax=5.77; %[ft^2]
%Number of pax, this will be estimated (our aircraft was 0.9)
Npax=.8;
%Horizontal Tail area
S_h=0.6511; %[ft^2]
%Horizontal tail AR
A_h= 5.12;
% t_rh = horizontal tail maximum root thickness in ft
t_rh=3/12;
% S_v = vertical tail area in ft^2
S_v=0.3469; %[ft^2]
% A_v = vertical tail aspect ratio
A_v=1.46;
% t_rv = vertical tail maximum root thickness in ft
t_rv=3/12;
% sw_a = vertical tail quarter cord sweep angle
sw_a=1;
% = shock strut length for main gear
L_sm=0.945; %[ft]
%L_sn = shock strut length for nose gear
L_sn=; %[ft]
%Secant method, two initial guesses, xo and x1 are the two inital MTWO
%inputs
eps=5; 
err=abs(MTOW_in(2)-MTOW_in(1));

for i=1:length(MTOW_in)
    [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, Ltot);
    [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
    [w_prop(i)] = weight_prop(Nprop,D,N_blades,P_max);
    [W_fuel_sys(i)] = weight_fuel_system(Wfuel);
    [W_struct_roskam(i)] = roskam_weights(MTOW_in(i), S, AR, Ltot, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wfuel, L_sm, L_sn);    
    MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wfuel+W_struct_roskam(i);
    Diff(i)=MTOW_calc(i)-MTOW_in(i);
    if i == 2
        MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
        err(i)=abs(MTOW_in(i+1)-MTOW_in(i));
    end
end

while err(i)>eps
    i=i+1;
    [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, Ltot);
    [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
    [w_prop(i)] = weight_prop(Nprop,D,N_blades,P_max);
    [W_fuel_sys(i)] = weight_fuel_system(Wfuel);
    [W_struct_roskam(i)] = roskam_weights(MTOW_in(i), S, AR, Ltot, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wfuel, L_sm, L_sn);
    MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wfuel+W_struct_roskam(i);
    Diff(i)=MTOW_calc(i)-MTOW_in(i);
    MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
    err(i)=abs(MTOW_in(i+1)-MTOW_in(i));  
end
disp(MTOW_in(end));


    



