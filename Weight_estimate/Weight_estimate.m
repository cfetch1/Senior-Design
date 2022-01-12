clc
clear
close all

%Weigth estimate code
%The idea is that this will take all the inputs from other engine stuff and
%with the estimate MTOW, will determine the actual MTOW by iterating until
%the numbers converge within a certain tolerance.
%Variables
Wpay=50; %[lb]
b=24.08;%[ft] %wingspan
VeqMax=162.06; %[KEAS] max airspeed
p_pay=320; %[Watts]
Ltot=12.04; %[ft]
Wengine= 50; %[lb]
%number of propellers
Nprop=1;
%number of blades
N_blades=3;
%total maximum shaft horsepower of all the engines
P_max=100;
%propeller diamter
D=2;
%Fuel weight
Wfuel=58; %[lbs]
%empennage planform area
Semp=11.9; %ft^2
%minium gauge thickness [in] (1.5 mm)
tmin=.0590551;
%material density
rho_mat= 83;  %[lb/ft^3]
AR=16;
%wing plaform area [ m^2]
Sw=3.59; %[m^2]
%taper ratio
k=.5;
%wing root thickness to chord ratio
t_c_root=12; %[%]

Scs=2;
% %exposed skin area
% S_exp=
% %weight per exposed area of the minumum gauge structure
% Fskins=


%This will be the initial guess 
MTOW_in=(436); %[lb]
MTOW_in(2)=MTOW_in*1.5;
MTOW_in(2)=20000;
for i =1:length(MTOW_in)
    [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, Ltot);
    [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
    [w_prop(i)] = weight_prop(Nprop,D,N_blades,P_max);
    [W_fuse(i)] = weight_fuselage(W_feq(i),VeqMax,Ltot);
    [W_fuel_sys(i)] = weight_fuel_system(Wfuel);
    [W_emp(i)] = weight_empen(Semp,tmin,rho_mat);
    [W_lg(i)] = weight_LG(MTOW_in(i));
    [W_wing(i)] = weight_wing(MTOW_in(i),AR,Sw,k,t_c_root);
%     [W_struct(i)] = weight_struct(S_exp,Fskins);
    %Still need the wing and empennage weight
    MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+W_fuse(i)+w_prop(i)+W_fuel_sys(i)+W_emp(i)+W_lg(i)+W_wing(i);
    MTOW_calc(i)=(MTOW_calc(i))/(1-(.25+.05+.05+.52));
    Diff(i)=MTOW_calc(i)-MTOW_in(i);
    
end
MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
tol=5;
i=3;
while (Diff(i-1) > tol)
    MTOW_in(i+1)=MTOW_in(2);
    [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, Ltot);
    [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
    [w_prop(i)] = weight_prop(Nprop,D,N_blades,P_max);
    [W_fuse(i)] = weight_fuselage(W_feq(i),VeqMax,Ltot);
    [W_fuel_sys(i)] = weight_fuel_system(Wfuel);
    [W_emp(i)] = weight_empen(Semp,tmin,rho_mat);
    [W_lg(i)] = weight_LG(MTOW_in(i));
    [W_wing(i)] = weight_wing(MTOW_in(i),AR,Sw,k,t_c_root);
%     [W_struct(i)] = weight_struct(S_exp,Fskins);
    %Still need the wing and empennage weight
%     MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+W_fuse(i)+W_prop(i)+W_fuel_sys(i)+W_emp(i)+W_lg(i)+W_wing(i)+W_Struct(i);
    MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+W_fuse(i)+w_prop(i)+W_fuel_sys(i)+W_emp(i)+W_lg(i)+W_wing(i);

    Diff(i)=MTOW_calc(i)-MTOW_in(i);
    MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
end