% Johnathan Shaw
% AERO 444-01
% Raymer Weight Estimation

clc
clear
close all

%% Notes
%{
This script calculates the weight of an aircraft using 
%}

%%  Inputs

S = 38.67;  % wing planform area (ft^2)
Wfuel = 56; % weight of fuel in wings (lb)
AR = 16;    % wing aspect ratio
sweep = 0;  % wing sweep (degrees)
q = 72.03;  % dynamic pressure @ 7000ft and 163 kts EAS
taper = 0.5;    % wing taper raio (ratio of tip chord to root chord)
t_c = 0.12; % airfoil thickness ratio
N_z = 1.5;  % ultimate load factor
MTOW = 425; % maximum takeoff weight
S_h =6.2;   % horizontal tail planform area (ft^2)
S_v = 6.35; % vertical tail planform area (ft^2)
S_f = 46.44;    % fuselage wetted area
L_t = 6.25;  %   tail length; wing quarter-MAC to tail quarter-MAC (ft)
L_D = 14.75; %   lift over drag ratio
sweep_ht = 0;   % sweep horizontal tail
taper_ht = 0.8; % horizontal tail taper ratio
H_tv = 1.0; % coefficent for vertical tail weight, = 1.0 for "T" tail
sweep_vt = 10;  % vertical tail sweep (degrees)
taper_vt = 0.8; % vertical tail taper ratio
N_l = 3;    % ultimate landing load factor (N_gear*1.5)
W_l = 397;  %   landing gross weight (MTOW - 0.5*fuel weight)
L_sm = 18;   %   extended length of main landing gear (in)
L_sn = 15;   %   extended nose gear length (in)
W_payload = 33; % payload weight (lb)
%% Weight estimation loop
[W_wing(1)] = raymer_wing(S,Wfuel,AR,sweep,q,taper,t_c,N_z,MTOW);
[W_ht(1)] = raymer_ht(N_z,MTOW,q,S_h,t_c,sweep,AR,sweep_ht,taper_ht);
[W_vt(1)] = raymer_vt(H_tv,N_z,MTOW,q,S_v,t_c,sweep_vt,AR,taper_vt);
[W_fuse(1)] = raymer_fuse(S_f,N_z,MTOW,L_t,L_D,q);
[W_main,W_nose(1)] = raymer_lg(N_l,W_l,L_sm,L_sn);
MTOW(1) = 425;
i = 1;
tol = 1;
while abs(tol) > (0.01)
   [W_wing(i+1)] = raymer_wing(S,Wfuel,AR,sweep,q,taper,t_c,N_z,MTOW(i));
   [W_ht(i+1)] = raymer_ht(N_z,MTOW(i),q,S_h,t_c,sweep,AR,sweep_ht,taper_ht);
   [W_vt(i+1)] = raymer_vt(H_tv,N_z,MTOW(i),q,S_v,t_c,sweep_vt,AR,taper_vt);
   [W_fuse(i+1)] = raymer_fuse(S_f,N_z,MTOW(i),L_t,L_D,q);
   [W_main(i+1),W_nose(i+1)] = raymer_lg(N_l,W_l,L_sm,L_sn);
   
   MTOW(i+1) = W_wing(i+1) + W_ht(i+1) + W_vt(i+1) + W_fuse(i+1)...
       + W_main(i+1) + W_nose(i+1) + Wfuel + W_payload;
   tol = (MTOW(i+1)-MTOW(i))/MTOW(i);
   i = i + 1;
end

W_empty = MTOW - Wfuel; %   Note this does not include engine or avionics
%% Functions
function [W_aircraft] = raymer_weight(S_w,W_fw,A,sweep,q,taper,t_c,N_z,W_dg,...
    S_ht,sweep_ht,taper_ht,H_tv,S_vt,sweep_vt,taper_vt,S_f,L_t,...
    L_D,N_l,W_l,L_m,L_n)
% Daniel Raymer method for estimating aircraft weight
%   See functions below for details
[W_wing] = raymer_wing(S_w,W_fw,A,sweep,q,taper,t_c,N_z,W_dg);
[W_ht] = raymer_ht(N_z,W_dg,q,S_ht,t_c,sweep,A,sweep_ht,taper_ht);
[W_vt] = raymer_vt(H_tv,N_z,W_dg,q,S_vt,t_c,sweep_vt,A,taper_vt);
[W_fuse] = raymer_fuse(S_f,N_z,W_dg,L_t,L_D,q);
[W_main,W_nose] = raymer_lg(N_l,W_l,L_m,L_n);

W_aircraft = W_wing + W_ht + W_vt + W_fuse + W_main + W_nose;

function [W_wing] = raymer_wing(S_w,W_fw,A,sweep,q,taper,t_c,N_z,W_dg)
% Raymer method for calculating wing weight
%   W_wing = wing weight
%   S_w = wing planform area
%   W_fw = weight of fuel in the wings
%   A = aspect ratio
%   sweep = wing sweep
%   q = dynamic pressure
%   taper = wing taper ratio
%   t_c = thickness ratio of airfoil
%   N_z = ultimate load factor
%   W_dg = flight design gross weight, lb
%   ignore the second term if Wfw = 0
W_wing = 0.36*S_w^0.758*W_fw^0.0035*((A/cos(sweep)^2)^0.6)*q^0.006*...
    (taper^0.04)*(100*t_c/cos(Lambda))^(-0.3)*(N_z*W_dg)^0.49;
end

function [W_ht] = raymer_ht(N_z,W_dg,q,S_ht,t_c,sweep,A,sweep_ht,taper_ht)
% Raymer method for calculating horizontal tail weight
%   W_horizontal = horizontal tail weight
%   N_z = ultimate load factor
%   W_dg = flight design gross weight, lb
%   q = dynamic pressure
%   S_ht = horizontal wing planform area
%   t_c = wing airfoil thickness ratio
%   sweep = wing sweep
%   A = aspect ratio of wing
%   sweep_ht = horizontal tail sweep
%   taper_ht = horizontal tail taper ratio
W_ht = 0.016*(N_z*W_dg)^0.414*q^0.168*S_ht^0.896*(100*(t_c)/...
    cos(sweep))^-0.12*(A/cos(sweep_ht))^0.043*taper_ht^-0.02;
end

function [W_vt] = raymer_vt(H_tv,N_z,W_dg,q,S_vt,t_c,sweep_vt,A,taper_vt)
% Raymer method for calculating vertical tail weight
%   W_vt = vertical tail weight
%   H_tv = 0.0 for conventional tail; 1.0 for "T" tail
%   N_z = ultimate load factor
%   W_dg = flight design gross weight, lb
%   q = dynamic pressure
%   S_vt = planform area of vertical tail
%   t_c = wing thickness ratio
%   sweep_vt = vertical tail sweep angle
%   A = wing aspect ratio
%   taper_vt = vertical tail taper ratio
%   If taper_vt is less that 0.2, use 0.2
a = 0.073*(1 + 0.2*H_tv);
b = (N_z*W_dg)^0.376;
c = q^0.122;
d = S_vt^0.873;
e = (100*t_c/cosd(sweep_vt));
f = (A/(cosd(sweep_vt)^2));
g = taper_vt^0.039;
W_vt = a*b*c*d*e^-0.49*(f^0.357)*g;
end

function [W_fuse] = raymer_fuse(S_f,N_z,W_dg,L_t,L_D,q)
% Raymer method for calculating fuselage weight
%   S_f = surface area of the fuselage
%   N_z = ultimate load factor
%   W_dg = flight design gross weight, lb
%   L_t = tail length; wing quarter-MAC to tail quarter-MAC, ft
%   L_D = L/D of aircraft
%   q = dynamic pressure
W_fuse = 0.052*S_f^1.086*(N_z*W_dg)^0.177*L_t^-0.051*(L_D)^-0.072*q^0.241;
end

function [W_main,W_nose] = raymer_lg(N_l,W_l,L_m,L_n)
% Raymer method for calculating landing gear weight
%   W_main = weight of the main landing gear
%   W_nose = weight of the nose landing gear
%   N_l = ultimate landing load factor; - Ngear*1.5
%   W_l = landing design gross weight, lb
%   L_m = extended length of main gear, in
%   L_n = extended nose gear length, in
%   reduce total landing gear weight by 1.4% of TOGW if nonretractable
W_main = 0.095*(N_l*W_l)^0.768*(L_m/12)^0.409;
W_nose = 0.125*(N_l*W_l)^0.566*(L_n/12)^0.845;
end

end

