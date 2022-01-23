clc
clear
close all

%Weigth estimate code
%The idea is that this will take all the inputs from other engine stuff and
%with the estimate MTOW, will determine the actual MTOW by iterating until
%the numbers converge within a certain tolerance.
%This will be the initial guess for our plane
MTOW_in1=(436); %[lb]
MTOW_in2=MTOW_in1*5;
MTOW_in=[MTOW_in1,MTOW_in2];
%Variables

Scs=4; %[ft^2]  %Control surface planform area  
b=24.08;    %wingspan %[ft]
VeqMax=162.06; %Max veloicty in [KEAS]
p_pay=320; %Max payload power [Watts]
Ltot=12.04; %lengyth of the fuselage [ft^2]
Wpay=33; %payload weight [lb]
Wengine=50; %Engine weight [lb]
Nprop=1;    %Number of props
D=30/12;    %Propeller diameter %[ft]
N_blades=2;     %Number of blades
P_max=100;  %Max shaft horsepower
Wfuel=56;   %Fuel weight %[lb]
S=38.67;    %Wing area %[ft^2]
AR=16;  %Aspect Ratio
pmax=pi*(1.5/2)^2;  %Corss sectional circumference%[ft^2]
Npax=.01;    %Number of pax, this will be estimated
S_h=5.95;   %Horizontal Tail area %[ft^2]
A_h=4.1;    %Horizontal tair AR
t_rh=3/12;  %t_rh = horizontal tail maximum root thickness in ft
S_v=5.95;   %vertical tail area in ft^2 %[ft^2]
bv=2.125;   %Span of vertical tail
fuse_width=1.5; %fuselage width %[ft}
fuse_diam=1.5; %fuselage diameter%[ft
%Span of horizontal tail
bh=5; %[ft%dustance from wing one fourth mac to tail onforth mac
lt=6.25;   %dustance from wing one fourth mac to tail onforth mac
sweep=0;    %wing quarter chord sweep
lambda=.5;  %wing taper ratio
fuse_height=2.75;%Fueselage height%Ft
V_d=VeqMax*1.25;    %max dive speed
N_bar=100;
A_v=2.15; %vertical tail aspect ratio
t_rv=2/12;  %vertical tail maximum root thickness in ft
sw_a=1;    %vertical tail quarter cord sweep angle
L_sm=18; %shock strut length for main gear[ft]
L_sn=15; %shock strut length for nose gear[ft]
v_d=VeqMax*1.25;    %mAX DIVE SPEED
t_c=.12;    %Wing thickness
L_D=14.75; %This is an estimate(14), bigger high L/d
S_f=46.44;  %Sf fuselage area
q=72.586;   %dynamic press
N_z=1.5;    %Safety factor
%TTail stuff
sweep_ht=0;
taper_ht=.8;
sweep_vt=10;
taper_vt=.7620;

eps=2; 
err=abs(MTOW_in(2)-MTOW_in(1));


for i=1:length(MTOW_in)

    [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, Ltot);
    [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
    [w_prop(i)] = weight_prop(Nprop,D,N_blades,P_max);
    [W_fuel_sys(i)] = weight_fuel_system(Wfuel);
    [W_struct_roskam(i)] = roskam_weights(MTOW_in(i), S, AR, Ltot, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wfuel, L_sm, L_sn);    
    [W_airframe(i)] = Weight_Nikolai(MTOW_in(i), Wfuel,L_sm,S_v,bv,t_rv,VeqMax,fuse_width, fuse_diam, Ltot,S_h,lt,t_rh,bh,AR, sweep, S, lambda, t_c);
    [Howe_weight(i)] = HOWE_WEIGHT_fun(MTOW_in(i),Ltot,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
    [W_aircraft(i)] = raymer_weight(S,Wfuel,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
     MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wfuel+W_aircraft(i)+Wengine;
    Diff(i)=MTOW_calc(i)-MTOW_in(i);
    if i == 2
        MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
        err(i)=abs(MTOW_in(i+1)-MTOW_in(i));
    end
end

while err(i)>eps
    i=i+1;
    if i ==3
        a=0;
    end
    [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, Ltot);
    [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
    [w_prop(i)] = weight_prop(Nprop,D,N_blades,P_max);
    [W_fuel_sys(i)] = weight_fuel_system(Wfuel);
    [W_struct_roskam(i)] = roskam_weights(MTOW_in(i), S, AR, Ltot, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wfuel, L_sm, L_sn);    
    [W_airframe(i)] = Weight_Nikolai(MTOW_in(i), Wfuel,L_sm,S_v,bv,t_rv,VeqMax,fuse_width, fuse_diam, Ltot,S_h,lt,t_rh,bh,AR, sweep, S, lambda, t_c);
    [Howe_weight(i)] = HOWE_WEIGHT_fun(MTOW_in(i),Ltot,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
    [W_aircraft(i)] = raymer_weight(S,Wfuel,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
    MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wfuel+W_aircraft(i)+Wengine
    Diff(i)=MTOW_calc(i)-MTOW_in(i);
    MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
    err(i)=abs(MTOW_in(i+1)-MTOW_in(i));  
    
end
disp(real(MTOW_calc(end)));


    



