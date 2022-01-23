
% %This will be the initial guess for our plane
% MTOW_in1=(436); %[lb]
% MTOW_in2=MTOW_in1*5;
% MTOW_in=[MTOW_in1,MTOW_in2];
% %Variables
% %Control surface planform area 
% Scs=4; %[ft^2]   
% %wingspan
% b=24.08; %[ft]
% %Max veloicty in KEAS
% VeqMax=162.06; %[KEAS]
% %Max payload power
% p_pay=320; %[Watts]
% %lengyth of the fuselage
% Ltot=12.04; %[ft^2]
% %payload weight
% Wpay=33; %[lb]
% %Engine weight
% Wengine=50; %[lb]
% %Number of props
% Nprop=1;
% %Propeller diameter
% D=3; %[ft]
% %Number of blades
% N_blades=4;
% %Max shaft horsepower
% P_max=100;
% %Fuel weigyht
% Wfuel=56; %[lb]
% %Wing area
% S=38.67; %[ft^2]
% %Aspect Ratio
% AR=16;
% %Corss sectional circumference
% pmax=4.34; %[ft^2]
% %Number of pax, this will be estimated
% Npax=.9;
% %Horizontal Tail area
% S_h=5.95; %[ft^2]
% %Horizontal tair AR
% A_h=sqrt(6.26)/S_h;
% % t_rh = horizontal tail maximum root thickness in ft
% t_rh=2/12;
% % S_v = vertical tail area in ft^2
% S_v=5.95; %[ft^2]


% %Need to fin this value********
% %Span of vertical tail
bv=14.4;
% %fuselage width
 fuse_width=1.5; %[ft}
% %fuselage diameter
fuse_diam=1.5; %[ft
% %Span of horizontal tail
bh=14.4; %[ft%dustance from wing one fourth mac to tail onforth mac
% %dustance from wing one fourth mac to tail onforth mac
lt=17;
% %wing quarter chord sweep
sweep=0;
% %wing taper ratio
lambda=.5;
%q=dynamic pressure
%q=(.5)*(1.225)*(VeqMax*1.94);
% %max dive speed
V_d=VeqMax*1.25;
% %Fueselage height
fuse_height=2.5; %Ft
N_bar=100;
% % A_v = vertical tail aspect ratio
% A_v=A_h;
% % t_rv = vertical tail maximum root thickness in ft
% t_rv=2/12;
% % sw_a = vertical tail quarter cord sweep angle
% sw_a=1;
% % = shock strut length for main gear
% L_sm=1.5; %[ft]
% %L_sn = shock strut length for nose gear
% L_sn=1.25; %[ft]


% %This will be the initial guess for a predator****
% MTOW_in1=(18000); %[lb]
% MTOW_in2=MTOW_in1*5;
% MTOW_in=[MTOW_in1,MTOW_in2];
% %Variables
% %Control surface planform area 
% Scs=6; %[ft^2]
% %wingspan
% b=48; %[ft]
% %Max veloicty in KEAS
% VeqMax=112.06; %[KEAS]
% %Max payload power
% p_pay=1000; %[Watts]
% %lengyth of the fuselage
% Ltot=27; %[ft^2]
% %payload weight
% Wpay=450; %[lb]
% %Engine weight
% Wengine=64*2.205; %[lb]
% %Number of props
% Nprop=1;
% %Propeller diameter
% D=3; %[ft]
% %Number of blades
% N_blades=4;
% %Max shaft horsepower
% P_max=115;
% %Fuel weigyht
% Wfuel=665; %[lb]
% %Wing area
% S=123; %[ft^2]
% %Aspect Ratio
% AR=19;
% %Corss sectional circumference
% pmax=4.34; %[ft^2]
% %Number of pax, this will be estimated
% Npax=1;
% %Horizontal Tail area
% S_h=25; %[ft^2]
% %Horizontal tair AR
% A_h=sqrt(14.4)/S_h;
% %Span of vertical tail
% bv=14.4; %[ft
% %Span of horizontal tail
% bh=14.4; %[ft
% % t_rh = horizontal tail maximum root thickness in ft
% t_rh=4/12;
% % S_v = vertical tail area in ft^2
% S_v=25; %[ft^2]
% % A_v = vertical tail aspect ratio
% A_v=A_h;
% % t_rv = vertical tail maximum root thickness in ft
% t_rv=4/12;
% % sw_a = vertical tail quarter cord sweep angle
% sw_a=1;
% % = shock strut length for main gear
% L_sm=4.5; %[ft]
% %L_sn = shock strut length for nose gear
% L_sn=4.5; %[ft]
% %fuselage width
% fuse_width=2.5; %ft
% %fuselage diameter
% fuse_diam=2.5; %ft
% %dustance from wing one fourth mac to tail onforth mac
% lt= 12;    %for us this is
% %wing quarter chord sweep
% sweep=1;
% %wing taper ratio
% lambda=.5;
% %max win thickness ratio
% t_c=12;
% %dynamic preussure at sea level
% q=(.5)*(1.225)*(VeqMax*1.94);
% %max dive speed
% v_d=VeqMax*1.25; %
% %Fueselage height
% fuse_height=2.5; %Ft



%this is for the cesna***

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
% t_rh = horizontal tail maximum root thickness in ft
t_rh=4/12;
% S_v = vertical tail area in ft^2
S_v=11.24; %[ft^2]
% A_v = vertical tail aspect ratio
A_v=1.41;
% t_rv = vertical tail maximum root thickness in ft
t_rv=7.5;
% sw_a = vertical tail quarter cord sweep angle
sw_a=1;
% = shock strut length for main gear
L_sm=2.5; %[ft]
%L_sn = shock strut length for nose gear
L_sn=2.5; %[ft]
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
t_c=12;
%dynamic preussure at sea level
q=(.5)*(1.225)*(VeqMax*1.94);
%max dive speed
v_d=VeqMax*1.25; %
%Fueselage height
fuse_height=2.5; %Ft
%Max accerlatoin 
N_bar=80.256; %[m/s
S_f=14;

%This will be the initial guess for our plane
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
%t_rh = horizontal tail maximum root thickness in ft
t_rh=2/12;
%S_v = vertical tail area in ft^2
S_v=5.95; %[ft^2]
%Span of vertical tail
bv=14.4;
%fuselage width
 fuse_width=1.5; %[ft}
%fuselage diameter
fuse_diam=1.5; %[ft
%Span of horizontal tail
bh=14.4; %[ft%dustance from wing one fourth mac to tail onforth mac
%dustance from wing one fourth mac to tail onforth mac
lt=17;
%wing quarter chord sweep
sweep=0;
%wing taper ratio
lambda=.5;
%q=dynamic pressure
q=(.5)*(1.225)*(VeqMax*1.94);
%max dive speed
V_d=VeqMax*1.25;
%Fueselage height
fuse_height=2.5; %Ft
N_bar=100;
%A_v = vertical tail aspect ratio
A_v=A_h;
%t_rv = vertical tail maximum root thickness in ft
t_rv=2/12;
%sw_a = vertical tail quarter cord sweep angle
sw_a=1;
%= shock strut length for main gear
L_sm=1.5; %[ft]
%L_sn = shock strut length for nose gear
L_sn=1.25; %[ft]
%mAX DIVE SPEED
v_d=VeqMax*1.25;
t_c=12;


%This will be the initial guess for our plane
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
%t_rh = horizontal tail maximum root thickness in ft
t_rh=2/12;
%S_v = vertical tail area in ft^2
S_v=5.95; %[ft^2]
%Span of vertical tail
bv=14.4;
%fuselage width
 fuse_width=1.5; %[ft}
%fuselage diameter
fuse_diam=1.5; %[ft
%Span of horizontal tail
bh=14.4; %[ft%dustance from wing one fourth mac to tail onforth mac
%dustance from wing one fourth mac to tail onforth mac
lt=17;
%wing quarter chord sweep
sweep=0;
%wing taper ratio
lambda=.5;
%q=dynamic pressure
q=(.5)*(1.225)*(VeqMax*1.94);
%max dive speed
V_d=VeqMax*1.25;
%Fueselage height
fuse_height=2.5; %Ft
N_bar=100;
%A_v = vertical tail aspect ratio
A_v=A_h;
%t_rv = vertical tail maximum root thickness in ft
t_rv=2/12;
%sw_a = vertical tail quarter cord sweep angle
sw_a=1;
%= shock strut length for main gear
L_sm=1.5; %[ft]
%L_sn = shock strut length for nose gear
L_sn=1.25; %[ft]
%mAX DIVE SPEED
v_d=VeqMax*1.25;
%Wing thickness
t_c=12;
%S_f= actual surface area of the fuselage
S_f=39.12; %ft^2
%L_D This is an estimate(14), bigger high L/d
L_D=12;
%Sf fuselage area
S_f=170;