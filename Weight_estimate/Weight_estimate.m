clc
clear
close all
addpath("Gundlach\")
addpath("Nikolai_weight\")
addpath("Raymer\")
addpath("Roskam_weight\")
addpath("Howe\")

%Weigth esimate code
%The idea is that this will take all the inputs from other engine stuff and
%with the estimate MTOW, will determine the actual MTOW by iterating until
%the numbers converge within a certain tolerance.
%This will be th
%initial guess for our plane
prompt='Which aircraft do you want to run?';
disp("1:Our plane");
disp("2:Predator");
disp("3:Cessna");
disp("4:AR5");
disp("5:Reaper");
disp("6:RQ2");
disp("7:Tiger Shark");
disp("8:RQ-7 Shadow");
disp("9:Selex ES Falco");
disp("a:Pipistrel Virus 121 (Manned)");
str=input(prompt,'s');

if str =='1'
    disp("Our PLane");
    %%Our plane
MTOW_in1=(150); %[lb]
MTOW_in2=MTOW_in1*5;
MTOW_in=[MTOW_in1,MTOW_in2];
%Variables

Scs=4*.9886; %[ft^2]  %Control surface planform area  
b=24.08*.9886;    %wingspan %[ft]
VeqMax=162.06; %Max veloicty in [KEAS]
p_pay=320; %Max payload power [Watts]
Ltot=12.04*.9886; %lengyth of the fuselage [ft^2]
Wpay=33; %payload weight [lb]
Wengine=50+10+5; %Engine weight [lb]
Nprop=1;    %Number of props
D=(30/12)*.9886;    %Propeller diameter %[ft]
N_blades=2;     %Number of blades
P_max=100;  %Max shaft horsepower
Wfuel=105;   %Fuel weight %[lb]
S=38.67*.9886;    %Wing area %[ft^2]
AR=16*.9886;  %Aspect Ratio
pmax=.9886*pi*(1.5/2)^2;  %Corss sectional circumference%[ft^2]
Npax=.01;    %Number of pax, this will be estimated
S_h=5.95*.9886;   %Horizontal Tail area %[ft^2]
A_h=4.1*.9886;    %Horizontal tair AR
t_rh=3/12;  %t_rh = horizontal tail maximum root thickness in ft
S_v=5.95*.9886;   %vertical tail area in ft^2 %[ft^2]
bv=2.125*.9886;   %Span of vertical tail
fuse_width=1.5*.9886; %fuselage width %[ft}
fuse_diam=1.5*.9886; %fuselage diameter%[ft
%Span of horizontal tail
bh=5*.9886; %[ft%dustance from wing one fourth mac to tail onforth mac
lt=6.25*.9886;   %dustance from wing one fourth mac to tail onforth mac
sweep=0;    %wing quarter chord sweep
lambda=.5;  %wing taper ratio
fuse_height=2.75*.9886;%Fueselage height%Ft
V_d=VeqMax*1.25;    %max dive speed
N_bar=100;
A_v=2.15*.9886; %vertical tail aspect ratio
t_rv=2/12;  %vertical tail maximum root thickness in ft
sw_a=1;    %vertical tail quarter cord sweep angle
L_sm=18*.9886; %shock strut length for main gear[in]
L_sn=15*.9886; %shock strut length for nose gear[in]
v_d=VeqMax*1.25;    %mAX DIVE SPEED
t_c=.20;    %Wing thickness
L_D=7.3; %This is an estimate(14), bigger high L/d
S_f=46.44*.9886;  %Sf fuselage area ft^2
q=72.586;   %dynamic press
N_z=6;    %Safety factor
%TTail stuff
sweep_ht=0;
taper_ht=.8;
sweep_vt=10;
taper_vt=.7620;


elseif str =='2'
 disp("MQ-1 Predator");

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
S_f=463.44;  %Sf fuselage area
q=72.586;   %dynamic press
N_z=6;    %Safety factor
%TTail stuff
sweep_ht=0;
taper_ht=.8;
sweep_vt=10;
taper_vt=.7620;
N_bar=150;
L_D=18;
elseif str =='3'
 disp("Cessna 172 Skyhawk")

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
S_f=170;
%Sf fuselage area
q=72.586;   %dynamic press
N_z=6;    %Safety factor
%TTail stuff
sweep_ht=0;
taper_ht=.8;
sweep_vt=10;
taper_vt=.7620;
L_D=12;

elseif str =='4'
    disp("AR5");
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
%Sf fuselage area
q=72.586;   %dynamic press
N_z=4;    %Safety factor
%TTail stuff
sweep_ht=0;
taper_ht=.8;
sweep_vt=10;
taper_vt=.7620;
N_bar=90;

elseif str =='5'
    disp("Reaper");
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
%Sf fuselage area
q=72.586;   %dynamic press
N_z=6;    %Safety factor
%TTail stuff
sweep_ht=0;
taper_ht=.8;
sweep_vt=10;
taper_vt=.7620;
N_bar=120;

elseif str == '6'
 disp("AAI RQ-2");

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

%max dive speed
V_d=VeqMax*1.25;
%Fueselage height
fuse_height=1.6; %Ft

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
%Sf fuselage area
q=72.586;   %dynamic press
N_z=4;    %Safety factor
%TTail stuff
sweep_ht=0;
taper_ht=.8;
sweep_vt=10;
taper_vt=.7620;
N_bar=60;

elseif str == '7'
 disp("Tiger Shark");

%This will be the initial guess for our plane
MTOW_in1=(400); %[lb]
MTOW_in2=MTOW_in1*5;
MTOW_in=[MTOW_in1,MTOW_in2];
%Variables
%Control surface planform area 
Scs=3; %[ft^2]   
%wingspan
b=22; %[ft]
%Max veloicty in KEAS
VeqMax=80; %[KEAS]
%Max payload power
p_pay=300; %[Watts]
%lengyth of the fuselage
Ltot=14.3; %[ft]
%payload weight
Wpay=95; %[lb]
%Engine weight
Wengine=27; %[lb]
%Number of props
Nprop=1;
%Propeller diameter
D=3.3; %[ft]
%Number of blades
N_blades=2;
%Max shaft horsepower
P_max=32;
%Fuel weight
Wfuel=130; %[lb]
%Wing area
S=60.5; %[ft^2]
%Aspect Ratio
AR=8;
%Corss sectional circumference
pmax=2.43; %[ft]
%Number of pax, this will be estimated
Npax=.1;
%Horizontal Tail area
S_h=3.861; %[ft^2]
%Horizontal tair AR
A_h=3.33;
%t_rh = horizontal tail maximum root thickness in ft
t_rh=.12;
%S_v = vertical tail area in ft^2
S_v=5.81; %[ft^2]
%Span of vertical tail
bv=1.8;
%fuselage width
fuse_width=1.76; %[ft}
%fuselage diameter
fuse_diam=1.93; %[ft
%Span of horizontal tail
bh=4.4; 
%[ft%dustance from wing one fourth mac to tail onforth mac
%dustance from wing one fourth mac to tail onforth mac
lt=7.87;
%wing quarter chord sweep
sweep=0;
%wing taper ratio
lambda=.5;
%q=dynamic pressure

%max dive speed
V_d=VeqMax*1.25;
%Fueselage height
fuse_height=1.93; %Ft

%A_v = vertical tail aspect ratio
A_v=0.84;
%t_rv = vertical tail maximum root thickness in ft
t_rv=1/12;
%sw_a = vertical tail quarter cord sweep angle
sw_a=0;
%= shock strut length for main gear
L_sm=.76*12; %[ft]
%L_sn = shock strut length for nose gear
L_sn=.48*12; %[ft]
%mAX DIVE SPEED
v_d=VeqMax*1.25;
t_c=0.12;
%S_f= actual surface area of the fuselage
S_f=48.38; %ft^2
%L_D This is an estimate(14), bigger high L/d
L_D=8;
%Sf fuselage area
q=.5*.0161*(VeqMax)^2;   %dynamic press
N_z=4;    %Safety factor
%TTail stuff
sweep_ht=0;
taper_ht=.8;
sweep_vt=10;
taper_vt=.7620;
N_bar=60;
elseif str == '8'
 disp("RQ-7 Shadow");

%This will be the initial guess for our plane
MTOW_in1=(200); %[lb]
MTOW_in2=MTOW_in1*5;
MTOW_in=[MTOW_in1,MTOW_in2];
%Variables
%Control surface planform area 
Scs=2; %[ft^2]   
%wingspan
b=14; %[ft]
%Max veloicty in KEAS
VeqMax=110; %[KEAS]
%Max payload power
p_pay=2000; %[Watts]
%lengyth of the fuselage
Ltot=11.2; %[ft]
%payload weight
Wpay=60; %[lb]
%Engine weight
Wengine=23.5; %[lb]
%Number of props
Nprop=1;
%Propeller diameter
D=2.1; %[ft]
%Number of blades
N_blades=2;
%Max shaft horsepower
P_max=38;
%Fuel weight
Wfuel=96.8; %[lb]
%Wing area
S=17.64; %[ft^2]
%Aspect Ratio
AR=11.11;
%Corss sectional circumference
pmax=1.75; %[ft]
%Number of pax, this will be estimated
Npax=.1;
%Horizontal Tail area
S_h=7.35; %[ft^2]
%Horizontal tair AR
A_h=3.75;
%t_rh = horizontal tail maximum root thickness in ft
t_rh=.12;
%S_v = vertical tail area in ft^2
S_v=0; %[ft^2]
%Span of vertical tail
bv=0;
%fuselage width
fuse_width=1.75; %[ft}
%fuselage diameter
fuse_diam=1.2; %[ft
%Span of horizontal tail
bh=4.4; 
%[ft%dustance from wing one fourth mac to tail onforth mac
%dustance from wing one fourth mac to tail onforth mac
lt=6.72;
%wing quarter chord sweep
sweep=0;
%wing taper ratio
lambda=.5;
%q=dynamic pressure

%max dive speed
V_d=VeqMax*1.25;
%Fueselage height
fuse_height=1.2; %Ft

%A_v = vertical tail aspect ratio
A_v=3.1;
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
t_c=0.12;
%S_f= actual surface area of the fuselage
S_f=14.28; %ft^2
%L_D This is an estimate(14), bigger high L/d
L_D=6;
%Sf fuselage area
q=.5*.0161*(VeqMax)^2;   %dynamic press
N_z=4;    %Safety factor
%TTail stuff
sweep_ht=0;
taper_ht=.8;
sweep_vt=10;
taper_vt=.7620;
N_bar=60;
elseif str == '9'
 disp("Selex ES Falco");

%This will be the initial guess for our plane
MTOW_in1=(1000); %[lb]
MTOW_in2=MTOW_in1*5;
MTOW_in=[MTOW_in1,MTOW_in2];
%Variables
%Control surface planform area 
Scs=8; %[ft^2]   
%wingspan
b=23.58; %[ft]
%Max veloicty in KEAS
VeqMax=116; %[KEAS]
%Max payload power
p_pay=450; %[Watts]
%lengyth of the fuselage
Ltot=17.17; %[ft]
%payload weight
Wpay=154.32; %[lb]
%Engine weight
Wengine=80; %[lb]
%Number of props
Nprop=1;
%Propeller diameter
D=3.55; %[ft]
%Number of blades
N_blades=2;
%Max shaft horsepower
P_max=65;
%Fuel weight
Wfuel=154; %[lb]
%Wing area
S=52.22; %[ft^2]
%Aspect Ratio
AR=10.65;
%Corss sectional circumference
pmax=(2.07+2.36)/2; %[ft]
%Number of pax, this will be estimated
Npax=.1;
%Horizontal Tail area
S_h=12.51; %[ft^2]
%Horizontal tair AR
A_h=5.76;
%t_rh = horizontal tail maximum root thickness in ft
t_rh=.12;
%S_v = vertical tail area in ft^2
S_v=4.37; %[ft^2]
%Span of vertical tail
bv=2.96;
%fuselage width
fuse_width=2.36; %[ft}
%fuselage diameter
fuse_diam=2.36; %[ft
%Span of horizontal tail
bh=8.49; 
%[ft%dustance from wing one fourth mac to tail onforth mac
%dustance from wing one fourth mac to tail onforth mac
lt=8.84;
%wing quarter chord sweep
sweep=15;
%wing taper ratio
lambda=0.5;
%q=dynamic pressure

%max dive speed
V_d=VeqMax*1.25;
%Fueselage height
fuse_height=2.07; %Ft

%A_v = vertical tail aspect ratio
A_v=2;
%t_rv = vertical tail maximum root thickness in ft
t_rv=1/12;
%sw_a = vertical tail quarter cord sweep angle
sw_a=0;
%= shock strut length for main gear
L_sm=2.8*12; %[ft]
%L_sn = shock strut length for nose gear
L_sn=1.24*12; %[ft]
%mAX DIVE SPEED
v_d=VeqMax*1.25;
t_c=0.12;
%S_f= actual surface area of the fuselage
S_f=96.16; %ft^2
%L_D This is an estimate(14), bigger high L/d
L_D=10;
%Sf fuselage area
q=.5*.0161*(VeqMax)^2;   %dynamic press
N_z=4;    %Safety factor
%TTail stuff
sweep_ht=0;
taper_ht=.8;
sweep_vt=10;
taper_vt=.7620;
N_bar=70;
elseif str == 'a'
 disp("Pipstrel Virus 121");

%1323)
MTOW_in1=(1000); %[lb]
MTOW_in2=MTOW_in1*5;
MTOW_in=[MTOW_in1,MTOW_in2];
%Variables
%Control surface planform area 
Scs=14; %[ft^2]   
%wingspan
b=35.6; %[ft]
%Max veloicty in KEAS
VeqMax=120; %[KEAS]
%Max payload power
p_pay=300; %[Watts]
%lengyth of the fuselage
Ltot=21.25; %[ft]
%payload weight
Wpay=55; %[lb]
%Engine weight
Wengine=56.6*2.2; %[lb]
%Number of props
Nprop=1;
%Propeller diameter
D=10; %[ft]
%Number of blades
N_blades=2;
%Max shaft horsepower
P_max=99;
%Fuel weight
Wfuel=294; %[lb]
%Wing area
S=102.4; %[ft^2]
%Aspect Ratio
AR=12.04;
%Corss sectional circumference
pmax=(2.07+2.36)/2; %[ft]
%Number of pax, this will be estimated
Npax=1;
%Horizontal Tail area
S_h=1.02*10.76; %[ft^2]
%Horizontal tair AR
A_h=5.76;
%t_rh = horizontal tail maximum root thickness in ft
t_rh=.12;
%S_v = vertical tail area in ft^2
S_v=1.24*10.76; %[ft^2]
%Span of vertical tail
bv=3.90;
%fuselage width
fuse_width=2.36; %[ft}
%fuselage diameter
fuse_diam=2.36; %[ft
%Span of horizontal tail
bh=7.15; 
%[ft%dustance from wing one fourth mac to tail onforth mac
%dustance from wing one fourth mac to tail onforth mac
lt=12;
%wing quarter chord sweep
sweep=0;
%wing taper ratio
lambda=.6758;
%q=dynamic pressure

%max dive speed
V_d=VeqMax*1.25;
%Fueselage height
fuse_height=3.5; %Ft

%A_v = vertical tail aspect ratio
A_v=2;
%t_rv = vertical tail maximum root thickness in ft
t_rv=1/12;
%sw_a = vertical tail quarter cord sweep angle
sw_a=0;
%= shock strut length for main gear
L_sm=2.8*12; %[ft]
%L_sn = shock strut length for nose gear
L_sn=1.24*12; %[ft]
%mAX DIVE SPEED
v_d=VeqMax*1.25;
t_c=0.12;
%S_f= actual surface area of the fuselage
S_f=80; %ft^2
%L_D This is an estimate(14), bigger high L/d
L_D=12;
%Sf fuselage area
q=.5*.0161*(VeqMax)^2;   %dynamic press
N_z=4;    %Safety factor
%TTail stuff
sweep_ht=0;
taper_ht=.8;
sweep_vt=10;
taper_vt=.7620;
N_bar=100;

else
    disp("Wrong Input Dummy");
end

%% Main Code
    

eps=2; 
err=abs(MTOW_in(2)-MTOW_in(1));
prompt='Which Method do you want';
disp("1:Roskam");
disp("2:Nicolai");
disp("3:Howe");
disp("4:Raymer");
disp(" ");
str=input(prompt,'s');

if str == "1"
        disp("Roskam");
        for i=1:length(MTOW_in)

            [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, Ltot);
            [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
            [w_prop(i)] = weight_prop(Nprop,D,N_blades,P_max);
            [W_fuel_sys(i)] = weight_fuel_system(Wfuel);
            [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, Ltot, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wfuel, L_sm, L_sn);    
            [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wfuel,L_sm,S_v,bv,t_rv,VeqMax,fuse_width, fuse_diam, Ltot,S_h,lt,t_rh,bh,AR, sweep, S, lambda, t_c);
            [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),Ltot,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
            [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wfuel,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
             MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wfuel+W_struct_roskam(i)+Wengine;
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
            [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, Ltot, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wfuel, L_sm, L_sn);    
            [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wfuel,L_sm,S_v,bv,t_rv,VeqMax,fuse_width, fuse_diam, Ltot,S_h,lt,t_rh,bh,AR, sweep, S, lambda, t_c);
            [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),Ltot,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
            [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wfuel,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
            MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wfuel+W_struct_roskam(i)+Wengine;
            Diff(i)=MTOW_calc(i)-MTOW_in(i);
            MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
            err(i)=abs(MTOW_in(i+1)-MTOW_in(i));  
            comp_int=[(W_prop_sys(end)+Wengine(end)+w_prop(end));(W_fuel_sys(end)+Wfuel(end));W_feq(end);(W_feq(end)+W_prop_sys(end)+w_prop(end)+W_fuel_sys(end)+Wfuel(end)+Wengine(end))];
            comp_var=["Propulsion Sys";"Fuel Sys";"Fixed Eq";"Total internal/avionics"];
            comp=[comp_var,comp_int];
            Wcomp_rosk=cat(1,Wcomp_rosk,comp);
        end
        
        disp(Wcomp_rosk);
        disp(real(MTOW_calc(end)));
elseif str == "2"
        disp("Nicolai");
        for i=1:length(MTOW_in)

            [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, Ltot);
            [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
            [w_prop(i)] = weight_prop(Nprop,D,N_blades,P_max);
            [W_fuel_sys(i)] = weight_fuel_system(Wfuel);
            [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, Ltot, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wfuel, L_sm, L_sn);    
            [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wfuel,L_sm,S_v,bv,t_rv,VeqMax,fuse_width, fuse_diam, Ltot,S_h,lt,t_rh,bh,AR, sweep, S, lambda, t_c);
            [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),Ltot,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
            [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wfuel,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
             MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wfuel+W_airframe(i)+Wengine;
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
            [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, Ltot, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wfuel, L_sm, L_sn);    
            [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wfuel,L_sm,S_v,bv,t_rv,VeqMax,fuse_width, fuse_diam, Ltot,S_h,lt,t_rh,bh,AR, sweep, S, lambda, t_c);
            [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),Ltot,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
            [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wfuel,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
            MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wfuel+W_airframe(i)+Wengine;
            Diff(i)=MTOW_calc(i)-MTOW_in(i);
            MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
            err(i)=abs(MTOW_in(i+1)-MTOW_in(i));  
            comp_int=[(W_prop_sys(end)+Wengine(end)+w_prop(end));(W_fuel_sys(end)+Wfuel(end));W_feq(end);(W_feq(end)+W_prop_sys(end)+w_prop(end)+W_fuel_sys(end)+Wfuel(end)+Wengine(end))];
            comp_var=["Propulsion Sys";"Fuel Sys";"Fixed Eq";"Total internal/avionics"];
            comp=[comp_var,comp_int];
            Wcomp_nic=cat(1,Wcomp_nic,comp);

        end

        disp(Wcomp_nic);
                disp(real(MTOW_calc(end)));
elseif str =="3"
        disp("Howe");
        for i=1:length(MTOW_in)

            [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, Ltot);
            [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
            [w_prop(i)] = weight_prop(Nprop,D,N_blades,P_max);
            [W_fuel_sys(i)] = weight_fuel_system(Wfuel);
            [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, Ltot, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wfuel, L_sm, L_sn);    
            [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wfuel,L_sm,S_v,bv,t_rv,VeqMax,fuse_width, fuse_diam, Ltot,S_h,lt,t_rh,bh,AR, sweep, S, lambda, t_c);
            [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),Ltot,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
            [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wfuel,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
             MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wfuel+Howe_weight(i)+Wengine;
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
            [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, Ltot, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wfuel, L_sm, L_sn);    
            [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wfuel,L_sm,S_v,bv,t_rv,VeqMax,fuse_width, fuse_diam, Ltot,S_h,lt,t_rh,bh,AR, sweep, S, lambda, t_c);
            [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),Ltot,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
            [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wfuel,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
            MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wfuel+Howe_weight(i)+Wengine;
            Diff(i)=MTOW_calc(i)-MTOW_in(i);
            MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
            err(i)=abs(MTOW_in(i+1)-MTOW_in(i));  
            comp_int=[(W_prop_sys(end)+Wengine(end)+w_prop(end));(W_fuel_sys(end)+Wfuel(end));W_feq(end);(W_feq(end)+W_prop_sys(end)+w_prop(end)+W_fuel_sys(end)+Wfuel(end)+Wengine(end))];
            comp_var=["Propulsion Sys";"Fuel Sys";"Fixed Eq";"Total internal/avionics"];
            comp=[comp_var,comp_int];
            Wcomp_howe=cat(1,Wcomp_howe,comp);

        end

        disp(Wcomp_howe);
                disp(real(MTOW_calc(end)));
elseif str=="4"
        disp("Raymer")
        for i=1:length(MTOW_in)

            [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, Ltot);
            [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
            [w_prop(i)] = weight_prop(Nprop,D,N_blades,P_max);
            [W_fuel_sys(i)] = weight_fuel_system(Wfuel);
            [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, Ltot, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wfuel, L_sm, L_sn);    
            [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wfuel,L_sm,S_v,bv,t_rv,VeqMax,fuse_width, fuse_diam, Ltot,S_h,lt,t_rh,bh,AR, sweep, S, lambda, t_c);
            [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),Ltot,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
            [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wfuel,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
             MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wfuel+W_aircraft(i)+Wengine;
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
            [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, Ltot, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wfuel, L_sm, L_sn);    
            [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wfuel,L_sm,S_v,bv,t_rv,VeqMax,fuse_width, fuse_diam, Ltot,S_h,lt,t_rh,bh,AR, sweep, S, lambda, t_c);
            [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),Ltot,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
            [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wfuel,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
            MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wfuel+W_aircraft(i)+Wengine;
            Diff(i)=MTOW_calc(i)-MTOW_in(i);
            MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
            err(i)=abs(MTOW_in(i+1)-MTOW_in(i));  
            comp_int=[(W_prop_sys(end)+Wengine(end)+w_prop(end));(W_fuel_sys(end)+Wfuel(end));W_feq(end);(W_feq(end)+W_prop_sys(end)+w_prop(end)+W_fuel_sys(end)+Wfuel(end)+Wengine(end))];
            comp_var=["Propulsion Sys";"Fuel Sys";"Fixed Eq";"Total internal/avionics"];
            comp=[comp_var,comp_int];
            Wcomp_raymer=cat(1,Wcomp_raymer,comp);

        end

        disp(Wcomp_raymer);
                disp(real(MTOW_calc(end)));
else
        disp("Wrong input dummy");
end




