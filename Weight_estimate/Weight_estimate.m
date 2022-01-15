clc
clear
close all

%Weigth estimate code
%The idea is that this will take all the inputs from other engine stuff and
%with the estimate MTOW, will determine the actual MTOW by iterating until
%the numbers converge within a certain tolerance.

%This will be the initial guess 
MTOW_in1=(436); %[lb]
MTOW_in2=MTOW_in1*5;
MTOW_in=[MTOW_in1,MTOW_in2];
%Variables
%Control surface planform area 
Scs=4; %[ft^2]
%wingspan
b=24.08; %[ft]
%Max veloicty in KEAS
VeqMax=162.06; %[KEAS]
%Max payload power
p_pay=320; %[Watts]
%lengyth of the fuselage
Ltot=12.04; %[ft^2]
%payload weight
Wpay=33; %[lb]
%Engine weight
Wengine=50; %[lb]
%Number of props
Nprop=1;
%Propeller diameter
D=3; %[ft]
%Number of blades
N_blades=4;
%Max shaft horsepower
P_max=100;
%Fuel weigyht
Wfuel=56; %[lb]
%Wing area
S=38.67; %[ft^2]
%Aspect Ratio
AR=16;
%Corss sectional circumference
pmax=4.34; %[ft^2]
%Number of pax, this will be estimated
Npax=.9;
%Horizontal Tail area
S_h=5.95; %[ft^2]
%Horizontal tair AR
A_h=sqrt(6.26)/S_h;
% t_rh = horizontal tail maximum root thickness in ft
t_rh=2/12;
% S_v = vertical tail area in ft^2
S_v=5.95; %[ft^2]
% A_v = vertical tail aspect ratio
A_v=A_h;
% t_rv = vertical tail maximum root thickness in ft
t_rv=2/12;
% sw_a = vertical tail quarter cord sweep angle
sw_a=1;
% = shock strut length for main gear
L_sm=1.5; %[ft]
%L_sn = shock strut length for nose gear
L_sn=1.25; %[ft]
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


    



