close all
clear all
clc

% cd('C:\Users\grega\Documents\GitHub\Senior-Design\Run Scripts')
fc = polyfit([0,.2,.4,.6,.8,1],[1.2,1.21,1.29,1.5,1.76,1.78],3);

xxx = [0.0174000000000000,0.0189000000000000,0.0192000000000000,0.0202000000000000,0.0218000000000000,0.0223000000000000,0.0233000000000000,0.0237000000000000,0.0243000000000000,0.0247000000000000,0.0247000000000000,0.0254000000000000,0.0255000000000000,0.0258000000000000,0.0260000000000000,0.0270000000000000,0.0287000000000000,0.0291000000000000,0.0295000000000000,0.0297000000000000,0.0297000000000000,0.0312000000000000,0.0319000000000000,0.0320000000000000,0.0329000000000000,0.0330000000000000,0.0346000000000000,0.0350000000000000,0.0355000000000000,0.0373000000000000,0.0389000000000000,0.0445000000000000,0.0470000000000000,0.0488000000000000,0.0559000000000000,0.0680000000000000];
zzz = 1:length(xxx);

j = 1;
alpha_ = [-5,0,5,10];
CL_W = [-.5,.25,.75,1.25];
CD_W = [.014,.01,.012,.018];
CL_HT = [-.7,-.15,.42,.9]*.23;
CD_HT = [.016,.008,.016,.024]*.23;
CD_VT = [.0017, .0020, .0023, .0027]*.346;
for ii = 1:4

%% Wing Data from AVL
alpha = alpha_(ii);


cd('C:\Users\grega\Documents\GitHub\Senior-Design\Functions')

%% Flight Conditions

h = 7000;
% dV = 60:10:150; %kts
V = 120;
V_fps = V*1.69;
[T,P,rho] = ISA_english(h);

%% Geometric Inputs

S = 120.5;


SA = 19.4;
SC = 95.6;
Scab = 4*pi;
Spx0 = 86.3;
alphaB0 = -1;
diaB = 4*pi;
w_LG = [.4921,.4921,.4921*.5];
d_LG = [1.247,1.247,1.247*.66];
Scam = 1.136;
Srad = 45.8/144;
nT = 5;
tc_T = 3.25/(.5*(29.9+11.97));
cT = 29.92/12;
A = .3061;
V2 = .9;
M = V*1.69*.3048/sqrt(1.4*296*278);
MC = M*sind(alpha);

%% Assumptions/Hand Calcs
Cf = 4.5*10^-3;
dCDS_cab = .004;
k = .83;
K = 5;
F = 1.16;
eta = .625;
CDC = polyval(fc,MC);
CDS_LG = [.484*1.1,.484*1.1,.484*1.4]/2;


% Fuselage Lift - Drag
[CL_B(ii),~,CD0_B(ii),CDi_B(ii)] = FuselageLiftDrag(alpha,alphaB0,S,k,diaB,eta,CDC,Spx0,Cf,F,SA,SC,K,dCDS_cab,Scab);

% Landing Gear Drag
[CD_LG(ii)] = LandingGearDrag(CDS_LG,d_LG,w_LG,S);


% Wing-Fuselage Interference Drag
[CD_WB(ii)] = .05*(CD0_B(ii)+CDi_B(ii));
 
% Tail-Fuselage Interference Drag
[CD_WT(ii)] = TailFuselageInterference(2,tc_T,3.5,S);

% Air Intake Drag
CD_duct(ii) = DuctDrag(h,A,V,V*V2,S);


CD(ii) = CD_W(ii)+CD_HT(ii)+CD_VT(ii)+CD0_B(ii)+CDi_B(ii)+CD_LG(ii)+CD_WB(ii)+CD_WT(ii)+CD_duct(ii);
CL(ii) = CL_W(ii)+CL_HT(ii)+CL_B(ii);

end

f = polyfit(CL(2:end),CD(2:end),2);
dy = linspace(0,2,100);
x2 = 0.02429 + 0.07169*dy.^2;
p = polyval(f,dy);
figure
hold on
plot(p,dy,'r','linewidth',2)
plot(x2,dy,'b','linewidth',2)
axis([0,max(x2),0,max(dy)])
grid on
ylabel('C_L')
xlabel('C_D')
ax=gca;
ax.XAxis.Exponent = 0;
ax.XTick = 0:.05:1000;
ax.XAxis.MinorTick='on';
ax.XAxis.MinorTickValues = 0:.01:1000;
ax.YAxis.Exponent = 0;
ax.YTick = 0:.25:30000;
ax.YAxis.MinorTick='on';
ax.YAxis.MinorTickValues = 0:.05:30000;
legend('Theoretical Prediction of Drag','Experimental Determination of Drag','location','best')
cd('C:\Users\grega\Documents\GitHub\Senior-Design\Run Scripts')

figure
hold on
scatter(zzz,xxx)



