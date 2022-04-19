close all
clear
clc

lim=1;

Vcruise = 160;
file = 'Drag.xlsx';

hc = 18000;
throttle = .75;
Sg = 2000;
V_lof = 75;
CL_max = 1.3;
AR = 15;
f = [0.0327   0.0095    0.0228];

Vc= Vcruise(1); 
MTOW = 800*(Vc/120)^.2;
Wf = 140*(Vc/120)^.25;
Wpl = 90;
S = MTOW/20;


for ii = 1:length(Vcruise)
    
    Vc = Vcruise(ii);
        
    ERROR = 1000;
    
    while ERROR > lim
        
        dV = 60:120;
    for kk = 1:length(dV)
        [CL,CD] = DragSLF(dV(kk),MTOW,hc/2,S,f);
        E(kk) = CL/CD;
        if E(kk) == max(E)
            index = kk;
        end
    end
    VE = dV(index);
    clear E index
        
        
        
        
        
        [PW,WS,ROC] = ConstraintDiagram(Vc,hc,throttle,Sg,CL_max,AR,f,VE,length(Vcruise));

        
        error = 1000;
        
        while error > lim
            
            [S,b,c,P,L_fuselage,c_root,c_tip,L_h,S_h,b_h,c_root_h,c_tip_h,L_v,S_v,b_v,c_root_v,c_tip_v,c_T] = WingDimensions(MTOW,AR,WS,PW);
            clc
            [MTOW_calc, Wcomp] = Design_weight_estimate(S_v,S_h,S, b, P,Wf, Vc,b_v,b_h,L_fuselage);
            
            
            error = 100*abs(MTOW-real(MTOW_calc(end)))/MTOW;
            MTOW = real(MTOW_calc(end));
            
        end
        
        [f] = DragPolar(file,MTOW,S,c,b,c_root,c_tip,S_h,c_T,L_fuselage);
        
        close all
        [df,P] = FuelConsumption(P,Vc,S,f,MTOW,length(Vcruise),ROC);
        
        ERROR = 100*abs(Wf-df)/Wf; 
        MTOW = MTOW-Wf+df;
        Wf = df;
        
        
    end
    
    P0(ii) = P;
    W1(ii) = MTOW;
    W2(ii) = MTOW-(Wf+Wpl);
    W3(ii) = Wf;
    
end
ConstraintDiagram(Vc,hc,throttle,Sg,CL_max,AR,f,VE,length(Vcruise));
if length(Vcruise)>1
    clc
    figure
    
    subplot(221)
    hold on
    plot(Vcruise,W1,'b','linewidth',2)
    xlabel('Ingress Speed [kts]')
    ylabel('W_T_O [lbs]')
    axis([min(Vcruise),max(Vcruise),min(W1),max(W1)])
    grid on
    
    subplot(222)
    hold on
    plot(Vcruise,W2,'b','linewidth',2)
    xlabel('Ingress Speed [kts]')
    ylabel('W_e [lbs]')
    axis([min(Vcruise),max(Vcruise),min(W2),max(W2)])
    grid on
    
    subplot(223)
    hold on
    plot(Vcruise,W3,'b','linewidth',2)
    xlabel('Ingress Speed [kts]')
    ylabel('W_f [lbs]')
    axis([min(Vcruise),max(Vcruise),min(W3),max(W3)])
    grid on
    
    subplot(224)
    hold on
    plot(Vcruise,P0,'r','linewidth',2)
    xlabel('Ingress Speed [kts]')
    ylabel('Power [hp]')
    axis([min(Vcruise),max(Vcruise),min(P0),max(P0)])
    grid on

    figure
    hold on
    a1 = plot(Vcruise,W1,'b','linewidth',2);
    a2 = plot(Vcruise,W2,'b--','linewidth',2);
    a3 = plot(Vcruise,W3,'k--','linewidth',2);
    text2line(a1,.5,0,'MTOW')
    text2line(a2,.5,0,'W_e')
    text2line(a3,.5,0,'W_f')
    xlabel('Ingress Speed [kts]')
    ylabel('Weight [lbs]')
    axis([min(Vcruise),max(Vcruise),0,max(W1)])
    grid on
    
    figure
    hold on
    yyaxis left
    plot(Vcruise,W1,'b','linewidth',2);
    ylabel('W_T_O [lbs]')
    axis([min(Vcruise),max(Vcruise),min(W1),max(W1)])
    grid on
    yyaxis right
    plot(Vcruise,P0,'r','linewidth',2);
    xlabel('Ingress Speed [kts]')
    ylabel('Power [hp]')
    axis([min(Vcruise),max(Vcruise),min(P0),max(P0)])
    grid on
end
