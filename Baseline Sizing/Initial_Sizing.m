close all;clear;clc;
% Add function floder to path
addpath('Functions')

%% -----------------------------Weight-----------------------------------

% Max take off weight Initial guess [lbf]
MTOW = 500;

% Feul weight [Gal]
Wf = 10;

% Payload Weight [lb]
Wpl = 50;

% Fuel Reserved 1/4 Full
reserve = Wf/4;

%% -----------------------------Range-------------------------------------

% Total Range [nm]
Range = 550;

% Loiter Time [hr]
Endurance = 1;

%% ----------------------------Coefficients-----------------------------

% Initial AR guess - Scalar/Vector
AR = 15;

% Max Lift Coefficient
CLmax = 2;

% Take-off Drag Coeffiecnt
% CDto = .028;
CDto = .035+.018;

% Take-off Lift Coefficient
CLto = .7;

% 0 Cl Drag
CD0 = .035;

% Oswald efficiency factor
e = 1.78*(1-0.045*AR^0.68)-0.64;

% Second order coefficent
k = 1/(pi*AR*e);
    
% Lift/Drag
E = 1/2*sqrt(1/(CD0*k));
    
% Climb L/D
Eclimb = 15;

% Cruise L/D
Ecruise = E;

% L/D at Loiter
Eloiter = E;

%% -----------------------------Velocity---------------------------------

% V Climb [knots]
Vcl = 120;

% Gound Run [ft]
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

% Rate of Climb [ft/min]
ROC = 40;

%% ----------------------------Propulsion--------------------------------

% Fuel Consumption at Cruise
SFCcruise = .4;

% Fuel Consumption at Loiter
SFCloiter = .4;

% Climb Fuel Consumption [lb/(lb*hr)]
SFCclimb = .5;

% Porp Efficieny at Climb/Cruise
eta_cl = .7865;
eta_cr = .7859;

% Engine Efficiency [turn, climb, to, cruise, ceiling]
eta = [0.4147, eta_cl, 0.4097, eta_cr, 0.7859];

%% ------------------Altitude at conditions [ft]--------------------------

% Cruise Altitude [ft]
hcr = 7000;
hturn = hcr;
hto = 0;
hclimb = 0;
hmax = 10000;
h = [hturn, hclimb, hto, hcr, hmax];

%% --------------------------Initialize-----------------------------------

% Wing Loading [lb/ft2]
WS = 5:50;

% Initial Guess Power [Hp]
P = 50;

%% Convergence Iterations

% Set Error for Iteration
err=1000;
while abs(err)> 0.5
    % Store MTOW from previous iteration as e1
    e1 = MTOW;
    
    % Take off Weight Guess
    Wtoguess = MTOW*.9;
    
    % Fuel Reserved 1/4 Full
    reserve = Wf/4;

    % Input to Rang Sizing Function to update MTOW
    [MTOW, We, Wf]=RangeSizing(Wpl,Wtoguess,Ecruise,SFCcruise,Range,...
        Eloiter,SFCloiter,Endurance,reserve,hcr,Vcl,ROC,SFCclimb,eta_cl,...
        eta_cr,Eclimb);
    
    % Store Updated MTOW as e2
    e2 = MTOW;
    
    % Initial guess (from previous iteraiton) power
    E1 = P;
    
    % Run Power Sizing Funcaiton
    [~,~,PWmin,ii] = PowerSizing(WS,CD0,CDto,CLto,CLmax,AR,V,ROC,h,dg,eta,0);
     
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
    
    % Cruise Dynamic Pressure
    q = .5*.0024*(Vcr/1.69)^2;
    CL = (MTOW*cos(gamma))/(q*S);
    CD = CD0 + k*CL^2;
    
    % L/D
    Eclimb = CL/CD;
    
    % Error for convergence
    err = abs(100*(E1-E2)/E2)+abs(100*(e1-e2)/e2);
end 

% Generate Plot using PowerSizing Function
[~,~,PWmin,ii] = PowerSizing(WS, CD0, CDto, CLto, CLmax, AR, V,...
                             ROC, h, dg, eta, 1);


saveas(gcf,'Figures/initial_contrain.fig')

%% Display Sizing Result
disp('Sizing Result: ')
disp(['P/W: ', num2str(PWmin), ' [bhp/lbm]'])
disp(['W/S: ', num2str(WS(ii)), ' [lbm/ft]'])
disp(['AR: ', num2str(AR), ' [/]'])
disp(['MTOW: ', num2str(MTOW), ' [lbs]'])
disp(['P_req: ', num2str(P), ' [hp]'])
disp(['Area: ', num2str(S), ' [ft^2]'])
disp(['Span: ', num2str(b), ' [ft]'])
disp(['Chord: ', num2str(c), ' [ft]'])
disp(' ')




