close all;clear;clc;
% Add function floder to path
addpath('Berg_Gud_Chapter3_VERSION2')

%% Set Initial Guess Values
% Max take off weight Initial guess [lbf]
MTOW = 500;

% Max Lift Coefficient
CLmax = 2;

% Climb L/D
Eclimb = 15;

% Feul weight [Gal]
Wf = 10;

% Power [Hp]
P = 50;

% Initial AR guess - Scalar/Vector
ARi = 15;

%% Sweep through AR 
for i = 1:length(ARi)
AR = ARi(i);

% Set Error for Iteration
err=1000;
    while abs(err)>1
    
    % Store MTOW from previous iteration as e1
    e1 = MTOW;
    
    % 0 Cl Drag
    CD0 = .035;

    % Oswald efficiency factor
    e = 1.78*(1-0.045*AR^0.68)-0.64;

    % Second order coefficent
    k = 1/(pi*AR*e);
    
    % Lift/Drag
    E = 1/2*sqrt(1/(CD0*k));
    
    % Payload Weight [lb]
    Wpl = 50;

    % Take off Weight Guess
    Wtoguess = MTOW*.9;

    % Cruise L/D
    Ecruise = E;

    % Fuel Consumption at Cruise
    SFCcruise = .4;
    
    % Total Range [nm]
    Range = 550;

    % L/D at Loiter
    Eloiter = E;

    % Fuel Consumption at Loiter
    SFCloiter = .4;

    % Loiter Time [hr]
    Endurance = 1;

    % Fuel Reserved 1/4 Full
    reserve = Wf/4;

    % Cruise Altitude [ft]
    hcr = 7000;

    % V Climb [knots]
    Vcl = 120;

    % Rate of Climb [ft/min]
    ROC = 40;

    % Climb Fuel Consumption [lb/(lb*hr)]
    SFCclimb = .5;
    
    % Porp Efficieny at Climb/Cruise
    eta_cl = .7865;
    eta_cr = .7859;
    
    % Input to Rang Sizing Function to updata MTOW
    [MTOW, We, Wf]=RangeSizing(Wpl,Wtoguess,Ecruise,SFCcruise,Range,...
        Eloiter,SFCloiter,Endurance,reserve,hcr,Vcl,ROC,SFCclimb,eta_cl,...
        eta_cr,Eclimb);

    % Store Updated MTOW as e2
    e2 = MTOW;
    
    % Wing Loading [lb/ft2]
    WS = 5:50;
    
    % Take-off Drag Coeffiecnt
    CDto = .028;
    % Take-off Lift Coefficient
    CLto = .7;

    % Gound Run
    dg = 3000;
    
    % Cruise Velocity [kts]
    Vcr = 120;

    % Turn Velocity [kts]
    Vturn = .5*Vcr;

    % Take off velocity [kts]
    Vto = 60;

    % Stall velocity [kts]
    Vstall = 40;
    V = [Vturn, Vcl, Vto, Vcr, Vstall];

    %efficiency [turn, climb, to, cruise, ceiling]
    eta = [0.4147, eta_cl, 0.4097, eta_cr, 0.7859]; 
    
    % Altitude at conditions [ft]
    hturn = hcr;
    hto = 0;
    hclimb = 0;
    hmax = 10000;
    h = [hturn, hclimb, hto, hcr, hmax];

    %{ 
    %if AR == 23
    %     z = 1;
    % else 
    %     z=0;
    % end
    %}
    
    % Initial guess (from previous iteraiton) power
    E1 = P;

    % Run Power Sizing Funcaiton
    [~,~,PWmin,ii] = PowerSizing(WS,CD0,CDto,CLto,CLmax,AR,V,ROC,h,dg,eta,0);
    
    %{
    % 
    % end
    % figure
    % hold on
    % plot(x,y,'r','linewidth',2)
    % grid on
    % axis([x(1),x(end),0,max(y)])
    % % ax=gca;
    % % ax.XTick = 0:1:WS(end);
    % % ax.XAxis.MinorTick='on';
    % % ax.XAxis.MinorTickValues = 0:1:AR_(end);
    % % ax.YTick = 0:.001:1;
    % % ax.YAxis.MinorTick='on';
    % % ax.YAxis.MinorTickValues = 0:.001:1;
    % % ylabel('Minimum P/W [hp/lbm]')
    % % xlabel('Aspect Ratio')
    % % 
    % % 
    %}
    
    % Shaft horsepower
    P = PWmin*MTOW;
    
    % planform area [ft^2]
    S = MTOW/WS(ii);

    % Wingspan [ft]
    b = sqrt(S*AR); 

    % mean chord [ft]
    c = S/b;

    % Store Updated Power
    E2 = P;
    CLmax = WS(ii)/((40*1.69)^2*.0024/2);
    
    
    
    % Descend Angle (Temporary)
    gamma = asin(40*1.69/120);

    %Dynamic Pressure
    q = .5*.0024*(120/1.69)^2;
    CL = (MTOW*cos(gamma))/(q*S);
    CD = .025+k*CL^2;
    % L/D
    Eclimb = CL/CD;
    
    % Error for convergence
    err = abs(100*(E1-E2)/E2)+abs(100*(e1-e2)/e2);
    end

    x(i) = AR;
    y1(i) = MTOW;
    y2(i) = P;
    y3(i) = b;
end

[~,~,PWmin,ii] = PowerSizing2(WS,CD0,CDto,CLto,CLmax,AR,V,ROC,h,dg,eta,1);

%% Do Plot
if i==1   
    disp(['Aspect Ratio: ',num2str(AR)])
    disp(['Max Take-off Weight ',num2str(MTOW), ' [lb]'])
    disp(['Wing Area ',num2str(S), ' [ft^2]'])
    disp(['Wing Span ',num2str(b), ' [ft]'])
    disp(['Mean Chord ',num2str(c), ' [ft]'])
else  
    figure
    subplot(311)
    hold on
    plot(x,y1)
    xlabel('AR')
    ylabel('MTOW')
    grid on
    axis([0,max(x),0,max(y1)])
    subplot(312)
    hold on
    plot(x,y2)
    xlabel('AR')
    ylabel('Power')
    grid on
    axis([0,max(x),0,max(y2)])
    subplot(313)
    hold on
    plot(x,y3)
    xlabel('AR')
    ylabel('Span')
    grid on
    axis([0,max(x),0,max(y3)])
end