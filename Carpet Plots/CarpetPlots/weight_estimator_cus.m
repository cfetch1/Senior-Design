function [Wto, We_arith, Wf]=weight_estimator_cus(Wpl,Wtoguess,Ecruise,SFCcruise,Vcruise,Range,Eloiter,SFCloiter,Endurance,reserve,type)
    %Ethan Narad, 10/9/20
    
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
        
        if type == 1
            Wrs(1)=0.995;%start,warmup
            Wrs(2)=0.997;%taxi
            Wrs(3)=0.998;%takeoff
            Wrs(4)=0.992;%climb
            Wrs(7)=0.993;%descent
            Wrs(8)=0.993;%landing,taxi,shutdown
        elseif type == 2
            Wrs(1)=0.992;%start,warmup
            Wrs(2)=0.996;%taxi
            Wrs(3)=0.996;%takeoff
            Wrs(4)=0.990;%climb
            Wrs(7)=0.992;%descent
            Wrs(8)=0.992;%landing,taxi,shutdown
        elseif type == 3
            
            Wrs(1)=0.990;%start,warmup
            Wrs(2)=0.990;%taxi
            Wrs(3)=0.990;%takeoff
            Wrs(4)=0.980;%climb
            Wrs(7)=0.990;%descent
            Wrs(8)=0.995;%landing,taxi,shutdown 
%             Wrs(1)=0.992;%start,warmup
%             Wrs(2)=0.996;%taxi
%             Wrs(3)=0.996;%takeoff
%             Wrs(4)=0.990;%climb
%             Wrs(7)=0.992;%descent
%             Wrs(8)=0.992;%landing,taxi,shutdown
        elseif type == 4
            Wrs(1)=0.990;%start,warmup
            Wrs(2)=0.990;%taxi
            Wrs(3)=0.990;%takeoff
            Wrs(4)=0.980;%climb
            Wrs(7)=0.990;%descent
            Wrs(8)=0.995;%landing,taxi,shutdown 
        end

        %breguet=@(w4w5)(Vcruise/SFCcruise)*(Ecruise)*log(w4w5);
        %Wrs(5)=1/fzero(@(Wr)(breguet(Wr)-Range),1.4); %estimate fuel burn during cruise from breguet eqn
        %loiterfunc=@(w5w6)(1/SFCloiter)*Eloiter*log(w5w6);
        %Wrs(6)=1/fzero(@(Wr)(loiterfunc(Wr)-Endurance),1.4); %estimate fuel burn during cruise from Roskam loiter (I think it's just breguet but without the speed)

        Wrs(5)=exp(-(Range*SFCcruise)/(Vcruise*Ecruise));
        Wrs(6)=exp(-(Endurance*SFCloiter/Eloiter));

        W(1)=Wto*Wrs(1);%getting first step, not indexed like the rest
        for j=2:8 %hard coded, but ok since there are only ever 8 steps
            W(j)=W(j-1)*Wrs(j);
        end
        MFF=prod(Wrs); %Mission fuel fraction, unused currently
        %Wf_mission=Wto-W(8); %fuel used during mission
        Wf_mission=Wto*(1-MFF);
        Wf=Wf_mission+reserve; %add reserve fuel to used fuel
        We_arith=Wto-Wf-Wpl;
        
        if type == 1 % single prop regression model
            A = -.144;
            B = 1.1162;
            
        elseif type == 2 % double prop regression mode
            A = .0966;
            B = 1.0298;
            
        elseif type == 3 % double prop composite regression model

            A = .113;
            B = 1.0403; 
            
        elseif type == 4 % turbojet composite regression model

            A = .8222;
            B = .8050;
            
        end
        
        We_log=10^((log10(Wto)-A)/B);
        error = We_arith-We_log;
        Wto = Wto - error;
    end
end