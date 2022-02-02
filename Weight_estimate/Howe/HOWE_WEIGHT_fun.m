function [Howe_weight,Wcomp_howe] = HOWE_WEIGHT_fun(MTOW,Ltot,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% L = is the overall fuselage length (aft of the engine bulkhead when a nose propeller engine is used), m
% B = is the maximum width of the fuselage. m
% H = is the maximum height of the fuselage. m
% v_d = is the design maximum (diving) speed. m/s (EAS)
% AR = aspect ratio
% S = wing area
% sweep_eff = sweep angle
% lambda: ratio of tip to centerline chord 
% N_bar: 1.65 times the limit maximum maneuver acceleration
% t_c: thickness 10 chord ratio at wing centerline

% Model as general aviation aircraft for all tables, constants, factors 

% M_0:is the tolal aircraft mass or MTOW for us
% MTOW = M_fixed + M_variable;


% M_fixed = M_fus + M_pay + M_op;
% M_fus: fuesalage mass 
% M_pay: payload mass
% M_op: operational items i.e passangers etc  


% M_variable = M_liftsurf + M_powerplant + M_sys + M_fuel;

% M_liftsur: mass of lifting surfaces 
% M_sys:  is the mass of the airframe system. equipment, landing gear, etc. , not included in Mpay but see Table 6.9

% --------------- Fuel Mass ----------------------

% M_fuel: mass of fuel but we chose our own 
% M_fuel = ;
% --------------- Fuesalage Mass ----------------------
MTOW=MTOW/2.2052;
% Fuesalage Mass Coeff. = C2 
% C2 = 0.06-0.04;
C2 = 0.05;

% p = is the cabin maximum working differential pressure. bar
% L = is the overall fuselage length (aft of the engine bulkhead when a nose propeller engine is used), m
% B = is the maximum width of the fuselage. m
% H = is the maximum height of the fuselage. m
% Vd = is the design maximum (diving) speed. m/s (EAS)

% note: intakes may be short enough to not drive B+H
M_fus = C2*(((Ltot/3.281)*((pi*((fuse_width/3.281)+(fuse_height/3.281)))/2))*((v_d/1.994)^0.5))^1.5; % kg 


% --------------- Operational Mass ----------------------
 

% if you want passanger approach i.e cessna do this: 

% P is the number of passengers
% nc is the number of crew
% F_op' is the operating items factor and is 7 for short haul, 12 for
% medium range, 16 for very long range 
F_op = 7;
n_c = 1; % make it one to not over shoot
P = 1; % to not overshoot 
M_op = 85*n_c + (F_op * P); %kg


% ---------------Lifting Surfaces Mass ----------------------
A1 = 2.0; % multiplied by 10^3
B1 = 100; % multiplied by 10^6
% Typical C1 for general aviation canti. beam: 0.00183
C1 = A1 - B1*(MTOW*10^-3);
C1 = 0.00183;

M_liftsurf = C1*((AR^0.5)*((S/10.764)^1.5)*secd(sweep)*((1+ 2*lambda)/(3 + 3*lambda)) ...
             * (MTOW/S)*N_bar^(0.3) * (v_d/t_c)^0.5)^(0.9); % kg
 
% Ar: Wing aspect ratio 
% S: wing area, m2
% sweep_eff: effective sweep 
% lambda: ratio of tip to centerline chord 
% N_bar: 1.65 times the limit maximum manoeuvre acceleration
% V_d: design maximum (diving) speed, (EAS) 
% t_c: thickness 10 chord ratio al wing centreline

% --------------- Powerplant Mass ----------------------   
% For general aviation, twin piston aircraft 
C3 = 1.8;



P_W_eng = 0.057*(1+0.006); % kW/N

W_eng_P = 1/P_W_eng; % N/kW
Power = 119.312; %kw, from DR2
% Power = 25.81601; %kw, from DR2
W_eng = W_eng_P*Power;
M_eng = W_eng/9.81; %kg

% M_powerplant = C3*M_eng;

% --------------- Systems Mass ---------------------- 
% General aviation light single-engined types
C4 = 0.12; 
M_sys = C4*MTOW;

% --------------- Fuel Depends On Performance  ---------------------- 

% C5 = mass of all lifting surfaces / mass of wing 

% C5 = 1.24

% solve for mass of lifting surfaces if important to us but 
% should be included in lifting surfaces mass calcs 

% M_variable = M_liftsurf  + M_sys;
% 
% M_fixed = M_fus + M_pay + M_op;
% 
% MTOW = M_fixed + M_variable;

Howe_weight=(M_liftsurf+M_sys+M_fus)*2.205;
Wcomp_howe(:,1)=["Lifting SUrface";"System";"Fuselage";"Airframe Total"];
Wcomp_howe(:,2)=[M_liftsurf;M_sys;M_fus;Howe_weight(end)];

end

