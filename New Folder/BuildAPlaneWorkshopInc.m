close all
clear 
clc

Vcruise = 120:10:200;
file = 'Drag.xlsx';

hc = 18000;
throttle = .75;
Sg = 1000;
V_lof = 75;
CL_max = 1.3;
AR = 15;
f = [0.0351   -0.0029    0.0210];

for ii = 1:length(Vcruise)

Vc = Vcruise(ii);
    


Wto = 1000;
Wf = 100;
Wpl = 66.5;

ERROR = 1000;

while ERROR > 1
    
[PW,WS] = ConstraintDiagram(Vc,hc,throttle,Sg,V_lof,CL_max,AR,f);

[MTOW] = RangeSizing(Wto,Wf,Wpl);

error = 1000;

while error > 1
    
[S,b,c,P,L_fuselage,c_root,c_tip,L_h,S_h,b_h,c_root_h,c_tip_h,L_v,S_v,b_v,c_root_v,c_tip_v,c_T] = WingDimensions(MTOW,AR,WS,PW);

[MTOW_calc, Wcomp] = Design_weight_estimate(S_v,S_h,S, b, P,Wf, Vc,b_v,b_h,L_fuselage);
clc

error = 100*abs(MTOW-real(MTOW_calc(end)))/MTOW;
MTOW = real(MTOW_calc(end));

end

[f] = DragPolar(file,MTOW,S,c,b,c_root,c_tip,S_h,c_T,L_fuselage);

[df] = FuelConsumption(P,Vc,S,f,MTOW);

ERROR = 100*abs(Wf-df)/Wf;
Wf = df;
Wto = MTOW;

end

P0(ii) = P;
W1(ii) = Wto;
W2(ii) = Wto-(Wf+Wpl);
W3(ii) = Wf;

end

figure

subplot(221)
plot(Vcruise,W1,'b','linewidth',2)
xlabel('Ingress Speed [kts]')
ylabel('W_T_O [lbs]')
grid on

subplot(222)
plot(Vcruise,W2,'b','linewidth',2)
xlabel('Ingress Speed [kts]')
ylabel('W_e [lbs]')
grid on

subplot(223)
plot(Vcruise,W3,'b','linewidth',2)
xlabel('Ingress Speed [kts]')
ylabel('W_f [lbs]')
grid on

subplot(224)
plot(Vcruise,P0,'r','linewidth',2)
xlabel('Ingress Speed [kts]')
ylabel('Power [hp]')
grid on

