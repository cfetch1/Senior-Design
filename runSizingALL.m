%close all
clear all
clc

Wpl = 50;
Wtoguess = 300;
Ecruise = 18;
SFCcruise = .4;
Range = 550;
Eloiter = 18;
SFCloiter = .4;
Endurance = 1;
reserve = 10;
hcr = 7000;
Vcl = 120;
ROC = 40;
SFCclimb = .5;
eta_cl = .7865;
eta_cr = .7859;
Eclimb = 17;

[MTOW,We,Wf]=RangeSizing(Wpl,Wtoguess,Ecruise,SFCcruise,Range,Eloiter,SFCloiter,Endurance,reserve,hcr,Vcl,ROC,SFCclimb,eta_cl,eta_cr,Eclimb);
MTOW


% AR_ = 10:30;
% for i = 1:length(AR_)
% AR = AR_(i);
AR = 23
i=1;
e = 1.78*(1-0.045*AR^0.68)-0.64;
k = 1/(pi*AR*e);
E = 1/2*sqrt(1/(.025*k));
gamma = asin(40*1.69/120);
q = .5*.0024*(120/1.69)^2;
S =  31.27;
CL = (MTOW*.9*cos(gamma))/(q*S);
CD = .025+k*CL^2;
Eclimb = CL/CD;



WS = 5:1:30;
CD0 = .025;
CDto = .028;
CLto = .7;
dg = 3000;

Vcr = 120;
Vturn = .5*Vcr;
Vto = 40;
V = [Vturn, Vcl, Vto, Vcr];

eta = [.4147,eta_cl,.4097,eta_cr,.7859]; %[turn, climb, to, cruise, ceiling]

hturn = hcr;
hto = 0;
hclimb = 0;
hmax = 10000;
h = [hturn, hclimb, hto, hcr, hmax];

[PW,PWmin_,PWmin(i),ii] = PowerSizing(WS,CD0,CDto,CLto,AR,V,ROC,h,dg,eta,0);
%i=i+1;
P(i) = PWmin(i)*MTOW %shaft horsepower
S = MTOW/WS(ii) %planform area, ft^2
b = sqrt(S*AR) %wingspan, ft
c = S/b %mean chord, ft

CLmax = WS(ii)/((40*1.69)^2*.0024/2)

Emax = .5*sqrt(1/(.025*k));

% end







