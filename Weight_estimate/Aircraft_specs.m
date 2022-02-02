%%Our plane
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
L_sm=18; %shock strut length for main gear[in]
L_sn=15; %shock strut length for nose gear[in]
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


%% MQ-1 Predator

%This will be the initial guess for a predator****
MTOW_in1=(18000); %[lb]
MTOW_in2=MTOW_in1*5;
MTOW_in=[MTOW_in1,MTOW_in2];
%Variables
%Control surface planform area 
Scs=6; %[ft^2]
%wingspan
b=48; %[ft]
%Max veloicty in KEAS
VeqMax=112.06; %[KEAS]
%Max payload power
p_pay=1000; %[Watts]
%lengyth of the fuselage
Ltot=27; %[ft^2]
%payload weight
Wpay=450; %[lb]
%Engine weight
Wengine=64*2.205; %[lb]
%Number of props
Nprop=1;
%Propeller diameter
D=3; %[ft]
%Number of blades
N_blades=4;
%Max shaft horsepower
P_max=115;
%Fuel weigyht
Wfuel=665; %[lb]
%Wing area
S=123; %[ft^2]
%Aspect Ratio
AR=19;
%Corss sectional circumference
pmax=4.34; %[ft^2]
%Number of pax, this will be estimated
Npax=1;
%Horizontal Tail area
S_h=25; %[ft^2]
%Horizontal tair AR
A_h=sqrt(14.4)/S_h;
%Span of vertical tail
bv=14.4; %[ft
%Span of horizontal tail
bh=14.4; %[ft
% t_rh = horizontal tail maximum root thickness in ft
t_rh=4/12;
% S_v = vertical tail area in ft^2
S_v=25; %[ft^2]
% A_v = vertical tail aspect ratio
A_v=A_h;
% t_rv = vertical tail maximum root thickness in ft
t_rv=4/12;
% sw_a = vertical tail quarter cord sweep angle
sw_a=1;
% = shock strut length for main gear
L_sm=3*12; %[ft]
%L_sn = shock strut length for nose gear
L_sn=3*12; %[ft]
%fuselage width
fuse_width=2.5; %ft
%fuselage diameter
fuse_diam=2.5; %ft
%dustance from wing one fourth mac to tail onforth mac
lt= 12;    %for us this is
%wing quarter chord sweep
sweep=1;
%wing taper ratio
lambda=.5;
%max win thickness ratio
t_c=.12;
%dynamic preussure at sea level
q=(.5)*(1.225)*(VeqMax*1.94);
%max dive speed
v_d=VeqMax*1.25; %
%Fueselage height
fuse_height=2.5; %Ft

%% Cessna 172 Skyhawk ***

MTOW_in1=(2300); %[lb]
MTOW_in2=MTOW_in1*5;
MTOW_in=[MTOW_in1,MTOW_in2];
%Variables
%Control surface planform area 
Scs=(14.53+7.43+18.3); %[ft^2]
%wingspan
b=35+(10/12); %[ft]
%Max veloicty in KEAS
VeqMax=121; %[KEAS]
%Max payload power
p_pay=500; %[Watts]
%lengyth of the fuselage
Ltot=27; %[ft^2]
%payload weight
Wpay=10; %[lb]
%Engine weight
Wengine=278; %[lb]
%Number of props
Nprop=1;
%Propeller diameter
D=76/12; %[ft]
%Number of blades
N_blades=2;
%Max shaft horsepower
P_max=160;
%Fuel weigyht
Wfuel=46*6; %[lb]
%Wing area
S=174; %[ft^2]
%Aspect Ratio
AR=7.52;
%Corss sectional circumference
pmax=(3)*pi; %[ft]
%Number of pax, this will be estimated
Npax=.25;
%Horizontal Tail area
S_h=21.56; %[ft^2]
%Horizontal tair AR
A_h=4;
%Span of vertical tail
bv=4; %[ft
%Span of horizontal tail
bh=11+(2/12); %[ft
%t_rh = horizontal tail maximum root thickness in ft
t_rh=4/12;
%S_v = vertical tail area in ft^2
S_v=11.24; %[ft^2]
%A_v = vertical tail aspect ratio
A_v=1.41;
%t_rv = vertical tail maximum root thickness in ft
t_rv=7.5;
%sw_a = vertical tail quarter cord sweep angle
sw_a=1;
%= shock strut length for main gear
L_sm=2.5*12; %[in]
%L_sn = shock strut length for nose gear
L_sn=2.5*12; %[in]
%fuselage width
fuse_width=3.11; %ft
%fuselage diameter
fuse_diam=3.11; %ft
%dustance from wing one fourth mac to tail onforth mac
lt= 18;    %for us this is
%wing quarter chord sweep
sweep=0;
%wing taper ratio
lambda=.672;
%max win thickness ratio
t_c=.12;
%dynamic preussure at sea level
q=(.5)*(1.225)*(VeqMax*1.94);
%max dive speed
v_d=VeqMax*1.25; %
%Fueselage height
fuse_height=2.5; %Ft
%Max accerlatoin 
N_bar=80.256; %[m/s
S_f=14;


%% Tekever AR5
%This will be the initial guess for our plane
MTOW_in1=(396.8); %[lb]
MTOW_in2=MTOW_in1*5;
MTOW_in=[MTOW_in1,MTOW_in2];
%Variables
%Control surface planform area 
Scs=5.5; %[ft^2]   
%wingspan
b=23.95; %[ft]
%Max veloicty in KEAS
VeqMax=54; %[KEAS]
%Max payload power
p_pay=300; %[Watts]
%lengyth of the fuselage
Ltot=12.8; %[ft]
%payload weight
Wpay=110; %[lb]
%Engine weight
Wengine=79.36; %[lb]
%Number of props
Nprop=2;
%Propeller diameter
D=3; %[ft]
%Number of blades
N_blades=2;
%Max shaft horsepower
P_max=60;
%Fuel weight
Wfuel=119.04; %[lb]
%Wing area
S=35.96; %[ft^2]
%Aspect Ratio
AR=16.35;
%Corss sectional circumference
pmax=15.4; %[ft^2]
%Number of pax, this will be estimated
Npax=.9;
%Horizontal Tail area
S_h=6.66; %[ft^2]
%Horizontal tair AR
A_h=sqrt(6.26)/S_h;
%t_rh = horizontal tail maximum root thickness in ft
t_rh=3/12;
%S_v = vertical tail area in ft^2
S_v=13.98; %[ft^2]
%Span of vertical tail
bv=2.28;
%fuselage width
 fuse_width=2.05; %[ft}
%fuselage diameter
fuse_diam=2.05; %[ft
%Span of horizontal tail
bh=5.84; 
%[ft%dustance from wing one fourth mac to tail onforth mac
%dustance from wing one fourth mac to tail onforth mac
lt=6.23;
%wing quarter chord sweep
sweep=0;
%wing taper ratio
lambda=0.75;
%q=dynamic pressure
q=(.5)*(1.225)*(VeqMax*1.94);
%max dive speed
V_d=VeqMax*1.25;
%Fueselage height
fuse_height=2.82; %Ft
N_bar=100;
%A_v = vertical tail aspect ratio
A_v=1.46;
%t_rv = vertical tail maximum root thickness in ft
t_rv=2;
%sw_a = vertical tail quarter cord sweep angle
sw_a=5;
%= shock strut length for main gear
L_sm=12*0.95; %[ikn]
%L_sn = shock strut length for nose gear
L_sn=12*0.63; %[in]
%mAX DIVE SPEED
v_d=VeqMax*1.25;
t_c=0.12;
%S_f= actual surface area of the fuselage
S_f=191.28; %ft^2
%L_D This is an estimate(14), bigger high L/d
L_D=12;

%% MQ-9 Reaper

%This will be the initial guess for our plane
MTOW_in1=(10500); %[lb]
MTOW_in2=MTOW_in1*5;
MTOW_in=[MTOW_in1,MTOW_in2];
%Variables
%Control surface planform area 
Scs=37.7; %[ft^2]   
%wingspan
b=66; %[ft]
%Max veloicty in KEAS
VeqMax=240; %[KEAS]
%Max payload power
p_pay=300; %[Watts]
%lengyth of the fuselage
Ltot=36; %[ft]
%payload weight
Wpay=3850; %[lb]
%Engine weight
Wengine=385; %[lb]
%Number of props
Nprop=1;
%Propeller diameter
D=9; %[ft]
%Number of blades
N_blades=3;
%Max shaft horsepower
P_max=900;
%Fuel weight
Wfuel=4000; %[lb]
%Wing area
S=215.28; %[ft^2]
%Aspect Ratio
AR=20.6;
%Corss sectional circumference
pmax=10.05; %[ft]
%Number of pax, this will be estimated
Npax=.9;
%Horizontal Tail area
S_h=65.43; %[ft^2]
%Horizontal tair AR
A_h=sqrt(6.26)/S_h;
%t_rh = horizontal tail maximum root thickness in ft
t_rh=3;
%S_v = vertical tail area in ft^2
S_v=26.01; %[ft^2]
%Span of vertical tail
bv=10.2;
%fuselage width
 fuse_width=3.2; %[ft}
%fuselage diameter
fuse_diam=3.2; %[ft
%Span of horizontal tail
bh=22.3; 
%[ft%dustance from wing one fourth mac to tail onforth mac
%dustance from wing one fourth mac to tail onforth mac
lt=11.81;
%wing quarter chord sweep
sweep=2;
%wing taper ratio
lambda=0.39;
%q=dynamic pressure
q=(.5)*(1.225)*(VeqMax*1.94);
%max dive speed
V_d=VeqMax*1.25;
%Fueselage height
fuse_height=3.2; %Ft
N_bar=100;
%A_v = vertical tail aspect ratio
A_v=4;
%t_rv = vertical tail maximum root thickness in ft
t_rv=2;
%sw_a = vertical tail quarter cord sweep angle
sw_a=15;
%= shock strut length for main gear
L_sm=3.9*12; %[in]
%L_sn = shock strut length for nose gear
L_sn=4.1*12; %[in]
%mAX DIVE SPEED
v_d=VeqMax*1.25;
t_c=0.16;
%S_f= actual surface area of the fuselage
S_f=378; %ft^2
%L_D This is an estimate(14), bigger high L/d
L_D=12;

%% AAI RQ-2

%This will be the initial guess for our plane
MTOW_in1=(500); %[lb]
MTOW_in2=MTOW_in1*5;
MTOW_in=[MTOW_in1,MTOW_in2];
%Variables
%Control surface planform area 
Scs=1; %[ft^2]   
%wingspan
b=16.9; %[ft]
%Max veloicty in KEAS
VeqMax=110; %[KEAS]
%Max payload power
p_pay=300; %[Watts]
%lengyth of the fuselage
Ltot=14; %[ft]
%payload weight
Wpay=100; %[lb]
%Engine weight
Wengine=18; %[lb]
%Number of props
Nprop=1;
%Propeller diameter
D=2.39; %[ft]
%Number of blades
N_blades=2;
%Max shaft horsepower
P_max=26;
%Fuel weight
Wfuel=74.5; %[lb]
%Wing area
S=29.39; %[ft^2]
%Aspect Ratio
AR=7.3;
%Corss sectional circumference
pmax=7.80; %[ft]
%Number of pax, this will be estimated
Npax=.9;
%Horizontal Tail area
S_h=8.067; %[ft^2]
%Horizontal tair AR
A_h=sqrt(6.26)/S_h;
%t_rh = horizontal tail maximum root thickness in ft
t_rh=2/12;
%S_v = vertical tail area in ft^2
S_v=4.141; %[ft^2]
%Span of vertical tail
bv=1.93;
%fuselage width
fuse_width=0.82; %[ft}
%fuselage diameter
fuse_diam=1.21; %[ft
%Span of horizontal tail
bh=6.6; 
%[ft%dustance from wing one fourth mac to tail onforth mac
%dustance from wing one fourth mac to tail onforth mac
lt=7.5;
%wing quarter chord sweep
sweep=0;
%wing taper ratio
lambda=1;
%q=dynamic pressure
q=(.5)*(1.225)*(VeqMax*1.94);
%max dive speed
V_d=VeqMax*1.25;
%Fueselage height
fuse_height=1.6; %Ft
N_bar=100;
%A_v = vertical tail aspect ratio
A_v=0.9;
%t_rv = vertical tail maximum root thickness in ft
t_rv=1/12;
%sw_a = vertical tail quarter cord sweep angle
sw_a=0;
%= shock strut length for main gear
L_sm=0; %[ft]
%L_sn = shock strut length for nose gear
L_sn=0; %[ft]
%mAX DIVE SPEED
v_d=VeqMax*1.25;
t_c=0.175;
%S_f= actual surface area of the fuselage
S_f=62; %ft^2
%L_D This is an estimate(14), bigger high L/d
L_D=12;
