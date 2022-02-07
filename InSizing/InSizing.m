function [MTOW,We,Wf,P,S,b,L_fuselage,c_root,c_tip,L_h,S_h,b_h,c_root_h,c_tip_h,L_v,S_v,b_v,c_root_v,c_tip_v] = InSizing(range,Vcruise)


%% Initial Values (arbitrary)
err = 1000;
MTOW = 450*(range/550)*(Vcruise/120);
S = 40*(range/550)*(Vcruise/120);
Wf = 50*(range/550)*(Vcruise/120);
P2 = 40*(range/550)*(Vcruise/120)^2;
dX1 = MTOW;
dX2 = .95*MTOW;
dX3 = .9*MTOW;
dX4 = MTOW;
dX5 = .9*MTOW;
res = Wf*.25;

%% Constants
h=18000;
k=.0975;
[~,CD0] = DragSLF(1,0,0,S,0);
rho_cl = (density(0)+density(h))/2;
f = [0.0212   -0.0022    0.0282];
Sg = 1500;

while err>1
    
X1 = MTOW;
P1 = P2;
S1 = S;


%% calculate ROC

% Vclimb = (sqrt((2*dX1/(rho_cl*S)))*(k/(CD0))^.25)/1.69;
% V_fps = Vclimb*1.69;
% Vclimb = .6*Vcruise;
% 
% sigma = fsigma0(h/2);
% P_eng = P1*.85*(sigma-(1-sigma)/7.55);
% eta_prop = TR640(Vclimb,Vcruise);
% P_avail = P_eng*eta_prop*550;
% 
% % for gamma << 1
% CL = X1/(.5*rho_cl*V_fps^2*S);
% CD = f(1)*(CL)^2 + f(2)*CL + f(3);
% D = .5*rho_cl*V_fps^2*S*CD;
% P_req = D*V_fps;
% 
% gamma = asin((P_avail-P_req)/(X1*V_fps));
% 
% ROC = V_fps*60*sin(gamma);
% 
% % correct CL for gamma
% CL = X1*cos(gamma)/(.5*rho_cl*V_fps^2*S);
% CD = f(1)*(CL)^2 + f(2)*CL + f(3);
% D = .5*rho_cl*V_fps^2*S*CD;
% P_req = D*V_fps;
% 
% gamma = asin((P_avail-P_req)/(X1*V_fps));
% 
% ROC = V_fps*60*sin(gamma);
Vclimb = Vcruise^(1/1.12);
ROC = 982;

% [CL1,CD1] = DragSLF(Vclimb,dX1,0,S,ROC);
% E1 = CL1/CD1;
E1 = 13.9;

% [CL2,CD2] = DragSLF(Vcruise,dX2,h,S,0);
% E2 = CL2/CD2;
E2 =9.12;
E3=E2;
% 
% [CL3,CD3] = DragSLF(Vcruise,dX3,2000,S,0);

Vs = sqrt(2*(dX5)/(.0024*S*1.3))/1.69;
% [CL4,CD4] = DragSLF(1.5*Vs,dX4,0,S,0);
% E4=CL4/CD4;
CL4 = .653;
CD4 = .0358;
E4 = 18.2;

WS = 5:.1:30;

PSFC(1) = fPSFC(h/2,Vclimb);
PSFC(2) = fPSFC(h,Vcruise);
PSFC(3) = fPSFC(h,Vcruise);
% eta(1) = TR640(Vclimb,Vcruise);
% eta(2) = TR640(Vcruise,Vcruise);
eta = [.555,.8335];

[MTOW,We,Wf,~,Wrs]=RangeSizing(66.4,X1,range,0,[E1,E2,E3],[PSFC(1),PSFC(2),PSFC(3)],[Vclimb,Vcruise,Vcruise],ROC,h,[eta(1),eta(2)],1,res);
X2 = MTOW;

for ii=1:length(Wrs)
    y(ii) = (1-(Wrs(ii)))/(prod(Wrs(1:ii)));
end
yy = (Wf-res)/sum(y);
y = y*yy;

PW_cruise2 = PW_cruise(15, WS, Vcruise, CD0, h,.75);
PW_to = PW_takeoff(15, WS, CL4, CD4,  Sg,  0, 1.5*Vs,Vcruise);
WS_ = WS_landing(0,Sg,1.3);
for ii = 1
    for jj = 1:length(WS)
        PWmin(ii,jj) = max([dX3*PW_cruise2(ii,jj),dX1*PW_to(ii,jj)]);
        if PWmin(ii,jj) == min([PWmin(ii,1:jj)])
            if WS(jj) <= WS_ 
                index = jj;
            end
        end
    end
end

P2 = PWmin(index); %shaft horsepower
S = MTOW/WS(index); %planform area, ft^2
c = sqrt(S/15);
b = S/c;


err = 100*max([abs(X1-X2)/X2,abs(P1-P2)/P2,abs(S1-S)/S]);

if err>1
    dX1 = MTOW;
    dX2 = MTOW-sum(y(1:3));
    dX3 = MTOW-sum(y(1:4));
    dX4 = MTOW;
    dX5 = MTOW-sum(y(1:7));
    res = .25*sum(y(1:7));
    clear y PWmin
end

end

P=P2;
[L_fuselage,c_root,c_tip,L_h,S_h,b_h,c_root_h,c_tip_h,L_v,S_v,b_v,c_root_v,c_tip_v] = WingDimensions(S,b,c);

end

