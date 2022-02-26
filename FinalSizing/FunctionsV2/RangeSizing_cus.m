function [MTOW,We,Wf,EWF,Wrs]=RangeSizing_cus(Wpl,Wtoguess,Range,Endurance,E,SFC,V,ROC,h,eta,FOS,reserve,P0,S)
    
 %% INPUTS
 % Wpl
 % Wtoguess
 % Range
 % Endurance
 % Eclimb
 % Ecruise
 % Eloiter
 % SFCclimb
 % SFCcruise
 % SFCloiter
 % Vclimb
 % Vcruise
 % hcruise
 % ROC
 % eta_cruise
 % eta_climb
 % FOS
 
 %% OUTPUTS
 % MTOW
 % We
 % Wf
 % EWF
 

 Eclimb = E(1);
 Ecruise = E(2);
 Eloiter = E(3);
 
 SFCclimb = SFC(1);
 SFCcruise = SFC(2);
 SFCloiter = SFC(3);
 
 Vcl = V(1);
 Vcr = V(2);
 
 eta_climb = eta(1);
 eta_cruise = eta(2);

    Wto=Wtoguess; %unnecessary step but might make code more versatile in future
    error = 1000;
    while (abs(error) > 1) 
        Wrs=zeros(1,8); %weight ratio vector; one for each phase
        W=zeros(1,8); %weight at each phase 1-8, does not include takeoff
        %DATA FROM ROSKAM 
        

            Wrs(1)=0.990;%start,warmup
            Wrs(2)=0.990;%taxi
            Wrs(3)=0.990;%takeoff
            Wrs(4)=0.980;%climb
            Wrs(7)=0.990;%descent
            Wrs(8)=0.995;%landing,taxi,shutdown 
       
        %breguet=@(w4w5)(Vcruise/SFCcruise)*(Ecruise)*log(w4w5);
        %Wrs(5)=1/fzero(@(Wr)(breguet(Wr)-Range),1.4); %estimate fuel burn during cruise from breguet eqn
        %loiterfunc=@(w5w6)(1/SFCloiter)*Eloiter*log(w5w6);
        %Wrs(6)=1/fzero(@(Wr)(loiterfunc(Wr)-Endurance),1.4); %estimate fuel burn during cruise from Roskam loiter (I think it's just breguet but without the speed)
        
        tcl = h/(ROC*60);
        
        Wrs(4) = exp(-(tcl*Vcl*SFCclimb/(325.866*eta_climb*Eclimb)));
        
        dxcl = sqrt(Vcl^2 - (.01*ROC)^2)*tcl;
        
        Xcr = Range-dxcl;

        %Wrs(5) = exp(-(Xcr*SFCcruise/(325.866*eta_cruise*Ecruise)));
        [~,~,~,dW,~] = fcruise(Xcr,h,Vcr,0,Wto*prod(Wrs(1:4)),P0,.75,Vcr,S,[0.0212,-0.0022,0.0282]);
        Wrs(5) = dW(end)/dW(1);
        loiterfunc=@(w5w6)(1/SFCloiter)*Eloiter*log(w5w6);
        %Wrs(6)=1/fzero(@(Wr)(loiterfunc(Wr)-Endurance),1.4); %estimate fuel burn during cruise from Roskam loiter (I think it's just breguet but without the speed)
        Wrs(6)=1;

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
        
        We_log=(10^((log10(Wto)-A)/B));

        error = abs((We-We_log)/We_log);
        Wto = Wto - error;
        
    end
    
    MTOW = (We+Wf+Wpl);
    EWF = We/MTOW;
    MTOW = MTOW*FOS;
    
    
    
    
end