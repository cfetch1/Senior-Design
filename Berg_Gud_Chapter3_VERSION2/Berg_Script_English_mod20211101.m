% Constraint Diagram
% Script
% Gudmundsson Chapter 3

clear
close all
clc

q = @(rho, V) (1/2)*rho*V^2;

%% Constant Variables
WS = 5:1:20; % Wing Loading vector used in all function calculations (arbitrary)
CDmin = 0.028; % Gudmundsson, page 62
CD_to = 0.038; % Gudmundsson, page 62 - assumes flaps in TO
CL_to = 0.7; % Gudmundsson, page 62,  business jet CLto approximately 0.8   % Assumes flaps in TO
AR = 14;
e = 1.78*(1-0.045*AR^0.68)-0.64;
k = 1/(pi*AR*e);

%% Level Constant Velocity Turn
V.turn = 120;
h.turn = 5000;
[rho.turn] = rho_us(h.turn);
q_turn = q(rho.turn, V.turn); % Dynamic Pressure at selected airspeed and altitude (lbf/ft2 or N/m2)
n = 1.8; % load factor, = 1/cos(phi)

[TW_lcvt] = Level_Constant_Velocity_Turn(WS,CDmin, k, q_turn, n);
plot(WS,TW_lcvt);
hold all

%% Desired Climb Rate
V.climb = 80; % Airspeed
h.climb = 0;
[rho.climb] = rho_us(h.climb);
q_climb = q(rho.climb, V.climb); % Dynamic Pressure at selected airspeed and altitude (lbf/ft2 or N/m2)
Vv = 60/60; % Vertical climb rate speed

[TW_dcr] = Desired_Climb_Rate(WS,Vv, V.climb, q_climb, CDmin, k);
plot(WS,TW_dcr);

%% Desired Takeoff Distance
V.lof = 60; % Liftoff Speed
h.lof = 0;
[rho.lof] = rho_us(h.lof);
q_to = q(rho.lof, V.lof/sqrt(2)); % Dynamic Pressure at V_lof / sqrt(2) and selected altitude
g = 32.2; % gravity
Sg = 3800; % ground run
mu = 0.04; % ground coefficient constant

[TW_dtod] = Desired_Takeoff_Distance(WS, V.lof, g, Sg, q_to, CD_to, mu, CL_to);
plot(WS, TW_dtod);

%% Desired Cruise Airspeed
V.cruise = 120; % Airspeed, ft/s
h.cruise = 10000;
[rho.cruise] = rho_us(h.cruise);
q_cruise = q(rho.cruise, V.cruise); % dynamic pressure at the selected airspeed and altitude

[TW_dca] = Desired_Cruise_Airspeed(WS, q_cruise, CDmin, k);
plot(WS, TW_dca);

%% Service Ceiling
Vv = 1.667; % ft/s,  this is if service ceiling is defined as point where climb rate is 100 ft/min, Vertical climb rate speed
h.serv_ceil = 12000;
[rho.serv_ceil] = rho_us(h.serv_ceil);
rho_sc = rho.serv_ceil;

[TW_sc] = Service_Ceiling(WS, Vv, rho_sc, k, CDmin);
plot(WS, TW_sc);
xlabel('Wing Loading')
ylabel('Thrust to Weight')

%% Plot and table
legend("Level Constant-Velocity Turn", ...
    "Desired Climb Rate",... 
    "Desired Takeoff Distance",...
    "Desired Cruise Airspeed",...
    "Service Ceiling");

Constraints = table(WS', TW_dca', TW_dcr', TW_dtod', TW_lcvt', TW_sc');
Constraints.Properties.VariableNames = {'W/S','Desired Cruise Altititude','Desired Climb Rate','Desired Takeoff Distance','Level Constant-Velocity Turn', 'Service Ceiling'};
disp(Constraints);

disp('Altitudes (ft)');
% disp('1 m = 3.28 ft');
disp(h);
fprintf('\n');

disp('Speeds (/s)');
disp('1 ft/s = 0.6 mph');
disp(V);




