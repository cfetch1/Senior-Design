function [W_aircraft,Wcomp] = raymer_weight(S,Wfuel,AR,sweep,lambda,t_c,MTOW,S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z)
% Daniel Raymer method for estimating aircraft wei
%   See functions below for details

N_l=3;
W_l=MTOW-Wfuel;


[W_wing] = raymer_wing(S,Wfuel,AR,sweep,q,lambda,t_c,N_z,MTOW);
[W_ht] = raymer_ht(N_z,MTOW,q,S_h,t_c,sweep,AR,sweep_ht,taper_ht);
[W_vt] = raymer_vt(N_z,MTOW,q,S_v,t_c,sweep_vt,AR,taper_vt);
[W_fuse] = raymer_fuse(S_f,N_z,MTOW,lt,L_D,q);
[W_main,W_nose] = raymer_lg(N_l,W_l,L_sm,L_sn);
W_aircraft = W_wing + W_ht + W_vt + W_fuse + W_main + W_nose;
Wcomp(:,1)=["Wing";"HT";"VT";"Fuselage";"MLG";"NLG";"Airframe Total"];
Wcomp(:,2)=[W_wing;W_ht;W_vt;W_fuse;W_main;W_nose;W_aircraft(end)];


end

function [W_wing] = raymer_wing(S,Wfuel,AR,sweep,q,lambda,t_c,N_z,MTOW)
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

W_wing = 0.036*(S^0.758)*(Wfuel^0.0035)*((AR/cosd(sweep)^2)^0.6)*(q^0.006)*...
    (lambda^0.04)*((100*t_c/cosd(sweep))^(-0.3))*((N_z*MTOW)^0.49);
end
function [W_ht] = raymer_ht(N_z,MTOW,q,S_h,t_c,sweep,AR,sweep_ht,taper_ht)
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
W_ht = 0.016*((N_z*MTOW)^0.414)*(q^0.168)*(S_h^0.896)*((100*(t_c)/...
    cosd(sweep))^-0.12)*((AR/(cosd(sweep_ht)^2))^0.043)*(taper_ht^-0.02);
end
function [W_vt] = raymer_vt(N_z,MTOW,q,S_v,t_c,sweep_vt,AR,taper_vt)
% Raymer method for calculating vertical tail weight
%   W_vt = vertical tail weight
%   H_tv = 0.0 for conventional tail; 1.0 for "T" tail
Ht_Hv=1;
%   N_z = ultimate load factor
%   W_dg = flight design gross weight, lb
%   q = dynamic pressure
%   S_vt = planform area of vertical tail
%   t_c = wing thickness ratio
%   sweep_vt = vertical tail sweep angle
%   AR = wing aspect ratio
%   taper_vt = vertical tail taper ratio
%   If taper_vt is less that 0.2, use 0.2
W_vt = 0.073*(1 + 0.2*Ht_Hv)*((N_z*MTOW)^0.376)*(q^0.122)*(S_v^0.873)*...
    ((100*t_c/cosd(sweep_vt))^-0.49)*((AR/cosd(sweep_vt)^2)^0.357)*(taper_vt^0.039);
end
function [W_fuse] = raymer_fuse(S_f,N_z,MTOW,lt,L_D,q)
% Raymer method for calculating fuselage weight
%   S_f = surface area of the fuselage
%   N_z = ultimate load factor
%   W_dg = flight design gross weight, lb
%   L_t = tail length; wing quarter-MAC to tail quarter-MAC, ft
%   L_D = L/D of aircraft
%   q = dynamic pressure
W_fuse = 0.052*S_f^1.086*(N_z*MTOW)^0.177*lt^-0.051*(L_D)^-0.072*q^0.241;
end
function [W_main,W_nose] = raymer_lg(N_l,W_l,L_sm,L_sn)
% Raymer method for calculating landing gear weight
%   W_main = weight of the main landing gear
%   W_nose = weight of the nose landing gear
%   N_l = ultimate landing load factor; - Ngear*1.5
%   W_l = landing design gross weight, lb
%   L_m = extended length of main gear, in
%   L_n = extended nose gear length, in
%   reduce total landing gear weight by 1.4% of TOGW if nonretractable
W_main = 0.095*(N_l*W_l)^0.768*(L_sm)^0.409;
W_nose = 0.125*(N_l*W_l)^0.566*(L_sn)^0.845;
W_nose=W_nose+(.14*.25*W_nose);
end




