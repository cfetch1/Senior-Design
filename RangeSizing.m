function [MTOW,We,Wf]=RangeSizing(Wpl,Wtoguess,Ecruise,SFCcruise,Range,Eloiter,SFCloiter,Endurance,reserve,hcr,Vcl,ROC,SFCclimb,eta_cl,eta_cr,Eclimb)
    
    %INPUTS
    %Wpl: payload weight, lb
    %Wtoguess: MTOW, lb
    %Ecruise: L/D during cruise phase
    %SFCcruise: fuel consumption at cruise (lb/(lb*hr))
    %Vcruise: cruise speed, kt
    %Range: range, nm
    %Eloiter: L/D during loiter phase
    %SFCloiter: Fuel consumption during loiter (lb/(lb*hr))
    %Endurance: time spent in loiter phase, hr
    %reserve: Reserve fuel, lb
    
    %hcr: cruise altitude, ft
    %Vclimb: climb velocity, kts
    %ROC: rate of climb, ft/min
    %SFCclimb: fuel consumption during climb 
    %eta_cl: propellor efficiency at climb
    %eta_cr: propellor efficiency at cruise
    %Eclimb: L/D during climb phase

    %OUTPUTS
    %We_log: empty weight based on regression from Roskam
    %We_arith: empty weight calculated from input parameters
    
    %Input unit conversion to make calcs work
    %LENGTH: nmi
    %TIME: hr
    %WEIGHT/FORCE: lbf
    

    Wto=Wtoguess; %unnecessary step but might make code more versatile in future
    error = 1000;
    while (abs(error) > 10) 
        Wrs=zeros(1,8); %weight ratio vector; one for each phase
        W=zeros(1,8); %weight at each phase 1-8, does not include takeoff
        %DATA FROM ROSKAM 
        

            Wrs(1)=0.995;%start,warmup
            Wrs(2)=0.997;%taxi
            Wrs(3)=0.998;%takeoff
            Wrs(4)=0.992;%climb
            Wrs(7)=0.993;%descent
            Wrs(8)=0.993;%landing,taxi,shutdown
       
        %breguet=@(w4w5)(Vcruise/SFCcruise)*(Ecruise)*log(w4w5);
        %Wrs(5)=1/fzero(@(Wr)(breguet(Wr)-Range),1.4); %estimate fuel burn during cruise from breguet eqn
        %loiterfunc=@(w5w6)(1/SFCloiter)*Eloiter*log(w5w6);
        %Wrs(6)=1/fzero(@(Wr)(loiterfunc(Wr)-Endurance),1.4); %estimate fuel burn during cruise from Roskam loiter (I think it's just breguet but without the speed)
        
        tcl = hcr/(ROC*60);
        
        Wrs(4) = exp(-(tcl*Vcl*SFCclimb/(325.866*eta_cl*Eclimb)));
        
        dxcl = sqrt(Vcl^2 - (.59248380*ROC)^2)*tcl;
        
        Xcr = Range-dxcl;

        Wrs(5) = exp(-(Xcr*SFCcruise/(325.866*eta_cr*Ecruise)));
        
        loiterfunc=@(w5w6)(1/SFCloiter)*Eloiter*log(w5w6);
        Wrs(6)=1/fzero(@(Wr)(loiterfunc(Wr)-Endurance),1.4); %estimate fuel burn during cruise from Roskam loiter (I think it's just breguet but without the speed)


        W(1)=Wto*Wrs(1);%getting first step, not indexed like the rest
        
        for j=2:8 %hard coded, but ok since there are only ever 8 steps
            W(j)=W(j-1)*Wrs(j);
        end
        
        MFF=prod(Wrs); %Mission fuel fraction, unused currently
        %Wf_mission=Wto-W(8); %fuel used during mission
        Wf_mission=Wto*(1-MFF);
        Wf=Wf_mission+reserve; %add reserve fuel to used fuel
        We=Wto-Wf-Wpl;
        
        A = -.144;
        B = 1.1162;
        
        We_log=10^((log10(Wto)-A)/B);
        error = We-We_log;
        Wto = Wto - error;
        
    end
    
    MTOW = (We+Wf+Wpl);
end