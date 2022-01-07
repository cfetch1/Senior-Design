close all
clear all
clc


Wpl = 60;
Wtoguess = 400;
Ecruise = 16;
SFCcruise = .4;
Range = 550;
Eloiter = 20;
SFCloiter = .4;
Endurance = 1;
reserve = 2*6;
hcr = 10000;
Vcl = 120;
ROC = 40;
SFCclimb = .5;
eta_cl = .3132;
eta_cr = .7641;
Eclimb = 18;

[MTOW,We,Wf]=RangeSizing(Wpl,Wtoguess,Ecruise,SFCcruise,Range,Eloiter,SFCloiter,Endurance,reserve,hcr,Vcl,ROC,SFCclimb,eta_cl,eta_cr,Eclimb);

WS = 5:1:30;
CD0 = .028;
CDto = .038;
CLto = .7;
AR = 23;
dg = 3000;

Vcr = 120;
Vturn = .5*Vcr;
Vto = 40;
V = [Vturn, Vcl, Vto, Vcr];

eta = [.4354,.3132,.4309,.7641,.7667]; %[turn, climb, to, cruise, ceiling]

hturn = hcr;
hto = 0;
hclimb = .5*hcr;
hmax = 1.2*hcr;
h = [hturn, hclimb, hto, hcr, hmax];

[PW,PWmin_,PWmin,ii] = PowerSizing(WS,CD0,CDto,CLto,AR,V,ROC,h,dg,eta,0);

P = PWmin*MTOW; %shaft horsepower
S = PWmin*MTOW; %planform area, ft^2
b = sqrt(S*AR); %wingspan, ft
c = S/b; %mean chord, ft














